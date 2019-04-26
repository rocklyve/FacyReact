//
//  Created by David Laubenstein on 26.04.19.
//  Copyright © 2019 DavidLaubenstein. All rights reserved.
//

import Foundation

class Game {
    static var shared = Game()
    // MARK: - Initialization
    /// Initializers a BLEConnecter
    /// It is set to private as it uses the Singleton Pattern
    private init() { /* This is supposed to be empty. */ }

    var currentState: FaceState?

    func newRandomCurrentState() {
        let number = Int.random(in: 0 ..< 3)
        currentState = FaceState.allStates.randomElement()
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
