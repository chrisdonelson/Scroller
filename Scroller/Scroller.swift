//
//  Scroller.swift
//  Scroller
//
//  Created by 2Dedi & Blake Arender on 7/17/17.
//  Copyright © 2017 2DediApps. All rights reserved.
//

import Foundation
import SpriteKit
import GameplayKit

class Scroller: SKScene, SKPhysicsContactDelegate {
    
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    var ball: SKSpriteNode!
    var firstPosition: CGPoint!
    var lastPosition: CGPoint!
    private var spinnyNode : SKShapeNode?
    var count = 0
    func touchMoved(toPoint pos : CGPoint) {
        count = count + 1
        print(count)
        
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.white
            self.addChild(n)
         
        }
        else{
            print("fail")
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    override func sceneDidLoad() {
        ball = childNode(withName: "ball") as! SKSpriteNode
        
       
        
        // Get label node from scene and store it for use later
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
            if let label = self.label {
                label.alpha = 0.0
                label.text = "Tap to Begin"
                label.run(SKAction.fadeIn(withDuration: 2.0))
            }
   
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 0.75
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(Double.pi), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }

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
        for touch in touches {
            firstPosition = touch.location(in: self)
        }
    }
    
  
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            lastPosition = touch.location(in: self)
        }
    }

    
    
    
}
