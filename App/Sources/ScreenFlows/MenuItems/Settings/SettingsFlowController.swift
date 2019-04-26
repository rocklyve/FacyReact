//
//  Created by David Laubenstein on 15.04.19.
//  Copyright © 2019 DavidLaubenstein. All rights reserved.
//

import AnyMenu
import Imperio
import UIKit

class SettingsFlowController: FlowController {
    private lazy var navigationCtrl = UINavigationController(rootViewController: settingsViewCtrl)
    private lazy var settingsViewCtrl: SettingsTableViewController = {
        let settingsTableViewCtrl = SettingsTableViewController()
        settingsTableViewCtrl.flowDelegate = self

        return settingsTableViewCtrl
    }()

    override func start(from presentingViewController: UIViewController) {
        super.start(from: presentingViewController)
        presentingViewController.present(navigationCtrl, animated: true, completion: nil)
    }
}

extension SettingsFlowController: SettingsFlowDelegate {
    func connectWearable() {
        let manualConnectionFlowCtrl = ManualConnectionFlowController()
        add(subFlowController: manualConnectionFlowCtrl)
        manualConnectionFlowCtrl.start(from: navigationCtrl)
    }

    func disconnectWearable() {
        BluetoothConnector.global.disconnect()
    }
}
