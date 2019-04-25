//
//  Created by David Laubenstein on 25.04.19.
//  Copyright © 2019 DavidLaubenstein. All rights reserved.
//

import Foundation
import UIKit

protocol InfoFlowDelegate: AnyObject {
    // TODO: Implement delegate function
}

class InfoViewController: UIViewController {
    weak var flowDelegate: InfoFlowDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}
