//
//  Created by David Laubenstein on 26.04.19.
//  Copyright © 2019 DavidLaubenstein. All rights reserved.
//

import CoreBluetooth
import Foundation
import HandySwift

class Game {
    // MARK: - Static Properties
    /// Globally shared Singleton
    static var shared = Game()

    // MARK: - Initialization
    /// Initializers a BLEConnecter
    /// It is set to private as it uses the Singleton Pattern
    private init() { /* This is supposed to be empty. */ }

    var currentState: FaceState?

    func start() {
        GameTimer.global.startTimer()
        newRandomCurrentState()
        // vibrate now
        BluetoothConnector.global.getAmountOfMotors()
        BluetoothConnector.global.getMaxUpdateFrequency()
    }
    func newRandomCurrentState() {
        currentState = FaceState.allStates.randomElement()
        BluetoothConnector.global.changeGameState(state: currentState!)
    }

    func getCurrentStateAsString() -> String {
        if currentState == FaceState.browInnerUp {
            return "Brow inner up"
        }
        if currentState == FaceState.jawOpen {
            return "Jaw Open"
        }
        if currentState == FaceState.eyeBlinkLeft {
            return "Eye Blink Right"
        }
        if currentState == FaceState.eyeBlinkRight {
            return "Eye Blink Left"
        }
        return ""
    }
}
