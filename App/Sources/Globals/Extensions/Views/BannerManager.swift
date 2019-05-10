//
//  Created by David Laubenstein on 23.04.19.
//  Copyright © 2019 Jamit Labs GmbH. All rights reserved.
//

import Foundation
import SwiftEntryKit

enum BannerManager {
    enum Style {
        case success
        case failure
        case warning

        var titleFont: UIFont {
            return .systemFont(ofSize: 12, weight: .regular)
        }

        var subTitleFont: UIFont {
            return .systemFont(ofSize: 14, weight: .regular)
        }

        var textColor: UIColor {
            return Colors.GrayScale.white
        }

        var backgroundColor: UIColor {
            switch self {
            case .success:
                return Colors.Feedback.success

            case .failure:
                return Colors.Feedback.danger

            case .warning:
                return Colors.Feedback.warning
            }
        }
    }

    static func displayTopNoteMessage(title: String, subtitle: String?, style: Style) {
        var attributes = EKAttributes.topNote
        attributes.entryBackground = .color(color: style.backgroundColor)
        attributes.entranceAnimation = .translation
        attributes.exitAnimation = .translation

        let contentView = UIView()

        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        contentView.addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(5)
        }

        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.textColor = style.textColor
        titleLabel.textAlignment = .center

        let subTitleLabel = UILabel()
        subTitleLabel.text = subtitle
        subTitleLabel.textColor = style.textColor
        subTitleLabel.textAlignment = .center

        stackView.addArrangedSubview(titleLabel)
        if !(subtitle?.isEmpty ?? false) {
            stackView.addArrangedSubview(subTitleLabel)
        }

        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
}
