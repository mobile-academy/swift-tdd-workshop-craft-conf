//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

protocol AlertActionCreating {
    func createActionWithTitle(_ title: String, style: UIAlertActionStyle, handler: @escaping (UIAlertAction) -> ()) -> UIAlertAction
}

class DefaultAlertActionFactory: AlertActionCreating {
    func createActionWithTitle(_ title: String, style: UIAlertActionStyle, handler: @escaping (UIAlertAction) -> ()) -> UIAlertAction {
        return UIAlertAction(title: title, style: style, handler: handler)
    }
}
