//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation
@testable import TDDWorkshop

class RemoteStorageFake: RemoteDataStoring {

    var uploadCalled = false
    var capturedData: Data?
    var capturedIdentifier: String?
    var capturedCompletion: ((URL?) -> ())?

    func upload(_ data: Data, identifiedBy name: String, completion: @escaping (URL?) -> ()) {
        uploadCalled = true
        capturedData = data
        capturedIdentifier = name
        capturedCompletion = completion
    }

    func downloadData(identifiedBy name: String, from: URL, completion: @escaping (Data?) -> ()) {
    }
}
