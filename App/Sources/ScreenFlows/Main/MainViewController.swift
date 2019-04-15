//
//  Created by David on 06.04.2019.
//  Copyright © 2017 DavidLaubenstein. All rights reserved.
//

import SnapKit
import UIKit

protocol MainFlowDelegate: class {
    // TODO: not yet implemented
}

class MainViewController: UIViewController {
    weak var flowDelegate: MainFlowDelegate?

    lazy var header = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(header)
        headerConfig()
        setupNavigationController(withBarColor: .default)
        setupConstraints()
    }

    func headerConfig() {
        header.text = "Welcome to FacyReact"
        header.font = UIFont(name: "Zapfino", size: 35)
        header.numberOfLines = 0
        header.textAlignment = .center
    }

    func setupConstraints() {
        header.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(150)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().inset(50)
            make.height.equalTo(250)
        }
    }
}
