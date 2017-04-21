//
// Copyright (©) 2016 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    class var greyColor: UIColor {
        return UIColor(red: 52/255, green: 52/255, blue: 53/255, alpha: 1.0)
    }

    class var teal: UIColor {
        return UIColor(red: 66/255, green: 177/255, blue: 211/255, alpha: 1.0)
    }

    class var maGrey: UIColor {
        return UIColor(red: 62/255, green: 160/255, blue: 183/255, alpha: 1.0)
    }
}


class MobileAcademyStyleSheet {
    static func applyStyle() {
        UINavigationBar.appearance().barTintColor = .teal
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        UINavigationBar.appearance().tintColor = .white

        UITabBar.appearance().barTintColor = .maGrey
        UITabBar.appearance().tintColor = .white

        UISegmentedControl.appearance().tintColor = .teal
    }
}
