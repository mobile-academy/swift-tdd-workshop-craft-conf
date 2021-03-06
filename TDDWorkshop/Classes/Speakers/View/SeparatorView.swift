//
// Copyright (©) 2017 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class SeparatorView: UICollectionReusableView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .barsBackgroundTint
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
