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
    var bird: SKSpriteNode!
    var line:SKShapeNode = SKShapeNode()
    var path:CGMutablePath = CGMutablePath()
    var initialPointSet:Bool = false
    var posArr = [CGPoint.init(x: -500, y: 200)]
    var moveBallFlag = false
    var posCounter = 1
    var frameRate = 0
    var pauseButton: SKSpriteNode!
    var xDelta: CGFloat = 0



    override func sceneDidLoad() {
        ball = childNode(withName: "ball") as! SKSpriteNode
        bird = childNode(withName:"bird") as! SKSpriteNode
        //ball.position = CGPoint.init(x: -500, y: 300)
        ball.physicsBody?.affectedByGravity = false
        var difficulty = 5
        xDelta = CGFloat(difficulty)
    }
    
    //var difficulty = 5
    
    override func update(_ currentTime: TimeInterval) {
        line.position = CGPoint.init(x: line.position.x-xDelta,y: line.position.y)
        bird.position = CGPoint.init(x: bird.position.x-xDelta,y: bird.position.y)
        ball.position.x-=xDelta
        
    
        if(moveBallFlag == true){
            if(posCounter == posArr.count-1){
              
                posCounter = 1
                posArr.removeAll()
                moveBallFlag = false
                ball.physicsBody?.affectedByGravity = true
            }else{
                if(posArr.count != 0){
                    ball.physicsBody?.affectedByGravity = false
                    if(!toggle){
                        print(posArr.count.description+" "+posCounter.description)
                        if(ball.position.x <= posArr[posCounter-1].x){
                            ball.position = CGPoint.init(x: posArr[posCounter-1].x-1,y: posArr[posCounter-1].y)
                        }
                        posCounter+=1
                    }
                    
                }
            }
            
  
        }
    }
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        ball.physicsBody?.affectedByGravity = true
        
        // Creates an invisible border at the bottom of the screen (Change y)
        let borderBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: -666.0, y: -374.0, width: 1334.0, height: 750.0))
        borderBody.friction = 0
        self.physicsBody = borderBody
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        eraseLine()

        posArr.removeAll()
        posCounter = 1
        
        moveBallFlag = false
        // Starting position of line
        
        pauseButton = childNode(withName: "pause") as! SKSpriteNode
        for t in touches {
            if pauseButton.contains(t.location(in: self)){
                self.pause()
            }
            path.move(to: t.location(in: self))
        }
        
    }
    
    var toggle = false
    func pause(){
       // print("pause")
        if(!toggle){
            
            xDelta =  CGFloat.init(0)
            toggle = !toggle
        }else{
            xDelta = CGFloat.init(3)
            toggle = !toggle
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            drawLine(touch.location(in: self))
            posArr.append(touch.location(in: self))
            addLine()
            print(posArr.count)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
     
        moveBallFlag = true;

    }
    func moveBall(){
        for p in posArr{
            
            ball.position = p
            print(ball.position.debugDescription)
        
        }
    }
    func drawLine(_ point: CGPoint) {
        path.addLine(to: point)
        line.path = path
    }
    
    func addLine() {
        if self.childNode(withName: "line") == nil {
            line.name = "line"
            line.strokeColor = UIColor.white
            line.lineWidth = 8
            addChild(line)
        }
    }
    
    func eraseLine() {
        line.position.x = 0
        self.childNode(withName: "line")?.removeFromParent()
        
        initialPointSet = false
        path = CGMutablePath()
    }
    
}
