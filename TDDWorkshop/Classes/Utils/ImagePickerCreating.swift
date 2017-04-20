//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

protocol ImagePickerCreating {
    func createPickerWithSourceType(_ sourceType: UIImagePickerControllerSourceType) -> UIImagePickerController
}

class DefaultImagePickerFactory: ImagePickerCreating {
    func createPickerWithSourceType(_ sourceType: UIImagePickerControllerSourceType) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        return picker
    }
}
