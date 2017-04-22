//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation
@testable import TDDWorkshop

class BackendAdapterFake: BackendAdapting {
    func write(_ object: BackendObjectTransformable) {
    }

    func readObjects<T>(ofType objectType: T.Type,
                        completion: @escaping (BackendResult<T>) -> ()) where T: BackendObjectTransformable {
    }
}
