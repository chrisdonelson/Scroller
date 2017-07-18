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
    var line:SKShapeNode = SKShapeNode()
    var path:CGMutablePath = CGMutablePath()
    var initialPointSet:Bool = false

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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        eraseLine()
        
        // Starting position of line
        for t in touches {
            path.move(to: t.location(in: self))
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            drawLine(touch.location(in: self))
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        addLine()
    }
    
    func drawLine(_ point: CGPoint) {
        path.addLine(to: point)
        line.path = path
    }
    
    func addLine() {
        line.name = "line"
        line.strokeColor = UIColor.white
        line.lineWidth = 8
        addChild(line)
    }
    
    func eraseLine() {
        self.childNode(withName: "line")?.removeFromParent()
        initialPointSet = false
        path = CGMutablePath()
    }
    
}
