//
//  Created by Cihat Gündüz on 11.02.19.
//  Copyright © 2019 Jamit Labs GmbH. All rights reserved.
//

import AnyMenu
import Imperio
import UIKit

class MainFlowController: InitialFlowController {
    private var navigationCtrl: UINavigationController?

    private var anyMenuViewCtrl: AnyMenuViewController?

    func start(fromInOut window: inout UIWindow?) {
        super.start(from: window!)

        let menuViewCtrl = MenuViewController()
        menuViewCtrl.flowDelegate = self
        let mainViewCtrl = MainViewController()

        navigationCtrl = UINavigationController(rootViewController: mainViewCtrl)
        mainViewCtrl.flowDelegate = self
        // TODO: NavigationBar is not loaded correctly

        anyMenuViewCtrl = AnyMenuViewController(
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
        anyMenuViewCtrl?.menuShadowColor = .black
        anyMenuViewCtrl?.menuShadowRadius = 40
        anyMenuViewCtrl?.menuShadowOffset = CGSize(width: 0, height: 2)
        anyMenuViewCtrl?.menuShadowOpacity = 0.5

        anyMenuViewCtrl?.present(in: &window)
    }
}

extension MainFlowController: MainFlowDelegate {
    func connectBleDevice() {
        let connectBleDeviceFlowCtrl = ConnectBleDeviceFlowController()
        add(subFlowController: connectBleDeviceFlowCtrl)
        connectBleDeviceFlowCtrl.start(from: navigationCtrl!)
    }
}

extension MainFlowController: MenuFlowDelegate {
    func settings() {
        guard let anyMenuViewCtrl = anyMenuViewCtrl else { return }
        let settingsFlowCtrl = SettingsFlowController()
        add(subFlowController: settingsFlowCtrl)
        settingsFlowCtrl.start(from: anyMenuViewCtrl)
    }
}
