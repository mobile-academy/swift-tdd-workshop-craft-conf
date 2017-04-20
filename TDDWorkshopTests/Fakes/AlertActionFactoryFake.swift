//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

@testable
import TDDWorkshop

class AlertActionFactoryFake: AlertActionCreating {

    var capturedHandlers: [((UIAlertAction) -> ())]
    var capturedActions: [UIAlertAction]

    init() {
        capturedHandlers = []
        capturedActions = []
    }

    func createActionWithTitle(_ title: String, style: UIAlertActionStyle, handler: @escaping (UIAlertAction) -> ()) -> UIAlertAction {
        let action = UIAlertAction(title: title, style: style, handler: handler)
        capturedHandlers.append(handler)
        capturedActions.append(action)
        return action
    }

}
