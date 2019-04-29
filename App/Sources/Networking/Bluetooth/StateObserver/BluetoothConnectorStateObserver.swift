//
//  Created by Niklas Bülow on 02.04.19.
//  Copyright © 2019 Jamit Labs GmbH. All rights reserved.
//

import CoreBluetooth

/// The BLEConnectorStateObserver handles all delegate updates of CBCentralManager and acts accordingly.
class BluetoothConnectorStateObserver: NSObject {
    // MARK: - Private Properties
    /// The poster posts all necessary notification to inform the system about a change.
    private var postMaster = BluetoothConnectorNotificationPostMaster()

    /// The advertised service type we search for
    lazy var serviceType = CBUUID(string: serviceWearableUUID)
    let serviceWearableUUID: String = "713D0000-503E-4C75-BA94-3148F18D941E"

    let wearableUUIDCharacteristic01: String = "713D0001-503E-4C75-BA94-3148F18D941E"
    var wearableCharacteristic01: CBCharacteristic?

    let wearableUUIDCharacteristic02: String = "713D0002-503E-4C75-BA94-3148F18D941E"
    var wearableCharacteristic02: CBCharacteristic?

    let wearableUUIDCharacteristic03: String = "713D0003-503E-4C75-BA94-3148F18D941E"
    var wearableCharacteristic03: CBCharacteristic?

    // MARK: - Connection Properties
    /// ALl currently discovered peripherals
    var discoveredDevices: [CBPeripheral] = [] {
        didSet {
            postMaster.postDiscoveryUpdate(peripherals: self.discoveredDevices)
        }
    }

    /// The currently connected peripheral, otherwise nil
    var connectedPeripheral: CBPeripheral? {
        // We always inform the system if the peripheral did change.
        // According to that the system is connected or not.
        didSet {
            postMaster.postConnectionStateChange(to: self.connectedPeripheral != nil ? .connected : .disconnected)
        }
    }
}

// MARK: - CBCentralManagerDelegate
extension BluetoothConnectorStateObserver: CBCentralManagerDelegate {
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        log.info("CBCentralManager did update state to: \(dump(central.state))")

        switch central.state {
        case .poweredOn:
            log.info("State did update: \(central.state.rawValue)")
            if !central.isScanning {
                BluetoothConnector.global.startDiscovery()
            }

        case .poweredOff:
            log.info("State did update: \(central.state.rawValue)")

        case .resetting:
            log.info("State did update: \(central.state.rawValue)")

        case .unauthorized:
            log.info("State did update: \(central.state.rawValue)")

        case .unknown:
            log.info("State did update: \(central.state.rawValue)")

        case .unsupported:
            log.info("State did update: \(central.state.rawValue)")

        default:
            return
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String: Any], rssi RSSI: NSNumber) {
        if peripheral.name?.contains("TECO") ?? false {
            log.info("CBCentralManager did discover \(peripheral.name ?? "Unknown") with uuid: \(peripheral.identifier.uuidString)")
            discoveredDevices.append(peripheral)
        }
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        log.info("CBCentralManager did connect to: \(peripheral.name ?? "Unknown") with uuid: \(peripheral.identifier.uuidString)")
        self.connectedPeripheral = peripheral
        central.stopScan()
        peripheral.delegate = self
        peripheral.discoverServices([serviceType])
    }

    func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
        log.info("CBCentralManager did fail to connect to: \(peripheral.name ?? "Unknown")")
        self.connectedPeripheral = nil
    }

    func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
        log.info("CBCentralManager did disconnect: \(peripheral.name ?? "Unknown")")
        self.connectedPeripheral = nil
    }
}

extension BluetoothConnectorStateObserver: CBPeripheralDelegate {
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        guard let services = peripheral.services else { return }
        // We need to discover the all characteristic
        for service in services where service.uuid.uuidString == serviceWearableUUID {
            peripheral.discoverCharacteristics(nil, for: service)
        }
        log.info("Discovered Services: \(services)")
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        log.info("*******************************************************")

        if ((error) != nil) {
            log.info("Error discovering services: \(error!.localizedDescription)")
            return
        }

        guard let characteristics = service.characteristics else { return }

        log.info("Found \(characteristics.count) characteristics!")

        for characteristic in characteristics {
            // looks for the right characteristic
            if characteristic.uuid.uuidString == wearableUUIDCharacteristic01 {
                wearableCharacteristic01 = characteristic
            }
            if characteristic.uuid.uuidString == wearableUUIDCharacteristic02 {
                wearableCharacteristic02 = characteristic
            }
            if characteristic.uuid.uuidString == wearableUUIDCharacteristic03 {
                wearableCharacteristic03 = characteristic
            }
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        switch characteristic.uuid.uuidString {
        case wearableUUIDCharacteristic01:
            print(characteristic.value?.first ?? "no value")
        case wearableUUIDCharacteristic02:
            print(characteristic.value?.first ?? "no value")
        case wearableUUIDCharacteristic03:
            print(characteristic.value)
        default:
            log.error("error")
        }
    }
}
