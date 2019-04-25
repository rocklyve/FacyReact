// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(OSX)
  import AppKit.NSImage
#elseif os(iOS) || os(tvOS) || os(watchOS)
  import UIKit.UIImage
#endif

// MARK: - Asset Catalogs

internal typealias Colors = Asset.Colors
internal typealias Images = Asset.Images

internal enum Asset {
  internal enum Colors {
    internal enum Feedback {
      internal static let danger = UIColor(named: "Feedback/Danger", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let info = UIColor(named: "Feedback/Info", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let neutral = UIColor(named: "Feedback/Neutral", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let success = UIColor(named: "Feedback/Success", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let warning = UIColor(named: "Feedback/Warning", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    }
    internal enum GrayScale {
      internal static let darkGray = UIColor(named: "GrayScale/DarkGray", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let gray = UIColor(named: "GrayScale/Gray", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let lightGray = UIColor(named: "GrayScale/LightGray", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let softWhite = UIColor(named: "GrayScale/SoftWhite", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let white = UIColor(named: "GrayScale/White", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    }
    internal enum Text {
      internal static let darkText = UIColor(named: "Text/DarkText", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let lightText = UIColor(named: "Text/LightText", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    }
    internal enum Theme {
      internal static let accent = UIColor(named: "Theme/Accent", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let primary = UIColor(named: "Theme/Primary", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let secondary = UIColor(named: "Theme/Secondary", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    }
    internal enum Vibrants {
      internal static let blue = UIColor(named: "Vibrants/Blue", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let deepBlue = UIColor(named: "Vibrants/DeepBlue", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let green = UIColor(named: "Vibrants/Green", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let lightBlue = UIColor(named: "Vibrants/LightBlue", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let orange = UIColor(named: "Vibrants/Orange", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let red = UIColor(named: "Vibrants/Red", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let softBlue = UIColor(named: "Vibrants/SoftBlue", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
      internal static let violetBlue = UIColor(named: "Vibrants/VioletBlue", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    }
  }
  internal enum Images {
    internal static let back = UIImage(named: "back", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    internal static let circleCross = UIImage(named: "circleCross", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    internal static let brandLogo = UIImage(named: "brandLogo", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    internal static let defaultCornered = UIImage(named: "defaultCornered", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    internal static let manualConnectionPicture = UIImage(named: "manualConnectionPicture", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    internal static let history = UIImage(named: "history", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    internal static let info = UIImage(named: "info", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    internal static let liveView = UIImage(named: "liveView", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    internal static let logout = UIImage(named: "logout", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    internal static let settings = UIImage(named: "settings", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    internal static let signal = UIImage(named: "signal", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    internal static let texture = UIImage(named: "texture", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
    internal static let wireframeTexture = UIImage(named: "wireframeTexture", in: Bundle(for: BundleToken.self), compatibleWith: nil)!
  }
}

// MARK: - Implementation Details

private final class BundleToken {}
