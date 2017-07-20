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

    override func sceneDidLoad() {
        ball = childNode(withName: "ball") as! SKSpriteNode
        bird = childNode(withName:"bird") as! SKSpriteNode
        //ball.position = CGPoint.init(x: -500, y: 300)
        ball.physicsBody?.affectedByGravity = false
    }
    override func update(_ currentTime: TimeInterval) {
        line.position = CGPoint.init(x: line.position.x-1,y: line.position.y)
        bird.position = CGPoint.init(x: bird.position.x-1, y: bird.position.y)
        ball.position.x-=1
        
       // self.position.x-=1
        if(line.position.x <= -400){
          
        }
        //self.frameRate = 10
        if(moveBallFlag == true){
            if(posCounter == posArr.count-1){
                //move ball up and down
               // ball.position = CGPoint.init(x: posArr[posCounter-1].x-1,y: posArr[posCounter-1].y)
                //ball.physicsBody?.affectedByGravity = true
                
                print(posArr.count.description+" "+(posCounter-1).description)
                print(posArr)
                
               //line.position.x = 0
               //eraseLine()
                posCounter = 1
                posArr.removeAll()
                moveBallFlag = false
            }else{
                if(posArr.count != 0){
                    ball.physicsBody?.affectedByGravity = false

                    print(posArr.count.description+" "+posCounter.description)
                    if(ball.position.x <= posArr[posCounter-1].x){
                        ball.position = CGPoint.init(x: posArr[posCounter-1].x-1,y: posArr[posCounter-1].y)
                    }
                    posCounter+=1
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
        for t in touches {
            path.move(to: t.location(in: self))
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
        //addLine()
        moveBallFlag = true;
        //moveBall()
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
