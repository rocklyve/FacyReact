//
//  Created by David Laubenstein on 15.04.19.
//  Copyright © 2019 DavidLaubenstein. All rights reserved.
//

import Imperio
import UIKit

class MainFlowController: InitialFlowController {
    private lazy var navigationCtrl = UINavigationController(rootViewController: mainViewCtrl)

    lazy var mainViewCtrl: MainViewController = {
        let viewCtrl = MainViewController()
        viewCtrl.flowDelegate = self
        return viewCtrl
    }()

    override func start(from window: UIWindow) {
        window.rootViewController = navigationCtrl
    }
}

extension MainFlowController: MainFlowDelegate {
    func connectBleDevice() {
        let manualConnectionFlowCtrl = ManualConnectionFlowController()
        add(subFlowController: manualConnectionFlowCtrl)
        manualConnectionFlowCtrl.start(from: navigationCtrl)
    }

    func didPrepareGameStart() {
        // TODO: Start timer
        if mainViewCtrl.startPlayButton.currentTitle == "Retry" {
            GameTimer.global.resetTimer()
            DispatchQueue.main.async {
                self.mainViewCtrl.gameCounterLabel.text = "0"
                self.mainViewCtrl.gameCounterLabel.layoutIfNeeded()
            }
        } else {
            GameTimer.global.flowDelegate = self
        }
        mainViewCtrl.startPlayButton.isUserInteractionEnabled = false
        Game.shared.start()
        // show current action, will be hidden, when ble is activated
        if !BluetoothConnector.global.isConnected {
            mainViewCtrl.gameActionLabel.isHidden = false
        }
        mainViewCtrl.gameActionLabel.text = Game.shared.getCurrentStateAsString()
    }

    func prepareGameStart() {
        mainViewCtrl.startAnimation()
    }

    func settings() {
        let settingsFlowCtrl = SettingsFlowController()
        add(subFlowController: settingsFlowCtrl)
        settingsFlowCtrl.start(from: navigationCtrl)
    }
}

extension MainFlowController: GameTimerDelegate {
    func timerHasEnded() {
        // put button back to normal position
        mainViewCtrl.gameActionLabel.isHidden = true
        // TODO: move button back to normal position
        mainViewCtrl.resetAnimation()
        mainViewCtrl.startPlayButton.isUserInteractionEnabled = true
    }

    func timeLeft(timeLeft: Int) {
        mainViewCtrl.startPlayButton.setTitle("\(timeLeft)", for: .normal)
    }
}
