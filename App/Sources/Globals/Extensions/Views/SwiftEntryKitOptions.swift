//
//  Created by David Laubenstein on 23.04.19.
//  Copyright © 2019 Jamit Labs GmbH. All rights reserved.
//

import Foundation
import SwiftEntryKit

enum SwiftEntryKitOptions {
    struct StyledString {
        var message: String
        var font: UIFont
        var color: UIColor
    }
    // TODO: use attributed string for func params
    static func addTopFloatMessage(title: StyledString, description: StyledString, backgroundColor: UIColor) {
        var attributes = EKAttributes.topFloat
        attributes.entryBackground = .color(color: backgroundColor)
        attributes.entranceAnimation = .translation
        attributes.exitAnimation = .translation

        var titleStyle = EKProperty.LabelStyle(font: title.font, color: title.color)
        titleStyle.alignment = .center
        var descriptionStyle = EKProperty.LabelStyle(font: description.font, color: description.color)
        descriptionStyle.alignment = .center
        let labelContent = EKProperty.LabelContent(text: title.message, style: titleStyle)
        let descriptionLabelContent = EKProperty.LabelContent(text: description.message, style: descriptionStyle)
        let simpleMessage = EKSimpleMessage(image: nil, title: labelContent, description: descriptionLabelContent)
        let notificationMessage = EKNotificationMessage(simpleMessage: simpleMessage)
        let contentView = EKNotificationMessageView(with: notificationMessage)

        SwiftEntryKit.display(entry: contentView, using: attributes)
    }
}
