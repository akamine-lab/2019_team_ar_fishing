//
//  ResultViewController.swift
//  team_contents_2019_fishing macOS
//
//  Created by Yuhei Akamine on 2019/12/14.
//  Copyright © 2019 赤嶺有平. All rights reserved.
//

import Cocoa

class ResultViewController: NSViewController {
    
    var gameViewController: GameViewController?
    
    @IBOutlet weak var result: NSTextField!
    
    @IBAction func onOK(_ sender: Any) {
        dismiss(sender)
        
        gameViewController?.retry()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let status = gameViewController?.gameController.status {
            
            result.stringValue = status.result
        }
    }
    
    
}
