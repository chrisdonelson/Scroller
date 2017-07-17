//
//  Scroller.swift
//  Scroller
//
//  Created by Christopher Donelson on 7/17/17.
//  Copyright © 2017 2DediApps. All rights reserved.
//

import Foundation
import SpriteKit

class Scroller: SKScene, SKPhysicsContactDelegate {
    
    var ball: SKSpriteNode!

    override func sceneDidLoad() {
        ball = childNode(withName: "ball") as! SKSpriteNode

    }
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        ball.physicsBody?.affectedByGravity = true
        
        // Creates an invisible border at the bottom of the screen (Change y)
        let borderBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: -275.0, y: -374.0, width: 1334.0, height: 750.0))
        borderBody.friction = 0
        self.physicsBody = borderBody
        
    }
    
    
}
