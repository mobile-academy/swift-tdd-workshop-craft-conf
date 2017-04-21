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
        //TODO fix me using Firebase!
        
        //        let query = PFQuery(className:StreamItem.entityName)
        //
        //        parseAdapter.executeQuery(query) {[weak self] objects, error in
        //            guard error == nil,
        //            let parseObjects = objects else  {
        //                completion(nil, error)
        //                return
        //            }
        //            var streamItems = [StreamItem]()
        //            for object in parseObjects {
        //                if let streamItem = self?.transformer.streamItemFromParseObject(object) {
        //                    streamItems.append(streamItem)
        //                }
        //            }
        //            completion(streamItems, nil)
        //        }
    }
}
