//
//  Created by David Laubenstein on 24.04.19.
//  Copyright © 2019 DavidLaubenstein. All rights reserved.
//

import ARKit
import SceneKit

/// For forwarding `ARSCNViewDelegate` messages to the object controlling the currently visible virtual content.
protocol VirtualContentController: ARSCNViewDelegate {
    var flowDelegate: TexturedFaceDelegate? { get set }
    /// The root node for the virtual content.
    var contentNode: SCNNode? { get set }

    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode?

    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor)
}
