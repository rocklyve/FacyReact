//
//  Created by David Laubenstein on 12.04.19.
//  Copyright © 2019 Jamit Labs GmbH. All rights reserved.
//

import UIKit

struct SettingsViewModel {
    struct Section {
        var title: String?
        var items: [SettingsCellModel]
    }

    struct Item {
        var title: String?
        var subtitle: String?
        var icon: UIImage?
    }

    var sections: [Section]
}

protocol SettingsFlowDelegate: AnyObject {
    func connectWearable()
    func disconnectWearable()
}

class SettingsTableViewController: UITableViewController {
    weak var flowDelegate: SettingsFlowDelegate?
    let cellReuseIdentifier: String = "basicCell"

    // MARK: - Computed Instance Properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    var viewModel = SettingsViewModel(
        sections: [
            SettingsViewModel.Section(
                title: L10n.Settings.SectionTitle.app,
                items: [
                    SettingsCellModel(title: L10n.Settings.lockAutomation, subtitle: "1 Stunde", icon: Images.history)
                ]
            ),
            SettingsViewModel.Section (
                title: L10n.Settings.SectionTitle.wearable,
                items: [
                    SettingsCellModel(title: L10n.Settings.Wearable.wearable, subtitle: wearableConnection(), icon: Images.signal),
                    SettingsCellModel(title: L10n.Settings.Wearable.resetWearable, subtitle: nil, icon: Images.history),
                    SettingsCellModel(title: L10n.Settings.Wearable.deleteAllMeasurements, subtitle: nil, icon: Images.history),
                    SettingsCellModel(title: L10n.Settings.Wearable.retryMeasurement, subtitle: "1 (Standardwert)", icon: Images.history)
                ]
            ),
            SettingsViewModel.Section(
                title: L10n.Settings.SectionTitle.newMeasurement,
                items: [
                    SettingsCellModel(title: L10n.Settings.NewMeasurement.referenceTypeStandard, subtitle: "Anschlussobjektnummer", icon: Images.history)
                ]
            ),
            SettingsViewModel.Section(
                title: L10n.Settings.SectionTitle.liveView,
                items: [
                    SettingsCellModel(title: L10n.Settings.LiveView.intervalStandard, subtitle: "3", icon: Images.history)
                ]
            )
        ]
    )

    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsMultipleSelection = false
        tableView.register(SettingsCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.separatorStyle = .none

        setLeftNavBarMenuButton()
        self.title = L10n.Settings.title
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableViewForNewState(_:)), name: BluetoothConnectorNotificationPostMaster.didUpdateConnectionNotification, object: nil)

        view.backgroundColor = Colors.GrayScale.white
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        viewModel.sections[1].items[0].subtitle = SettingsTableViewController.wearableConnection()
    }

    // MARK: - UITableViewDataSource Protocol Implementation
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! SettingsCell
        cell.backgroundColor = .clear
        //        cell.accessoryType = currentIndex == indexPath.row ? .checkmark : .none

        let cellModel = viewModel.sections[indexPath.section].items[indexPath.row]
        cell.cellModel = cellModel

        return cell
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        let headerLabel = UILabel()
        headerLabel.tintColor = Colors.GrayScale.gray
        headerLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        headerView.addSubview(headerLabel)
        headerLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.top.equalToSuperview().offset(-25)
            make.left.equalToSuperview().offset(16)
        }
        headerLabel.text = viewModel.sections[section].title
        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }

    static func wearableConnection() -> String {
        if BluetoothConnector.global.connectedPeripheral == nil {
            return L10n.Settings.WearableStatus.notConnected
        } else {
            return BluetoothConnector.global.connectedPeripheral?.name ?? "Unknown"
        }
    }

    @objc
    func updateTableViewForNewState(_ notification: Notification) {
        if BluetoothConnector.global.connectedPeripheral == nil {
            viewModel.sections[1].items[0].subtitle = L10n.Settings.WearableStatus.notConnected
        } else {
            viewModel.sections[1].items[0].subtitle = BluetoothConnector.global.connectedPeripheral?.name ?? "Unknown"
        }
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    // MARK: - UITableVIewDelegate Protocol Implementation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                // flowDelegate?.startNewMeasurement()
                log.info("case 0")

            default:
                log.info("default")
            }

        case 1:
            switch indexPath.row {
            case 0:
                if BluetoothConnector.global.isConnected {
                    flowDelegate?.disconnectWearable()
                    viewModel.sections[1].items[0].subtitle = SettingsTableViewController.wearableConnection()
                } else {
                    flowDelegate?.connectWearable()
                }

            case 1:
                log.info("case 1")

            case 2:
                log.info("case 2")

            case 3:
                log.info("case 3")

            default:
                log.info("default")
            }

        case 2:
            switch indexPath.row {
            case 0:
                log.info("case 0")

            default:
                anyMenuViewController?.contentViewController = MainViewController()
                anyMenuViewController?.closeMenu()
            }

        case 3:
            switch indexPath.row {
            case 0:
                log.info("case 0")

            default:
                log.info("default")
            }

        default:
            log.info("default")
        }
        tableView.reloadData()
    }
}
