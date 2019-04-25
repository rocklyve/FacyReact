//
//  Created by David Laubenstein on 24.04.19.
//  Copyright © 2019 DavidLaubenstein. All rights reserved.
//

import ARKit
import SceneKit

protocol TexturedFaceDelegate {
    func didChange(_ faceState: FaceState)
}

class TexturedFace: NSObject, VirtualContentController {
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

        contentNode = SCNNode(geometry: faceGeometry)
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
        if eyeBlinkLeft > 0.9 {
            faceState.insert(.eyeBlinkLeft)
        } else {
            faceState.remove(.eyeBlinkLeft)
        }
        if eyeBlinkRight > 0.9 {
            faceState.insert(.eyeBlinkRight)
        } else {
            faceState.remove(.eyeBlinkRight)
        }
        if browInnerUp > 0.9 {
            faceState.insert(.browInnerUp)
        } else {
            faceState.remove(.browInnerUp)
        }
        if jawOpen > 0.9 {
            faceState.insert(.jawOpen)
        } else {
            faceState.remove(.jawOpen)
        }
    }
}
