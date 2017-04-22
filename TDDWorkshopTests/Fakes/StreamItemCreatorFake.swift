//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

@testable
import TDDWorkshop

class StreamItemCreatorFake: ItemCreating {

    weak var delegate: ItemCreatingDelegate?

    var createItemCalled = false

    func createStreamItem() {
        createItemCalled = true
    }

}
