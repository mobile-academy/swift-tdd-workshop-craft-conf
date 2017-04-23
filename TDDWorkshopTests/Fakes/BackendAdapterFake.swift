//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation
@testable import TDDWorkshop

class BackendAdapterFake: BackendAdapting {

    var writeCalled = false
    var capturedObject: BackendObjectTransformable?

    var readObjectsCalled = false
    var simulateSuccess: (() -> ())?
    var simulateFailure: (() -> ())?

    func write(_ object: BackendObjectTransformable) {
        writeCalled = true
        capturedObject = object
    }

    func readObjects<T>(ofType objectType: T.Type,
                        completion: @escaping (BackendResult<T>) -> ()) where T: BackendObjectTransformable {
        readObjectsCalled = true

        simulateSuccess = {
            completion(.success([]))
        }
        simulateFailure = {
            completion(.failure(NSError(domain: "Foo", code: -1)))
        }
    }
}
