//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

class StreamItemDownloader: ItemDownloading {

    let backendAdapter: BackendAdapting
    var transformer = StreamItemTransformer()

    init(backendAdapter: BackendAdapting) {
        self.backendAdapter = backendAdapter
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
}
