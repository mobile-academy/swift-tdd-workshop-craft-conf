//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

class StreamItem {
    var title: String
    var imageData: Data

    static let entityName = "StreamItem"

    init(title: String, imageData: Data) {
        self.title = title
        self.imageData = imageData
    }
}

extension StreamItem {
    func image() -> UIImage? {
        return UIImage(data: imageData)
    }
}
