//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class UITableViewFake: UITableView {

    var reloadDataCalled = false

    override func reloadData() {
        reloadDataCalled = true
    }

}
