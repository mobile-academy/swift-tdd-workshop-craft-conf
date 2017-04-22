//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation
import Firebase

class FirebaseDataStorage: RemoteDataStoring {
    fileprivate lazy var storageReference = FIRStorage.storage().reference()
    let maxDownloadSize: Int64 = 1 * 1024 * 1024

    func upload(_ data: Data, identifiedBy name: String, completion: @escaping (URL?) -> ()) {
        let dataReference = storageReference.child(name)
        dataReference.put(data, metadata: nil) { metadata, error in
            guard let metadata = metadata else {
                completion(nil)
                return
            }
            completion(metadata.downloadURL())
        }
    }

    func downloadData(identifiedBy name: String, from: URL, completion: @escaping (Data?) -> ()) {
        let dataReference = storageReference.child(name)
        dataReference.data(withMaxSize: maxDownloadSize) { data, error in
            if let _ = error {
                completion(nil)
            } else {
                completion(data!)
            }
        }
    }
}
