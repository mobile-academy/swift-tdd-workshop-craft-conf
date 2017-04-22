//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

protocol ParseAdapting {} //TODO this is temporary

class StreamItemUploader: ItemUploading {

    let parseAdapter: ParseAdapting
    var transformer = StreamItemTransformer()

    // MARK: Object Life Cycle

    init (parseAdapter: ParseAdapting) {
        self.parseAdapter = parseAdapter
    }

    // MARK: ItemUploading

    func uploadItem(_ streamItem: StreamItem, completion: @escaping (Bool, Error?) -> ()) {
        //TODO fix me using Firebase!
        //        let parseObject = transformer.parseObjectFromStreamItem(streamItem)
        //        parseAdapter.uploadObject(parseObject, completion: completion)
    }
}
