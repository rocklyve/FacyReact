//
//  Created by David Laubenstein on 25.04.19.
//  Copyright © 2019 DavidLaubenstein. All rights reserved.
//

import Foundation
import Imperio
import UIKit

class InfoFlowController: FlowController {
    private lazy var navigationCtrl = UINavigationController(rootViewController: infoViewCtrl)

    private lazy var infoViewCtrl: InfoViewController = {
        let infoViewCtrl = InfoViewController()
        infoViewCtrl.flowDelegate = self

        return infoViewCtrl
    }()

    override func start(from presentingViewController: UIViewController) {
        super.start(from: presentingViewController)
        presentingViewController.present(navigationCtrl, animated: true, completion: nil)
    }
}

extension InfoFlowController: InfoFlowDelegate {
    // TODO: Implement function here
}
