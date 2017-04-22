//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class UICollectionViewFake: UICollectionView {

    var reloadDataCalled = false

    override func reloadData() {
        reloadDataCalled = true
    }

}
