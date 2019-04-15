//
//  Created by David Laubenstein on 11.04.19.
//  Copyright © 2019 Jamit Labs GmbH. All rights reserved.
//

import UIKit

extension UIViewController {
    func setupNavigationController(withBarColor barStyle: UIBarStyle) {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.barStyle = barStyle
        navigationController?.navigationBar.isTranslucent = true

        navigationController?.navigationBar.tintColor = .black
        navigationController?.setNeedsStatusBarAppearanceUpdate()
    }
}
