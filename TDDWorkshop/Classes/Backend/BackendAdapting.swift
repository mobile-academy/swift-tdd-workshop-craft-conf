//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

typealias BackendObject = [String: Any]

enum BackendResult<T> where T: BackendObjectTransformable {
    case success([T])
    case failure(Error)
}

protocol BackendAdapting {
    func write(_ object: BackendObjectTransformable)
    func readObjects<T>(ofType objectType: T.Type,
                        completion: @escaping (BackendResult<T>) -> ()) where T: BackendObjectTransformable
}