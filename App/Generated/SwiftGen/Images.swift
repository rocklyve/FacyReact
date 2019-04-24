//
//  Created by David Laubenstein on 24.04.19.
//  Copyright © 2019 Jamit Labs GmbH. All rights reserved.
//
// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import UIKit

// MARK: - Helpers
private final class BundleToken {}

extension UIImage {
    @available(iOS 1.0, tvOS 1.0, watchOS 1.0, *)
    convenience init(name: String) {
        #if os(iOS) || os(tvOS)
        let bundle = Bundle(for: BundleToken.self)
        self.init(named: name, in: bundle, compatibleWith: nil)!
        #elseif os(watchOS)
        self.init(named: name)!
        #endif
    }
}

// MARK: - Images
enum Image {
    enum Icons {
        static let add = UIImage(name: "add")
        static let arrowDown = UIImage(name: "arrowDown")
        static let arrowLeft = UIImage(name: "arrowLeft")
        static let arrowRight = UIImage(name: "arrowRight")
        static let circleCross = UIImage(name: "circleCross")
        static let edit = UIImage(name: "edit")
        static let heartFilled = UIImage(name: "heartFilled")
        static let more = UIImage(name: "more")
        static let overview = UIImage(name: "overview")
        static let profile = UIImage(name: "profile")
        static let share = UIImage(name: "share")
        static let starFilled = UIImage(name: "starFilled")
        static let back = UIImage(name: "back")
    }
    enum Connection {
        static let noConnection = UIImage(name: "noConnection")
    }
    enum LaunchScreen {
        static let background = UIImage(name: "background")
    }
    enum Logo {
        static let defaultCornered = UIImage(name: "defaultCornered")
        static let brandLogo = UIImage(name: "brandLogo")
    }

    static let allImages: [UIImage] = [
        Icons.add,
        Icons.arrowDown,
        Icons.arrowLeft,
        Icons.arrowRight,
        Icons.circleCross,
        Icons.edit,
        Icons.heartFilled,
        Icons.more,
        Icons.overview,
        Icons.profile,
        Icons.share,
        Icons.starFilled,
        Icons.back,
        Connection.noConnection,
        LaunchScreen.background,
        Logo.defaultCornered,
        Logo.brandLogo
    ]
}
