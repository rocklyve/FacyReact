// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
internal enum L10n {

  internal enum Auth {
    /// Identify yourself!
    internal static let identifyYourself = L10n.tr("Localizable", "Auth.identifyYourself")
  }

  internal enum ConnectBleDevice {
    /// Please make sure, that your device is turned on
    internal static let description = L10n.tr("Localizable", "ConnectBleDevice.description")
    /// Connect Wearable
    internal static let headline = L10n.tr("Localizable", "ConnectBleDevice.headline")
    /// Connect manually
    internal static let manualConnection = L10n.tr("Localizable", "ConnectBleDevice.manualConnection")
    /// Scan QR-Code
    internal static let scanQRCode = L10n.tr("Localizable", "ConnectBleDevice.scanQRCode")
  }

  internal enum Login {
    /// Let's go
    internal static let buttonText = L10n.tr("Localizable", "Login.buttonText")
    /// Login
    internal static let headline = L10n.tr("Localizable", "Login.headline")
  }

  internal enum ManualConnection {
    /// Search
    internal static let scanCellTitle = L10n.tr("Localizable", "ManualConnection.scanCellTitle")
    /// Would you like to search for more devices?
    internal static let searchTitle = L10n.tr("Localizable", "ManualConnection.searchTitle")
    /// Stop
    internal static let stopScan = L10n.tr("Localizable", "ManualConnection.stopScan")
    /// Search for Wearable devices...
    internal static let stopTitle = L10n.tr("Localizable", "ManualConnection.stopTitle")
    /// Connect Wearable
    internal static let title = L10n.tr("Localizable", "ManualConnection.title")
  }

  internal enum Menu {
    /// Contact
    internal static let contact = L10n.tr("Localizable", "Menu.contact")
    /// Home
    internal static let home = L10n.tr("Localizable", "Menu.Home")
    /// Info
    internal static let info = L10n.tr("Localizable", "Menu.info")
    /// Live View
    internal static let liveView = L10n.tr("Localizable", "Menu.liveView")
    /// Logout
    internal static let logout = L10n.tr("Localizable", "Menu.logout")
    /// New measurement
    internal static let newMeasurement = L10n.tr("Localizable", "Menu.newMeasurement")
    /// Overview measurements
    internal static let overviewMeasurements = L10n.tr("Localizable", "Menu.overviewMeasurements")
    /// Settings
    internal static let settings = L10n.tr("Localizable", "Menu.settings")
  }

  internal enum Settings {
    /// Lock Automation
    internal static let lockAutomation = L10n.tr("Localizable", "Settings.lockAutomation")
    /// Settings
    internal static let title = L10n.tr("Localizable", "Settings.title")
    internal enum NewMeasurement {
      /// Reference type standard
      internal static let referenceTypeStandard = L10n.tr("Localizable", "Settings.NewMeasurement.referenceTypeStandard")
    }
    internal enum SectionTitle {
      /// App
      internal static let app = L10n.tr("Localizable", "Settings.SectionTitle.app")
      /// Live view
      internal static let liveView = L10n.tr("Localizable", "Settings.SectionTitle.liveView")
      /// New measurement
      internal static let newMeasurement = L10n.tr("Localizable", "Settings.SectionTitle.newMeasurement")
      /// Wearable
      internal static let wearable = L10n.tr("Localizable", "Settings.SectionTitle.wearable")
    }
    internal enum WearableStatus {
      /// Not connected
      internal static let notConnected = L10n.tr("Localizable", "Settings.WearableStatus.notConnected")
    }
    internal enum LiveView {
      /// Interval standard
      internal static let intervalStandard = L10n.tr("Localizable", "Settings.liveView.intervalStandard")
    }
    internal enum Wearable {
      /// Delete all measurements on Wearable
      internal static let deleteAllMeasurements = L10n.tr("Localizable", "Settings.wearable.deleteAllMeasurements")
      /// Reset Wearable
      internal static let resetWearable = L10n.tr("Localizable", "Settings.wearable.resetWearable")
      /// Retry Measurement
      internal static let retryMeasurement = L10n.tr("Localizable", "Settings.wearable.retryMeasurement")
      /// Wearable
      internal static let wearable = L10n.tr("Localizable", "Settings.wearable.wearable")
    }
  }

  internal enum Unlock {
    /// Unlock
    internal static let buttonTitle = L10n.tr("Localizable", "Unlock.buttonTitle")
    /// The app is locked for security reasons
    internal static let description = L10n.tr("Localizable", "Unlock.description")
    /// App locked
    internal static let headline = L10n.tr("Localizable", "Unlock.headline")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
