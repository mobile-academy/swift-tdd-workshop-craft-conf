//
// Copyright (c) 2015 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

@testable
import TDDWorkshop

class ViewControllerPresenterFake: ViewControllerPresenting {

    var capturedPresentedViewController: UIViewController?
    var capturedDismissedViewController: UIViewController?

    //MARK: ViewControllerPresenter

    weak var viewController: UIViewController?

    func presentViewController(_ viewController: UIViewController) {
        capturedPresentedViewController = viewController
    }

    func dismissViewController(_ viewController: UIViewController) {
        capturedDismissedViewController = viewController
    }

}
