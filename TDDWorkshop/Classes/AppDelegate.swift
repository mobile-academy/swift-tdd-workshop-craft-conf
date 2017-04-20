//
//  Copyright © 2015 Mobile Academy. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    //MARK: UIApplicationDelegate

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configureApplication(launchOptions)
        return true
    }

    //MARK: Helpers

    func configureApplication(_ launchOptions: [AnyHashable: Any]?) {
        let configurator = Configurator()
        let appConfiguration = ConfigurationFactory().applicationConfiguration()
        configurator.configureApplication(appConfiguration, launchOptions: launchOptions)
    }
}

