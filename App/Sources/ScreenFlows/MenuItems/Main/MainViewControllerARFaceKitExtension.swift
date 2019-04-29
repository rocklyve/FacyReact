//
//  Created by David Laubenstein on 26.04.19.
//  Copyright © 2019 DavidLaubenstein. All rights reserved.
//

import ARKit
import Foundation
import SceneKit

extension MainViewController {
    // MARK: - ARSessionDelegate
    func session(_ session: ARSession, didFailWithError error: Error) {
        guard error is ARError else { return }

        let errorWithInfo = error as NSError
        let messages = [
            errorWithInfo.localizedDescription,
            errorWithInfo.localizedFailureReason,
            errorWithInfo.localizedRecoverySuggestion
        ]
        let errorMessage = messages.compactMap({ $0 }).joined(separator: "\n")

        DispatchQueue.main.async {
            self.displayErrorMessage(title: "The AR session failed.", message: errorMessage)
        }
    }

    /// - Tag: ARFaceTrackingSetup
    func resetTracking() {
        guard ARFaceTrackingConfiguration.isSupported else { return }
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }

    // MARK: - Error handling
    func displayErrorMessage(title: String, message: String) {
        // Present an alert informing about the error that has occurred.
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let restartAction = UIAlertAction(title: "Restart Session", style: .default) { _ in
            alertController.dismiss(animated: true, completion: nil)
            self.resetTracking()
        }
        alertController.addAction(restartAction)
        present(alertController, animated: true, completion: nil)
    }
}

extension MainViewController: ARSCNViewDelegate {
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        DispatchQueue.global().async {
            guard let faceAnchor = anchor as? ARFaceAnchor else { return }
            self.currentFaceAnchor = faceAnchor
            
            // If this is the first time with this anchor, get the controller to create content.
            // Otherwise (switching content), will change content when setting `selectedVirtualContent`.
            if node.childNodes.isEmpty, let contentNode = self.contentController.renderer(renderer, nodeFor: faceAnchor) {
                node.addChildNode(contentNode)
            }
        }
    }

    /// - Tag: ARFaceGeometryUpdate
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard anchor == self.currentFaceAnchor,
            let contentNode = self.contentController.contentNode,
            contentNode.parent == node
            else { return }

        self.contentController.renderer(renderer, didUpdate: contentNode, for: anchor)
    }
}

extension MainViewController: TexturedFaceDelegate {
    func didChange(_ faceState: FaceState) {
        // if faceState == active state, then push counter + 1
        if(Game.shared.currentState == faceState) {
            DispatchQueue.main.async {
                var counter: Int = Int(self.gameCounterLabel.text!)!
                counter += 1
                self.gameCounterLabel.text = "\(counter)"
                Game.shared.newRandomCurrentState()
                self.gameActionLabel.text = Game.shared.getCurrentStateAsString()
            }
        }
    }
}
