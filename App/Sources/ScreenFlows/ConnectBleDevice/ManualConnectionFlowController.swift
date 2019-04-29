//
//  Created by David Laubenstein on 16.04.19.
//  Copyright © 2019 Jamit Labs GmbH. All rights reserved.
//

import CoreBluetooth
import Imperio
import SnapKit
import SwiftEntryKit
import UIKit

class ManualConnectionFlowController: FlowController {
    private lazy var navigationCtrl = UINavigationController(rootViewController: manualConnectionTableViewCtrl)

    private lazy var manualConnectionTableViewCtrl: ManualConnectionTableViewController = {
        let manualConnectionTableViewCtrl = ManualConnectionTableViewController()
        manualConnectionTableViewCtrl.flowDelegate = self

        return manualConnectionTableViewCtrl
    }()

    override func start(from presentingViewController: UIViewController) {
        super.start(from: presentingViewController)
        presentingViewController.present(navigationCtrl, animated: true, completion: nil)
    }
}

extension ManualConnectionFlowController: ManualConnectionFlowDelegate {
    func startSearch() {
        manualConnectionTableViewCtrl.viewModel.sections[2].peripherals = []
        BluetoothConnector.global.startDiscovery()
    }

    func stopSearch() {
        BluetoothConnector.global.stopDiscovery()
    }

    func connect(with peripheral: CBPeripheral) {
        BluetoothConnector.global.connect(to: peripheral)
        NotificationCenter.default.addObserver(self, selector: #selector(isConnected(_:)), name: BluetoothConnectorNotificationPostMaster.didUpdateConnectionNotification, object: nil)
    }

    @objc
    func isConnected(_ notification: Notification) {
        DispatchQueue.main.async { [weak self] in
            NotificationCenter.default.removeObserver(self)
            guard let name = BluetoothConnector.global.connectedPeripheral?.name else { return }
            SwiftEntryKitOptions.addTopFloatMessage(
                titleMessage: "Successfully connected",
                titleMessageFont: UIFont.systemFont(ofSize: 12, weight: .regular),
                titleMessageColor: Colors.GrayScale.white,
                descriptionMessage: name,
                descriptionMessageFont: UIFont.systemFont(ofSize: 16, weight: .bold),
                descriptionMessageColor: Colors.GrayScale.white,
                backgroundColor: Colors.Feedback.success
            )
            self?.navigationCtrl.dismiss(animated: false) {
                BluetoothConnector.global.stopDiscovery()
            }
        }
    }
}
