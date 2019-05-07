//
//  Created by David Laubenstein on 02.04.19.
//  Copyright © 2019 David Laubenstein. All rights reserved.
//

import CoreBluetooth

/// The BLEConnectorNotificationPostMaster helps BLEConnector to inform
/// the system of changes and updates.
/// We use this approach as it is necessary for our system to access the BLE
/// informations globally and with multiple instances at once.
class BluetoothConnectorNotificationPostMaster {
    // MARK: - Keys
    /// PayloadKeys to access Notifications UserInfo Payload more easily
    ///
    /// - peripherals: A key to an array of CBPeripheral
    /// - state: A key to an CBPeripheralState
    enum PayloadKeys: String {
        case peripherals
        case state
    }

    // MARK: - Static Properties
    /// The peripheralDiscoveryUpdateNotification is called whenever a new peripheral is discovered or
    /// a already discovered peripheral is lost.
    /// The userInfo contains the array of all currently discovered peripherals.
    static var peripheralDiscoverUpdateNotification = Notification.Name("peripheralDiscoveryUpdate")

    /// The didUpdateConnectionNotification is called whenever the connection state to an arbitrary peripheral did
    /// change. As we only have a single connected peripheral at once this notification tells you whether
    /// our system is connected with a peripheral or not.
    static var didUpdateConnectionNotification = Notification.Name("didUpdateConnectionNotification")

    // MARK: - PostHelpers
    /// Posts a peripheralDiscoveryUpdateNotification with the currently discovered peripherals.
    ///
    /// - Parameter peripherals: All currently discovered peripherals.
    func postDiscoveryUpdate(peripherals: [CBPeripheral]) {
        NotificationCenter.default.post(
            name: BluetoothConnectorNotificationPostMaster.peripheralDiscoverUpdateNotification,
            object: self,
            userInfo: [PayloadKeys.peripherals: peripherals]
        )
    }

    /// Posts a didUpdateConnectionNotification with the new connection state.
    ///
    /// - Parameter state: The new connection state.
    func postConnectionStateChange(to state: CBPeripheralState) {
        NotificationCenter.default.post(
            name: BluetoothConnectorNotificationPostMaster.didUpdateConnectionNotification,
            object: self,
            userInfo: [PayloadKeys.state: state]
        )
    }
}
