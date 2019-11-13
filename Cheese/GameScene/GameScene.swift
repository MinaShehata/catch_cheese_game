//
//  GameScene.swift
//  Cheese
//
//  Created by Mac Shop on 10/31/19.
//  Copyright © 2019 Mina Shehata. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    var timer: Timer!
    var seconds = 20
    var background: SKSpriteNode!
    var cheeses: [SKSpriteNode]!
    var cheeseMen: [SKSpriteNode]!
    var sheeld: SKSpriteNode!
    
    // properities
    let playableRect: CGRect
    var velocityOfCheeses = [CGPoint]()
    var velocityOfMen = [CGPoint]()
    //
    var cheesesMovePerSecond = [CGFloat]()
    var menMovePerSecond = [CGFloat]()
    var menAnimation: SKAction!
    
    //
    var sheeldMovePerSecond: CGFloat = 800
    var sheeldVelocity = CGPoint.zero
    //
    var lastUpdateTime: TimeInterval = 0
    var dt: TimeInterval = 0
    var lastTouchLocation: CGPoint?
    let manRotateRadiansPerSec: CGFloat = 4.0 * π
    
    
    
    // sounds
    let cheeseCollisionSound: SKAction = SKAction.playSoundFileNamed(
      "hitCat.wav", waitForCompletion: false)
    let sheeldCollisionSound: SKAction = SKAction.playSoundFileNamed(
      "hitCatLady.wav", waitForCompletion: false)
    let winCollisionSound: SKAction = SKAction.playSoundFileNamed(
      "win.wav", waitForCompletion: false)
    let loseCollisionSound: SKAction = SKAction.playSoundFileNamed(
      "lose.mp3", waitForCompletion: false)
    let backgroundMusicCollisionSound: SKAction = SKAction.playSoundFileNamed(
      "backgroundMusic.wav", waitForCompletion: false)

    // result
    var gameOver = false
    var time = 60
    
    override init(size: CGSize) {
        let maxAspectRatio:CGFloat = 16.0/9.0
        let playableHeight = size.width / maxAspectRatio
        let playableMargin = (size.height-playableHeight)/2.0
        playableRect = CGRect(x: 0, y: playableMargin, width: size.width, height: playableHeight)
        super.init(size: size)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(checkGameStatus), userInfo: nil, repeats: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func didMove(to view: SKView) {
        // setup background image
        gameBackgroundUI()
        // add sheeld first
        addGameSheeld()
        // setup random cheese
        gameCheese()
        initialCheesesMoving()
        // setup random cheese
        gameCheeseMen()
        initialMenMoving()
        
        
        
        
        
        // debug area
        debugDrawPlayableArea()
        
        physicsWorld.contactDelegate = self
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let loc = touches.first?.location(in: self) else { return }
        sceneTouched(touchLocation: loc)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let loc = touches.first?.location(in: self) else { return }
        sceneTouched(touchLocation: loc)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        guard let loc = touches.first?.location(in: self) else { return }
//        sceneTouched(touchLocation: loc)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        
        // calculate smoth move and rotation
        if lastUpdateTime > 0 {
            dt = currentTime - lastUpdateTime
        } else {
            dt = 0
        }
        lastUpdateTime = currentTime
        
        
        //move cheese random position
        moveCheesesInRandomDirections()
        //move man random position
        moveCheeseMenInRandomDirections()
        //sheeld movements
        move(sprite: sheeld, velocity: sheeldVelocity)
        stopSheelAtPosition()
        boundsCheckForSheeld(sprite: sheeld)

        
        
    }
    
    override func didEvaluateActions() {
        
    }
    
    
}
