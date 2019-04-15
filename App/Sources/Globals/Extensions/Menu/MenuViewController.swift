//
//  Created by David Laubenstein on 12.04.19.
//  Copyright © 2019 Jamit Labs GmbH. All rights reserved.
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

class MenuViewController: UITableViewController {
    // MARK: - Computed Instance Properties
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    var viewModel = ViewModel(sections: [ ViewModel.Section (
        items: [
            MenuCellModel(title: "Neue Messung", icon: Images.signal),
            MenuCellModel(title: "Übersicht Messungen", icon: Images.history),
            MenuCellModel(title: "Live View", icon: Images.liveView),
            MenuCellModel(title: "Einstellungen", icon: Images.settings),
            MenuCellModel(title: "Info", icon: Images.info),
            MenuCellModel(title: "Logout", icon: Images.logout)
        ]
        )])

    // MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(MenuCell.self, forCellReuseIdentifier: "basicCell")
        tableView.separatorStyle = .none
        showHeader()

        view.backgroundColor = .blue
    }

    func showHeader() {
        let headerView = UIView()
        let headerImage = UIImageView()
        headerImage.image = Images.liveView
        headerImage.contentMode = .scaleAspectFit
        headerView.addSubview(headerImage)

        headerImage.snp.makeConstraints { make in
            make.width.equalTo(((headerImage.image?.size.width)! / (headerImage.image?.size.height)!) * 40)
            make.height.equalTo(40)
            make.left.equalTo(24)
            make.top.equalToSuperview().offset(20)
        }

        // TODO: maybe push this to snapkit
        headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 100)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell") as! MenuCell
        cell.backgroundColor = .clear
        //        cell.accessoryType = currentIndex == indexPath.row ? .checkmark : .none

        let cellModel = viewModel.sections[indexPath.section].items[indexPath.row]
        cell.cellModel = cellModel

        return cell
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

            case 1:
                anyMenuViewController?.contentViewController = MainViewController()
                anyMenuViewController?.closeMenu()

            case 2:
                anyMenuViewController?.contentViewController = MainViewController()
                anyMenuViewController?.closeMenu()

            default:
                fatalError()
            }

        case 1:
            switch indexPath.row {
            case 0:
                anyMenuViewController?.contentViewController = MainViewController()
                anyMenuViewController?.closeMenu()

            default:
                fatalError()
            }

        case 2:
            switch indexPath.row {
            case 0:
                anyMenuViewController?.contentViewController = MainViewController()
                anyMenuViewController?.closeMenu()

            case 1:
                anyMenuViewController?.contentViewController = MainViewController()
                anyMenuViewController?.closeMenu()

            case 2:
                anyMenuViewController?.contentViewController = MainViewController()
                anyMenuViewController?.closeMenu()

            default:
                fatalError()
            }

        default:
            fatalError()
        }

        tableView.reloadData()
    }
}

