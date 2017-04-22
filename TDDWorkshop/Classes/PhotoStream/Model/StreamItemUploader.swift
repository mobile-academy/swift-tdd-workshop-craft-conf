//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

protocol ParseAdapting {} //TODO this is temporary

class StreamItemUploader: ItemUploading {

    let backendAdapter: BackendAdapting
    var transformer = StreamItemTransformer()

    init (backendAdapter: BackendAdapting) {
        self.backendAdapter = backendAdapter
    }

    func uploadItem(_ streamItem: StreamItem, completion: @escaping (Bool, Error?) -> ()) {
        backendAdapter.write(streamItem)
        //TODO listen for updates
        completion(true, nil)
    }
}
