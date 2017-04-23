//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation
import Firebase

class FirebaseAdapter: BackendAdapting {

    fileprivate lazy var databaseReference = FIRDatabase.database().reference()

    func write(_ object: BackendObjectTransformable) {
        databaseReference.child(type(of: object).name).child(object.identifier).setValue(object.transformToBackendObject())
    }

    func readObjects<T>(ofType objectType: T.Type, completion: @escaping (BackendResult<T>) -> ()) where T: BackendObjectTransformable {
        databaseReference.child(objectType.name).observeSingleEvent(of: .value, with: { snapshot in
            var objects: [T] = []
            guard let result = snapshot.value! as? BackendObject else {
                completion(.success(objects))
                return
            }
            for (identifier, dict) in result {
                if let backendObject = dict as? BackendObject,
                   var object = objectType.init(backendObject: backendObject) {
                    object.identifier = identifier
                    objects.append(object)
                }
            }
            completion(.success(objects))
        }) { error in
            completion(.failure(error))
        }
    }

}
