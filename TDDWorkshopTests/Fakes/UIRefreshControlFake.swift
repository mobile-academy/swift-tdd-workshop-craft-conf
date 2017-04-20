//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class UIRefreshControlFake: UIRefreshControl {

    var endRefreshingCalled = false

    override func endRefreshing() {
        endRefreshingCalled = true
    }

}
