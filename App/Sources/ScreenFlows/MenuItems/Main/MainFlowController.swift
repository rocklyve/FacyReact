//
//  Created by David Laubenstein on 15.04.19.
//  Copyright © 2019 DavidLaubenstein. All rights reserved.
//

import AnyMenu
import Imperio
import UIKit

class MainFlowController: InitialFlowController {
    private var navigationCtrl: UINavigationController?

    private var anyMenuViewCtrl: AnyMenuViewController?

    lazy var mainViewCtrl: MainViewController = {
        let viewCtrl = MainViewController()
        viewCtrl.flowDelegate = self
        return viewCtrl
    }()

    func start(fromInOut window: inout UIWindow?) {
        super.start(from: window!)

        let menuViewCtrl = MenuViewController()
        menuViewCtrl.flowDelegate = self

        navigationCtrl = UINavigationController(rootViewController: mainViewCtrl)
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
        let manualConnectionFlowCtrl = ManualConnectionFlowController()
        add(subFlowController: manualConnectionFlowCtrl)
        manualConnectionFlowCtrl.start(from: navigationCtrl!)
    }

    func didPrepareGameStart() {
        // TODO: Start timer
        GameTimer.global.flowDelegate = self
        GameTimer.global.startTimer()

        Game.shared.newRandomCurrentState()
        mainViewCtrl.gameActionLabel.isHidden = false
        mainViewCtrl.gameActionLabel.text = Game.shared.getCurrentStateAsString()
    }

    func prepareGameStart() {
        mainViewCtrl.startAnimation()
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

extension MainFlowController: GameTimerDelegate {
    func timerHasEnded() {
        // put button back to normal position
        mainViewCtrl.startPlayButton.setTitle("retry", for: .normal)
        mainViewCtrl.gameActionLabel.isHidden = true
        // text should be displayed as "retry"
    }

    func timeLeft(timeLeft: Int) {
        mainViewCtrl.startPlayButton.setTitle("\(timeLeft)", for: .normal)
    }
}
