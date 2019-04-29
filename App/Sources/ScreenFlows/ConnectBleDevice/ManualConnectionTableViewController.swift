//
//  Created by David Laubenstein on 16.04.19.
//  Copyright © 2019 Jamit Labs GmbH. All rights reserved.
//

import CoreBluetooth
import HandySwift
import SnapKit
import UIKit

protocol ManualConnectionFlowDelegate: AnyObject {
    func startSearch()
    func stopSearch()
    func connect(with peripheral: CBPeripheral)
}

struct DeviceViewModel {
    struct Section {
        var title: String?
        var subtitle: String?
        var peripherals: [CBPeripheral]
    }

    struct Item {
        var title: String?
        var subtitle: String?
    }

    var sections: [Section]
}

class ManualConnectionTableViewController: UITableViewController {
    weak var flowDelegate: ManualConnectionFlowDelegate?
    let cellReuseIdentifier: String = "basicCell"
    let cellScanReuseIdentifier: String = "scanDescriptionCell"

    var viewModel = DeviceViewModel(
        sections: [
            DeviceViewModel.Section(
                title: "Scannen",
                subtitle: L10n.ManualConnection.stopTitle,
                peripherals: []
            ),
            DeviceViewModel.Section (
                title: "Gekoppelt",
                subtitle: nil,
                peripherals: []
            ),
            DeviceViewModel.Section(
                title: "Verfügbar",
                subtitle: nil,
                peripherals: []
            )
        ]
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItems = [
            UIBarButtonItem(image: Image.Icons.circleCross, style: .plain, target: self, action: #selector(closeButtonPressed))
        ]
        navigationController?.navigationBar.tintColor = .black
        title = L10n.ManualConnection.title
        view.backgroundColor = Colors.GrayScale.softWhite

        tableView.allowsMultipleSelection = false
        tableView.register(ManualConnectionCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.register(ManualConnectionScanCell.self, forCellReuseIdentifier: cellScanReuseIdentifier)
        tableView.separatorStyle = .none

        NotificationCenter.default.addObserver(self, selector: #selector(updateTableViewForNewDevices(_:)), name: BluetoothConnectorNotificationPostMaster.peripheralDiscoverUpdateNotification, object: nil)
    }

    @objc
    func updateTableViewForNewDevices(_ notification: Notification) {
        let key = BluetoothConnectorNotificationPostMaster.PayloadKeys.peripherals
        guard let peripherals = notification.userInfo?[key] as? [CBPeripheral] else { return }
        var isAlreadyFound = false
        for peripheral in peripherals {
            for item in viewModel.sections[2].peripherals where peripheral.identifier.uuidString == item.identifier.uuidString {
                isAlreadyFound = true
            }
            if !isAlreadyFound {
                viewModel.sections[2].peripherals.append(peripheral)
                DispatchQueue.main.async { [weak self] in
                    self?.tableView.reloadData()
                }
            }
            isAlreadyFound = false
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 0:
            break

        case 1:
            log.info("Gekoppelt")

        case 2:
            flowDelegate?.connect(with: viewModel.sections[indexPath.section].peripherals[indexPath.row])

        default:
            log.error("clicked to an not clickable element")
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        flowDelegate?.startSearch()
    }

    // MARK: - UITableViewDataSource Protocol Implementation
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 150
        } else {
            return 85
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return viewModel.sections[section].peripherals.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellScanReuseIdentifier) as! ManualConnectionScanCell
            cell.cellModel = ManualConnectionScanCellModel(
                title: viewModel.sections[indexPath.section].subtitle,
                buttonTitle: L10n.ManualConnection.stopScan,
                flowDelegate: flowDelegate
            )
            cell.selectionStyle = .none
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! ManualConnectionCell

            let peripheral = viewModel.sections[indexPath.section].peripherals[indexPath.row]
            let cellModel = ManualConnectionCellModel(title: peripheral.name, subtitle: peripheral.identifier.uuidString)
            cell.cellModel = cellModel
            return cell
        }
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

    @objc
    func closeButtonPressed() {
        flowDelegate?.stopSearch()
        self.dismiss(animated: true, completion: nil)
    }
}
