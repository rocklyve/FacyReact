//
//  Created by David Laubenstein on 12.04.19.
//  Copyright © 2019 DavidLaubenstein. All rights reserved.
//

import UIKit

struct ViewModel {
    struct Section {
        var items: [MenuCellModel]
    }

    struct Item {
        var title: String?
        var icon: UIImage?
    }

    var sections: [Section]
}

protocol MenuFlowDelegate: AnyObject {
    func settings()
}

// swiftlint:disable class_name_suffix_table_view_controller
class MenuViewController: UITableViewController {
    weak var flowDelegate: MenuFlowDelegate?

    let cellReuseIdentifier: String = "basicCell"

    // MARK: - Computed Instance Properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    var viewModel = ViewModel(
        sections: [
            ViewModel.Section (
                items: [
                    MenuCellModel(title: L10n.Menu.home, icon: Images.liveView)
                ]
            ),
            ViewModel.Section(
                items: [
                    MenuCellModel(title: L10n.Menu.settings, icon: Images.settings)
                ]
            ),
            ViewModel.Section(
                items: [
                    MenuCellModel(title: L10n.Menu.contact, icon: Images.signal),
                    MenuCellModel(title: L10n.Menu.info, icon: Images.info)
                ]
            )
        ]
    )

    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.allowsMultipleSelection = false
        tableView.register(MenuCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        tableView.separatorStyle = .none

        showHeader()

        view.backgroundColor = Colors.Vibrants.blue
    }

    func showHeader() {
        let headerView = UIView()
        let headerImage = UIImageView()
        headerImage.image = Images.brandLogo
        headerImage.contentMode = .scaleAspectFit
        headerView.addSubview(headerImage)

        headerImage.snp.makeConstraints { make in
            make.height.equalTo(110)
            make.width.equalTo(headerImage.snp.height).multipliedBy(826 / 278)
            make.left.equalTo(24)
            make.top.equalToSuperview().offset(20)
        }

        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 140)
        self.tableView.tableHeaderView = headerView
    }

    // MARK: - UITableViewDataSource Protocol Implementation
    override func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! MenuCell
        cell.backgroundColor = .clear
        //        cell.accessoryType = currentIndex == indexPath.row ? .checkmark : .none

        let cellModel = viewModel.sections[indexPath.section].items[indexPath.row]
        cell.cellModel = cellModel

        return cell
    }

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section != 2 {
            let footerView = UIView()
            footerView.backgroundColor = UIColor.clear
            let separatorView = UIView()

            footerView.addSubview(separatorView)
            separatorView.snp.makeConstraints { make in
                make.height.equalTo(1)
                make.width.equalToSuperview()
                make.centerX.centerY.equalToSuperview()
            }

            let gradient = CAGradientLayer()
            gradient.colors = [UIColor.white.cgColor, UIColor.clear]
            gradient.locations = [0.0, 1.0]
            gradient.startPoint = CGPoint(x: 0.4, y: 1.0)
            gradient.endPoint = CGPoint(x: 0.9, y: 1.0)
            gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: 1)
            separatorView.layer.insertSublayer(gradient, at: 0)

            return footerView
        } else {
            let footerView = UIView()
            footerView.backgroundColor = UIColor.clear
            return footerView
        }
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 33
    }

    // MARK: - UITableVIewDelegate Protocol Implementation
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                anyMenuViewController?.contentViewController = MainViewController()
                anyMenuViewController?.closeMenu()

            default:
                log.error("defaultCase in TableView")
            }

        case 1:
            switch indexPath.row {
            case 0:// settings
                flowDelegate?.settings()

            default:
                log.error("defaultCase in TableView")
            }

        case 2:
            switch indexPath.row {
            case 0:
                anyMenuViewController?.contentViewController = MainViewController()
                anyMenuViewController?.closeMenu()

            case 1: // info
                anyMenuViewController?.contentViewController = MainViewController()
                anyMenuViewController?.closeMenu()

            default:
                log.error("defaultCase in TableView")
            }

        default:
            log.error("defaultCase in TableView")
        }

        tableView.reloadData()
    }
}
