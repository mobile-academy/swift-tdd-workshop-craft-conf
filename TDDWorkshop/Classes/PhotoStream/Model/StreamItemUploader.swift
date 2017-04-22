//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

protocol ParseAdapting {} //TODO this is temporary

class StreamItemUploader: ItemUploading {

    let backendAdapter: BackendAdapting
    let remoteStorage: RemoteDataStoring

    var transformer = StreamItemTransformer()

    init (backendAdapter: BackendAdapting, remoteStorage: RemoteDataStoring) {
        self.backendAdapter = backendAdapter
        self.remoteStorage = remoteStorage
    }

    func uploadItem(_ streamItem: StreamItem, completion: @escaping (Bool, Error?) -> ()) {
        if let data = streamItem.imageData {
            remoteStorage.upload(data, identifiedBy: streamItem.identifier) { [weak self] url in
                streamItem.imageURL = url
                self?.backendAdapter.write(streamItem)
                completion(true, nil)
            }
        } else {
            backendAdapter.write(streamItem)
            completion(true, nil)
        }
    }
}
