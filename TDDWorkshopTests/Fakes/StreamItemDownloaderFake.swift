//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
@testable
import TDDWorkshop

class StreamItemDownloaderFake: ItemDownloading {
    var capturedCompletion: (([StreamItem]?, Error?) -> ())?
    var downloadItemsCalled : Bool = false
    
    func downloadItems(_ completion: @escaping ([StreamItem]?, Error?) -> ()) {
        capturedCompletion = completion
        downloadItemsCalled = true
    }
}
