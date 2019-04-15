//
//  Created by Cihat Gündüz on 26.05.17.
//  Copyright © 2017 DavidLaubenstein. All rights reserved.
//

import Imperio
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - Stored Instance Properties
    var window: UIWindow?
    var initialFlowCtrl: InitialFlowController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        // setup global stuff
        Logger.shared.setup()
        ErrorHandler.shared.setup(window: window!)
        Branding.shared.setup(window: window!)

        // start initial flow
        let mainFlowController = MainFlowController()
        mainFlowController.start(fromInOut: &window)

        initialFlowCtrl = mainFlowController

        return true
    }
}
