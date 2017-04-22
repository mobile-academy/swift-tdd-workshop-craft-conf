//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

@testable
import TDDWorkshop

class SourceTypeAvailabilityFake: SourceTypeAvailability {

    var fakeSources = [UIImagePickerControllerSourceType]()

    func availableSources() -> [UIImagePickerControllerSourceType] {
        return fakeSources
    }


}
