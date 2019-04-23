//
//  Created by David on 06.04.2019.
//  Copyright © 2019 DavidLaubenstein. All rights reserved.
//

import AnyMenu
import Imperio
import UIKit

class MainFlowController: InitialFlowController {
    private var navigationCtrl: UINavigationController?
    var mainViewCtrl: MainViewController?

    override func start(from window: UIWindow) {
        mainViewCtrl = MainViewController()

        mainViewCtrl?.flowDelegate = self
        window.rootViewController = mainViewCtrl
    }

    func start(fromInOut window: inout UIWindow?) {
        super.start(from: window!)

        let menuViewCtrl = MenuViewController()
        let mainViewCtrl = MainViewController()

        navigationCtrl = UINavigationController(rootViewController: mainViewCtrl)
        mainViewCtrl.flowDelegate = self
        // TODO: NavigationBar is not loaded correctly

        window?.rootViewController = navigationCtrl

        let anyMenuViewCtrl = AnyMenuViewController(
            menuViewController: menuViewCtrl,
            contentViewController: navigationCtrl!,
            menuOverlaysContent: false,
            animation: MenuAnimation(
                duration: 0.5,
                menuViewActions: [],
                contentViewActions: [
                    .translate(x: UIScreen.main.bounds.width - 100, y: 0),
                    .scale(x: 0.9, y: 0.9)
                ],
                timingParameters: UICubicTimingParameters(animationCurve: .easeInOut)
            )
        )
        anyMenuViewCtrl.menuShadowColor = .black
        anyMenuViewCtrl.menuShadowRadius = 40
        anyMenuViewCtrl.menuShadowOffset = CGSize(width: 0, height: 2)
        anyMenuViewCtrl.menuShadowOpacity = 0.5

        anyMenuViewCtrl.present(in: &window)
    }
}

extension MainFlowController: MainFlowDelegate {
    // TODO: not yet implemented
}
