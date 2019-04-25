//
//  Created by David Laubenstein on 25.04.19.
//  Copyright © 2019 DavidLaubenstein. All rights reserved.
//

import Foundation

struct FaceState: OptionSet {
    let rawValue: Int

    static let eyeBlinkLeft = FaceState(rawValue: 1 << 0)
    static let eyeBlinkRight = FaceState(rawValue: 1 << 1)
    static let jawOpen = FaceState(rawValue: 1 << 2)
    static let browInnerUp = FaceState(rawValue: 1 << 3)

    static let closedEyes: FaceState = [.eyeBlinkRight, .eyeBlinkLeft]
}
