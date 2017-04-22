//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

class StreamItemDownloader: ItemDownloading {

    let backendAdapter: BackendAdapting
    let remoteStorage: RemoteDataStoring

    lazy var cache = DataCache(directoryName: "StreamItem")

    init(backendAdapter: BackendAdapting, remoteStorage: RemoteDataStoring) {
        self.backendAdapter = backendAdapter
        self.remoteStorage = remoteStorage
    }

    func downloadItems(_ completion: @escaping ([StreamItem]?, Error?) -> ()) {
        backendAdapter.readObjects(ofType: StreamItem.self) { result in
            switch result {
            case .success(let objects):
                completion(objects, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    func downloadImage(for item: StreamItem, completion: @escaping () -> ()) {
        if let imageData = cache.data(identifiedBy: item.identifier) {
            item.imageData = imageData
            completion()
        } else if let url = item.imageURL {
            remoteStorage.downloadData(identifiedBy: item.identifier, from: url) { [weak self] data in
                if let data = data {
                    self?.cache.save(data, identifiedBy: item.identifier)
                    item.imageData = data
                }
                completion()
            }
        } else {
            completion()
        }
    }
}
