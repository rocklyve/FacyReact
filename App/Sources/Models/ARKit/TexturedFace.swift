//
//  Created by David Laubenstein on 24.04.19.
//  Copyright © 2019 DavidLaubenstein. All rights reserved.
//

import ARKit
import SceneKit

protocol TexturedFaceDelegate: AnyObject {
    func didChange(_ faceState: FaceState)
}

class TexturedFace: NSObject, VirtualContentController {
    weak var flowDelegate: TexturedFaceDelegate?

    var contentNode: SCNNode?
    var faceState: FaceState = []

    /// - Tag: CreateARSCNFaceGeometry
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let sceneView = renderer as? ARSCNView,
            anchor is ARFaceAnchor else { return nil }

        #if targetEnvironment(simulator)
        #error("ARKit is not supported in iOS Simulator. Connect a physical iOS device and select it as your Xcode run destination, or select Generic iOS Device as a build-only destination.")
        #else
        let faceGeometry = ARSCNFaceGeometry(device: sceneView.device!)!
        let material = faceGeometry.firstMaterial!

        material.diffuse.contents = Images.wireframeTexture
        material.lightingModel = .physicallyBased

        self.contentNode = SCNNode(geometry: faceGeometry)
        #endif

        return contentNode
    }

    /// - Tag: ARFaceGeometryUpdate
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let faceGeometry = node.geometry as? ARSCNFaceGeometry,
            let faceAnchor = anchor as? ARFaceAnchor
            else { return }
        faceGeometry.update(from: faceAnchor.geometry)
        let blendShapes = faceAnchor.blendShapes
        guard let eyeBlinkLeft = blendShapes[.eyeBlinkLeft] as? Float,
            let eyeBlinkRight = blendShapes[.eyeBlinkRight] as? Float,
            let jawOpen = blendShapes[.jawOpen] as? Float,
            let browInnerUp = blendShapes[.browInnerUp] as? Float
            else { return }
        if eyeBlinkLeft > 0.7 {
            self.faceState.insert(.eyeBlinkLeft)
            self.flowDelegate?.didChange(self.faceState)
        } else {
            self.faceState.remove(.eyeBlinkLeft)
        }
        if eyeBlinkRight > 0.7 {
            self.faceState.insert(.eyeBlinkRight)
            self.flowDelegate?.didChange(self.faceState)
        } else {
            self.faceState.remove(.eyeBlinkRight)
        }
        if browInnerUp > 0.7 {
            self.faceState.insert(.browInnerUp)
            self.flowDelegate?.didChange(self.faceState)
        } else {
            self.faceState.remove(.browInnerUp)
        }
        if jawOpen > 0.6 {
            self.faceState.insert(.jawOpen)
            self.flowDelegate?.didChange(self.faceState)
        } else {
            self.faceState.remove(.jawOpen)
        }
    }
}
