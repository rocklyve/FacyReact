//
//  Created by David Laubenstein on 02.04.19.
//  Copyright © 2019 David Laubenstein. All rights reserved.
//

import CoreBluetooth
import Foundation
import HandySwift

/**
 The BLEConnector handles all CoreBluetooth related task, such as
 discovering a peripheral, connecting and disconnecting.
 */
final class BluetoothConnector {
    // MARK: - Static Properties
    /// Globally shared Singleton
    static var global = BluetoothConnector()

    // MARK: - Private Properties
    /// The state observer is used as the centralManagers delegate.
    private var stateObserver = BluetoothConnectorStateObserver()

    // MARK: - CoreBluetooth Properties
    /// Central Manager is the main entry point to the CoreBluetooth Framework
    private lazy var centralManager: CBCentralManager = {
        CBCentralManager(delegate: self.stateObserver, queue: self.bluetoothQueue)
    }()

    /// The Queue on which all CoreBluetooth actions are executed.
    private var bluetoothQueue = DispatchQueue(label: "Wearable.BLEConnecter", qos: .userInitiated)

    // MARK: - Public properties
    /// Describes whether the device is connected with a peripheral.
    var isConnected: Bool { return stateObserver.connectedPeripheral != nil }

    /// The currently connected peripheral.
    var connectedPeripheral: CBPeripheral? { return stateObserver.connectedPeripheral }

    // MARK: - Initialization
    /// Initializers a BLEConnecter
    /// It is set to private as it uses the Singleton Pattern
    private init() { /* This is supposed to be empty. */ }

    // MARK: - Discovery
    /// Starts the discovery of peripherals
    func startDiscovery() {
        guard centralManager.state == .poweredOn else {
            // TODO: here a popup should appear for turning on Bluetooth
            return
        }
        log.info("Scanning started")
        // TODO: serch for specific service
        centralManager.scanForPeripherals(withServices: [], options: nil)
    }

    /// Stops the discovery of peripherals
    func stopDiscovery() {
        log.info("Scanning stopped")
        centralManager.stopScan()
    }

    // MARK: - Connection
    /// Tries to connect to the specified peripheral.
    /// If successfull you should receive a notification.
    ///
    /// - Parameter peripheral: The peripheral to connect to.
    func connect(to peripheral: CBPeripheral) {
        centralManager.connect(peripheral, options: nil)
    }

    /// Disconnects if not already disconnected.
    func disconnect() {
        guard let connectedPeripheral = stateObserver.connectedPeripheral else { return }
        centralManager.cancelPeripheralConnection(connectedPeripheral)
        stateObserver.connectedPeripheral = nil
    }

    func getAmountOfMotors() {
        guard let characteristic1 = stateObserver.wearableCharacteristic01 else { return }
        guard characteristic1.properties.contains(.read) else { return }
        connectedPeripheral?.readValue(for: characteristic1)
    }

    func getMaxUpdateFrequency() {
        guard let characteristic2 = stateObserver.wearableCharacteristic02 else { return }
        guard characteristic2.properties.contains(.read) else { return }
        connectedPeripheral?.readValue(for: characteristic2)
    }

    func getCurrentMotorValues() {
        guard let characteristic3 = stateObserver.wearableCharacteristic03 else { return }
        guard characteristic3.properties.contains(.read) else { return }
        connectedPeripheral?.readValue(for: characteristic3)
    }

    func changeGameState(state: FaceState) {
        guard let characteristics3 = stateObserver.wearableCharacteristic03 else { return }
        guard characteristics3.properties.contains(.write) else { return }
        switch state {
        case FaceState.browInnerUp:
            connectedPeripheral?.writeValue(Data(_: [0x00, 0x00, 0x00, 0xFF]), for: characteristics3, type: .withoutResponse)

        case FaceState.eyeBlinkLeft:
            connectedPeripheral?.writeValue(Data(_: [0xFF, 0x00, 0x00, 0x00]), for: characteristics3, type: .withoutResponse)

        case FaceState.eyeBlinkRight:
            connectedPeripheral?.writeValue(Data(_: [0x00, 0x00, 0xFF, 0x00]), for: characteristics3, type: .withoutResponse)

        case FaceState.jawOpen:
            connectedPeripheral?.writeValue(Data(_: [0x00, 0xFF, 0x00, 0x00]), for: characteristics3, type: .withoutResponse)

        default:
            log.info("error")
        }
        delay(by: .milliseconds(500)) {
            self.connectedPeripheral?.writeValue(Data(_: [0x00, 0x00, 0x00, 0x00]), for: characteristics3, type: .withoutResponse)
        }
    }
}
