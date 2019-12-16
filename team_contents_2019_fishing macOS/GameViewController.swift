//
//  GameViewController.swift
//  team_contents_2019_fishing macOS
//
//  Created by Yuhei Akamine on 2019/12/04.
//  Copyright © 2019 赤嶺有平. All rights reserved.
//

import Cocoa
import SceneKit



class GameViewController: NSViewController {
    
    var gameView: SCNView {
        return self.view as! SCNView
    }
    
    var gameController: GameController!
    
    var keyState = Set<UInt16>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.gameController = GameController(sceneRenderer: gameView, view: gameView)
        
        // Allow the user to manipulate the camera
        self.gameView.allowsCameraControl = true
        
        // Show statistics such as fps and timing information
        self.gameView.showsStatistics = true
        
        // Configure the view
        self.gameView.backgroundColor = NSColor.black
        
        // Add a click gesture recognizer
        let clickGesture = NSClickGestureRecognizer(target: self, action: #selector(handleClick(_:)))
        var gestureRecognizers = gameView.gestureRecognizers
        gestureRecognizers.insert(clickGesture, at: 0)
        self.gameView.gestureRecognizers = gestureRecognizers
        

        NSEvent.addLocalMonitorForEvents(matching: .keyDown) {
            (event) -> NSEvent? in self.keyDown(with: event); return event
        }
        NSEvent.addLocalMonitorForEvents(matching: .keyUp) {
            (event) -> NSEvent? in self.keyUp(with: event); return event
        }
        
         Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) {[weak self] _ in
             self?.onTimer()
         }
    }
    
    func onTimer() {
        if gameController.scene is ResultSceneDummy {
            gameController.scene = nil
            
            let storyboard = self.storyboard!
            
            let nextView = storyboard.instantiateController(withIdentifier: "resultView") as! ResultViewController
            
            nextView.gameViewController = self
           
            //presentAsModalWindow(nextView)
            //present(nextView, animator: nil)
            presentAsSheet(nextView)
        }
    }
    
    func retry() {
        gameController.retry()
    }

    
    @objc
    func handleClick(_ gestureRecognizer: NSGestureRecognizer) {
        // Highlight the clicked nodes
        //let p = gestureRecognizer.location(in: gameView)
    }
    
    override func keyDown(with event: NSEvent) {
        //let pos = event.locationInWindow
        
        if !keyState.contains(event.keyCode) {
            gameController.touchBegin()
            keyState.insert(event.keyCode)
        }
    }
    
    override func keyUp(with event: NSEvent) {
        
        //let pos = event.locationInWindow
        gameController.touchEnd()
        keyState.remove(event.keyCode)
    }
    
}
