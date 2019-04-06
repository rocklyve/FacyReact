//
//  Created by David on 06.04.2019.
//  Copyright © 2019 DavidLaubenstein. All rights reserved.
//

import Imperio
import UIKit

class MainFlowController: InitialFlowController {
    var mainViewCtrl: MainViewController?

    override func start(from window: UIWindow) {
        mainViewCtrl = MainViewController()

        mainViewCtrl?.flowDelegate = self
        window.rootViewController = mainViewCtrl
    }
}

extension MainFlowController: MainFlowDelegate {
    // TODO: not yet implemented
}
