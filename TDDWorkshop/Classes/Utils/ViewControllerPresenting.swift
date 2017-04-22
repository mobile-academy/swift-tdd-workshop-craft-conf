//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

protocol ViewControllerPresenting {

    weak var viewController: UIViewController? {get set}

    func presentViewController(_ viewController: UIViewController)
    func dismissViewController(_ viewController: UIViewController)
}

class DefaultViewControllerPresenter: ViewControllerPresenting {

    weak var viewController: UIViewController?

    func presentViewController(_ viewController: UIViewController) {
        self.viewController?.present(viewController, animated: true, completion: nil)
    }

    func dismissViewController(_ viewController: UIViewController) {
        viewController.dismiss(animated: true, completion: nil)
    }

}
