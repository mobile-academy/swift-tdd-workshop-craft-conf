//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation

@testable
import TDDWorkshop

class TestStreamItemCreatorDelegate: ItemCreatingDelegate {

    var capturedStreamItem: StreamItem?
    var capturedError: Error?

    // MARK: ItemCreatingDelegate

    func creator(_ creator: ItemCreating, didCreateItem item: StreamItem) {
        capturedStreamItem = item
    }

    func creator(_ creator: ItemCreating, failedWithError error: Error) {
        capturedError = error
    }

}
