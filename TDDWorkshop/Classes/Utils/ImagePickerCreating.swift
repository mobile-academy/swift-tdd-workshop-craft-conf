//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
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
