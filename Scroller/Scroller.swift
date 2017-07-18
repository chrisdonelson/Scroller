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
    
    var entities = [GKEntity]()
    private var lastUpdateTime : TimeInterval = 0
    private var label : SKLabelNode?
    var ball: SKSpriteNode!
    var firstPosition: CGPoint!
    var lastPosition: CGPoint!
    private var spinnyNode : SKShapeNode?
    var count = 0
    var posArr = Array(repeating: CGPoint(), count:1000)
    
    
    override func sceneDidLoad() {
        ball = childNode(withName: "ball") as! SKSpriteNode
        
       
        
        // Get label node from scene and store it for use later
        /*
        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
            if let label = self.label {
                label.alpha = 0.0
                label.text = "Tap to Begin"
                label.run(SKAction.fadeIn(withDuration: 2.0))
            }
 */
   
        // Create shape node to use during mouse interaction
       // let w = (self.size.width + self.size.height) * 0.05
        let w = 2.5
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: 0.4)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
         
        }

    }

    func touchMoved(toPoint pos : CGPoint) {
        count = count + 1
        for point in posArr {
            if(point.x == 0 || point.y == 0){}
            else{
                print(count.description+": "+point.x.description+" "+point.y.description)
            }
        }
        
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            posArr.append(pos)
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

    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        //ball.position = posArr[posArr.count-1]
        for p in posArr{
            ball.position = p
        }
        // Initialize _lastUpdateTime if it has not already been
        if self.lastUpdateTime == 0 {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        
        self.lastUpdateTime = currentTime
    }

    
    
}
