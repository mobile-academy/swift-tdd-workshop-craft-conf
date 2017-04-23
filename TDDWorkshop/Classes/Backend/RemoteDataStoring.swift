//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

protocol RemoteDataStoring {
    func upload(_ data: Data, identifiedBy name: String, completion: @escaping (URL?) -> ())

    func downloadData(identifiedBy name: String, from: URL, completion: @escaping (Data?) -> ())
}
