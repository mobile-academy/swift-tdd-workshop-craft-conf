//
// Copyright (c) 2017 Mobile Academy. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ApplicationConfigurator {

    func configure(_ application: UIApplication) {
        guard !isRunningSpecs else { return }
        MobileAcademyStyleSheet.applyStyle()
        FIRApp.configure()
    }

    private var isRunningSpecs: Bool {
        return NSClassFromString("XCTest") != nil
    }
}
