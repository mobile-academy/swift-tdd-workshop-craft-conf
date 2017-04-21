//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

protocol BackendObjectTransformable {

    static var name: String { get }

    var identifier: String { get set }

    init?(backendObject: BackendObject)

    func transformToBackendObject() -> BackendObject
}
