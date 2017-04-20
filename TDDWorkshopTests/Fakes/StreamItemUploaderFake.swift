//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
@testable
import TDDWorkshop

class StreamItemUploaderFake: ItemUploading {

    var uploadItemCalled = false
    var capturedCompletion: ((Bool, Error?) -> ())?

    func uploadItem(_ streamItem: StreamItem, completion: @escaping (Bool, Error?) -> ()) {
        uploadItemCalled = true
        capturedCompletion = completion
    }

}
