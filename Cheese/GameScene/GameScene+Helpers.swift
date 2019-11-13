//
//  GameScene+Helpers.swift
//  Cheese
//
//  Created by Mac Shop on 11/2/19.
//  Copyright © 2019 Mina Shehata. All rights reserved.
//

import SpriteKit

extension GameScene {
    
    func move(sprite: SKSpriteNode, velocity: CGPoint) {
        let amountToMove = velocity * CGFloat(dt)
        sprite.position += amountToMove
    }
    
    func moveSpriteToward(sprite: SKSpriteNode, location: CGPoint) {
        let offset = CGPoint(x: location.x - sprite.position.x, y: location.y - sprite.position.y)
        let length = sqrt(Double(offset.x * offset.x + offset.y * offset.y))
        let direction = CGPoint(x: offset.x / CGFloat(length), y: offset.y / CGFloat(length))
        sheeldVelocity = CGPoint(x: direction.x * sheeldMovePerSecond, y: direction.y * sheeldMovePerSecond)
    }
    
    func rotate(sprite: SKSpriteNode, direction: CGPoint, rotateRadiansPerSec: CGFloat) {
        velocityOfMen.forEach {
            let shortest = shortestAngleBetween(angle1: sprite.zRotation, angle2: $0.angle)
            let amountToRotate = min(rotateRadiansPerSec * CGFloat(dt), abs(shortest))
            sprite.zRotation += shortest.sign() * amountToRotate
        }
    }
    
    func sceneTouched(touchLocation: CGPoint) {
        if lastTouchLocation == touchLocation {
            return
        }
        lastTouchLocation = touchLocation
        moveSpriteToward(sprite: sheeld, location: touchLocation)
    }
    
    
    final func stopSheelAtPosition() {
        if let lastTouchLocation = lastTouchLocation {
            let diff = lastTouchLocation - sheeld.position
            if diff.length() <= sheeldMovePerSecond * CGFloat(dt) {
                sheeld.position = lastTouchLocation
                sheeldVelocity = CGPoint.zero
            } else {
                move(sprite: sheeld, velocity: sheeldVelocity)
                rotate(sprite: sheeld, direction: sheeldVelocity, rotateRadiansPerSec: manRotateRadiansPerSec)
            }
        }
    }
    
    @objc final func checkGameStatus() {
        seconds -= 1
        
        if cheeses.count == 0 || cheeseMen.count == 0 {
            let gameOverScene = GameOverScene(size: size, isWin: false, score: cheeseMen.count)
            gameOverScene.scaleMode = scaleMode
            let reveal = SKTransition.crossFade(withDuration: 0.6)
            view?.presentScene(gameOverScene, transition: reveal)
            run(loseCollisionSound)
        }
    
        if seconds == 0 {
            timer.invalidate()
            let gameOverScene = GameOverScene(size: size, isWin: true, score: cheeseMen.count)
            gameOverScene.scaleMode = scaleMode
            let reveal = SKTransition.crossFade(withDuration: 0.6)
            view?.presentScene(gameOverScene, transition: reveal)
            run(winCollisionSound)
        }
    }
    
}
