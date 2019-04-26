//
//  Created by David Laubenstein on 25.04.19.
//  Copyright © 2019 DavidLaubenstein. All rights reserved.
//

import Foundation

protocol GameTimerDelegate: AnyObject {
    func timerHasEnded()
    func timeLeft(timeLeft: Int)
}

class GameTimer {
    weak var flowDelegate: GameTimerDelegate?
    static var global = GameTimer()

    // MARK: - Initialization
    /// Initializers a BLEConnecter
    /// It is set to private as it uses the Singleton Pattern
    private init() { /* This is supposed to be empty. */ }

    var isRunning: Bool?

    var timer: Timer?
    var timeLeft: Int = 30

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(reduceCounter), userInfo: nil, repeats: true)
    }

    @objc
    func reduceCounter() {
        timeLeft -= 1
        guard timer != nil else { return }
        if timeLeft <= 0 {
            timer!.invalidate()
            timer = nil
            flowDelegate?.timerHasEnded()
        } else {
            flowDelegate?.timeLeft(timeLeft: timeLeft)
        }
    }
}
