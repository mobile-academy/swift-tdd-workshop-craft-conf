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
        //TODO fix me using Firebase!
        //        let parseObject = transformer.parseObjectFromStreamItem(streamItem)
        //        parseAdapter.uploadObject(parseObject, completion: completion)
    }
}
