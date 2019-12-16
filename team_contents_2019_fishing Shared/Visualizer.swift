//
//  Visualizer.swift
//  team_contents_2019_fishing
//
//  Created by Yuhei Akamine on 2019/12/14.
//  Copyright © 2019 赤嶺有平. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit

class MovingObject
{
    let node: SCNNode
    var position: SCNVector3 {
        get { return node.position }
        set(p) { node.position = p }
    }
    var velocity: SCNVector3 = SCNVector3()
    var gravity: SCNVector3 = SCNVector3()
    
    init(node: SCNNode) {
        self.node = node
    }
    
    func accelerate(by acc: SCNVector3) {
        velocity += acc
    }
    
    func update(deltaTime: Double) {
        velocity += gravity * SCNFloat(deltaTime)
        position += velocity * SCNFloat(deltaTime)
    }
}

class Visualizer
{
    var scene = SCNScene()
    var overlay: SKScene?
    
    var objects: [MovingObject] = []
    var texts: [String:SKLabelNode] = [:]
    
    init() {
        
    }
    
    func update(deltaTime:Double) {
        for ob in objects {
            ob.update(deltaTime:deltaTime)
        }
    }
    
    func makeObject(with node: SCNNode) -> MovingObject {
        let ob = MovingObject(node:node)
        objects.append(ob)
        scene.rootNode.addChildNode(node)
        return ob
    }
    
    func showText(name:String, text:String, at:CGPoint) {
        if let overlay = self.overlay {
            var pos = at
            #if os(macOS)
            pos.y = overlay.frame.height - pos.y
            #endif
            
            var node = texts[name]
            if node == nil {
                let n = SKLabelNode()
                n.horizontalAlignmentMode = .left
                n.verticalAlignmentMode = .baseline
                texts[name] = n
                overlay.addChild(n)
            }
            
            node?.text = text
            node?.position = pos
        }
    }
}

class FishingVisualizer : Visualizer
{
    var floatObject: MovingObject?
    let GRAVITY = SCNVector3(0,-0.98,0)
    
    override init() {
        super.init()
        prepareScene()
    }
    
    private func prepareScene() {
        scene = SCNScene(named: "Art.scnassets/ship.scn")!
        
        if let ship = scene.rootNode.childNode(withName: "ship", recursively: true) {
            //ship.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 0, y: 2, z: 0, duration: 1)))
            //ship.removeFromParentNode()
        }
        
        makeFloatVisual()
    }
    
    private func makeFloatVisual() {
        let dummyFloat = SCNNode(geometry: SCNSphere(radius: 0.1))
        dummyFloat.geometry?.firstMaterial?.diffuse.contents = SCNColor.red
        floatObject = makeObject(with: dummyFloat)
    }
    
    func moveFloat(to: SCNVector3) {
        floatObject!.position = to
    }
    
}
