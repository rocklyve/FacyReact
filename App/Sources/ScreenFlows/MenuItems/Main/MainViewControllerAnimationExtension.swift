//
//  Created by David Laubenstein on 26.04.19.
//  Copyright © 2019 DavidLaubenstein. All rights reserved.
//

import SnapKit
import UIKit

extension MainViewController {
    // MARK: - Animations
    func startAnimation() {
        // Start Animation
        startPlayButton.snp.updateConstraints { update in
            update.width.height.equalTo(100)
        }

        let animation: () -> Void = { [weak self] in
            guard let self = self else { return }
            self.startPlayButton.layoutIfNeeded()
            self.startPlayButton.transform = CGAffineTransform(
                translationX: -self.view.bounds.width / 2 + 50 + self.view.safeAreaInsets.bottom,
                y: (self.view.bounds.height / 2) - 50 - self.view.safeAreaInsets.bottom
            )
        }

        UIView.animate(withDuration: 0.3, animations: animation) { [weak self] _ in
            self?.flowDelegate?.didPrepareGameStart()
        }
    }

    func resetAnimation() {
        let animation: () -> Void = { [weak self] in
            guard let self = self else { return }
            // TODO: snapkit reset buttonlayout
            self.startPlayButton.snp.updateConstraints { update in
                update.centerX.equalToSuperview()
                update.centerY.equalToSuperview()
                update.width.equalTo(250)
                update.height.equalTo(100)
            }
            self.startPlayButton.transform = .identity
        }
        UIView.animate(withDuration: 0.3, animations: animation) { [weak self] _ in
            guard let self = self else { return }
            self.startPlayButton.setTitle("Retry", for: .normal)
        }
    }
}
