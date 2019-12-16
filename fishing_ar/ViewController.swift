//
//  ViewController.swift
//  fishing_ar
//
//  Created by Yuhei Akamine on 2019/12/05.
//  Copyright © 2019 赤嶺有平. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import CoreMotion

class ViewController: UIViewController, ARSCNViewDelegate {

    @IBOutlet var sceneView: ARSCNView!
    
    var gameController : GameController!
    
    let motionManager = CMMotionManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true

        self.gameController = GameController(sceneRenderer: sceneView)
                

        // Create a new scene
        //let scene = SCNScene(named: "Art.scnassets/ship.scn")!
        
        // Set the scene to the view
        //sceneView.scene = scene
        
        startSensorUpdates(intervalSeconds: 0.1)

        sceneView.debugOptions = [.showFeaturePoints]
        

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //
    }
    
    // モーションデータの取得を開始
    func startSensorUpdates(intervalSeconds:Double) {
        if motionManager.isDeviceMotionAvailable{
            motionManager.deviceMotionUpdateInterval = intervalSeconds

            motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {(motion:CMDeviceMotion?, error:Error?) in
                self.getMotionData(deviceMotion: motion!)

            })
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal

        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // MARK: - ARSCNViewDelegate
    

    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        let geom = SCNPlane(width: 0.3, height: 0.3)
        let plane = SCNNode(geometry: geom)
        plane.eulerAngles.x = -.pi/2
             
        node.addChildNode(plane)
    }

    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    // モーションデータの取得（例としてコンソールへ出力）
    func getMotionData(deviceMotion:CMDeviceMotion) {
        print("attitudeX:", deviceMotion.attitude.pitch)
        print("attitudeY:", deviceMotion.attitude.roll)
        print("attitudeZ:", deviceMotion.attitude.yaw)
        print("gyroX:", deviceMotion.rotationRate.x)
        print("gyroY:", deviceMotion.rotationRate.y)
        print("gyroZ:", deviceMotion.rotationRate.z)
        print("gravityX:", deviceMotion.gravity.x)
        print("gravityY:", deviceMotion.gravity.y)
        print("gravityZ:", deviceMotion.gravity.z)
        print("accX:", deviceMotion.userAcceleration.x)
        print("accY:", deviceMotion.userAcceleration.y)
        print("accZ:", deviceMotion.userAcceleration.z)
    }
}
