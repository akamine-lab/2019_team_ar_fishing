//
//  GameScene.swift
//  team_contents_2019_fishing
//
//  Created by Yuhei Akamine on 2019/12/06.
//  Copyright © 2019 赤嶺有平. All rights reserved.
//

import Foundation
import SceneKit

class GameStatus {
    var eyePoint = SCNVector3()   //視点（カメラの位置)
    var viewVector = SCNVector3() //視線ベクトル（カメラの向き）
    
    var result = "small fish"
}

protocol GameScene {
    func touched()
    func released()
    
    func prepare()
    func update()
    
    func name() -> String
    func nextScene() -> GameScene?
}

class GameSceneBase: GameScene {
    var gameStatus : GameStatus //集約（強い参照）
    unowned let visualizer: FishingVisualizer // 関連(弱参照)
    
    init(status: GameStatus, visualizer: FishingVisualizer) {
        self.gameStatus = status
        self.visualizer = visualizer
    }
    
    init(base: GameSceneBase) {
        self.gameStatus = base.gameStatus
        self.visualizer = base.visualizer
    }
    
    func touched() {
    }
    
    func released() {
    }
    
    func prepare() {
    }
    
    func update() {
    }
    
    func name() -> String {
        fatalError("name func must be overrided.")
    }
    
    func nextScene() -> GameScene? {
        fatalError("nextScene func must be overrided.")
    }
}

