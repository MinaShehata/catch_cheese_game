//
//  GameScene+AssetExtension.swift
//  Cheese
//
//  Created by Mac Shop on 10/31/19.
//  Copyright © 2019 Mina Shehata. All rights reserved.
//

import SpriteKit

extension GameScene: SKPhysicsContactDelegate {
    final func addGameSheeld() {
        sheeld = SKSpriteNode(imageNamed: "sheeld")
        sheeld.name = "sheeld"
        let physics = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
        sheeld.physicsBody = physics
        physics.isDynamic = false
        physics.allowsRotation = false
        physics.affectedByGravity = false
        physics.friction = 0
        physics.restitution = 0
        physics.categoryBitMask = 1
        physics.collisionBitMask = 2
        physics.fieldBitMask = 0
        physics.contactTestBitMask = 2
        sheeld.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(sheeld)
    }
    
    final func gameBackgroundUI() {
        background = SKSpriteNode(imageNamed: "background")
        background.size = CGSize(width: size.width, height: size.height)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.zPosition = -1
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(background)
    }
    
    
    final func gameCheese() {
        cheeses = []
        for _ in 0...get_random_number(min: 1, max: 5) {
            let cheese = SKSpriteNode(imageNamed: "cheese")
            cheese.name = "cheese"
            let physics = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
            cheese.physicsBody = physics
            physics.isDynamic = true
            physics.allowsRotation = false
            physics.affectedByGravity = false
            physics.friction = 0
            physics.restitution = 1
            physics.categoryBitMask = 2
            physics.collisionBitMask = 1
            physics.fieldBitMask = 0
            physics.contactTestBitMask = 1
            cheese.position = CGPoint(x: CGFloat.random(min: playableRect.minX, max: playableRect.maxX), y: CGFloat.random(min: playableRect.maxY, max: playableRect.maxY + 10))
            cheeses.append(cheese)
        }
        
        for cheese in cheeses {
            addChild(cheese)
            cheesesMovePerSecond.append(CGFloat.random(min: 50, max: 100))
            velocityOfCheeses.append(CGPoint(x: CGFloat.random(min: 60, max: 120), y: CGFloat.random(min: 70, max: 140)))
        }
    }
    
    final func initialCheesesMoving() {
        var pos = 0.4
        for cheese in cheeses {
            moveSpriteToward(sprite: cheese, location: CGPoint(x: pos, y: pos))
            pos += 0.1
        }
    }
    final func gameCheeseMen() {
        cheeseMen = []
        var textures: [SKTexture] = []
        
        for i in 1...4 {
            textures.append(SKTexture(imageNamed: "zombie\(i)"))
        }
        textures.append(textures[2])
        textures.append(textures[1])
        textures.append(textures[0])
        menAnimation = SKAction.animate(with: textures, timePerFrame: 0.1)
        
        for _ in 0...get_random_number(min: 1, max: 5) {
            let cheeseMan = SKSpriteNode(imageNamed: "zombie1")
            cheeseMan.name = "man"
            let physics = SKPhysicsBody(rectangleOf: CGSize(width: 50, height: 50))
            cheeseMan.physicsBody = physics
            physics.isDynamic = true
            physics.allowsRotation = false
            physics.affectedByGravity = false
            physics.friction = 0
            physics.restitution = 1
            physics.categoryBitMask = 1
            physics.collisionBitMask = 2
            physics.fieldBitMask = 0
            physics.contactTestBitMask = 2
            cheeseMan.position = CGPoint(x: CGFloat.random(min: playableRect.minX, max: playableRect.maxX), y: CGFloat.random(min: playableRect.minY, max: playableRect.minY + 10))
            cheeseMen.append(cheeseMan)
                
        }
        for cheeseMan in cheeseMen {
            addChild(cheeseMan)
            menMovePerSecond.append(CGFloat.random(min: 50, max: 100))
            velocityOfMen.append(CGPoint(x: CGFloat.random(min: 60, max: 120), y: CGFloat.random(min: 70, max: 140)))
        }
    }
    
    final func initialMenMoving() {
        var pos = 0.4
        for man in cheeseMen {
            moveSpriteToward(sprite: man, location: CGPoint(x: pos, y: pos))
            pos += 0.1
//            man.run(SKAction.repeatForever(menAnimation))
        }
        startZombieAnimation()
    }
    func startZombieAnimation() {
        for man in cheeseMen {
            if man.action(forKey: "animation") == nil {
                man.run(SKAction.repeatForever(menAnimation), withKey: "animation")
            }
        }
    }
    func stopZombieAnimation() {
        for man in cheeseMen {
            man.removeAction(forKey: "animation")
        }
    }
    
    final func moveCheesesInRandomDirections() {
        for (index, cheese) in cheeses.enumerated() {
            move(sprite: cheese, velocity: velocityOfCheeses[index])
            boundsCheckForCheese(sprite: cheese, index: index)
//            sheeldCheckForCheese(sprite: cheese, index: index)
        }
    }
    
    final func moveCheeseMenInRandomDirections() {
        for (index, man) in cheeseMen.enumerated() {
            move(sprite: man, velocity: velocityOfMen[index])
            boundsCheckForMan(sprite: man, index: index)
            rotate(sprite: man, direction: velocityOfMen[index], rotateRadiansPerSec: manRotateRadiansPerSec)
        }
    }
    
    
    func cheeseHitMan(cheese: SKSpriteNode, man: SKSpriteNode) {
        man.removeFromParent()
        guard let index = cheeseMen.firstIndex(of: man) else { return }
        cheeseMen.remove(at: index)
        cheese.removeFromParent()
        guard let chesseindex = cheeses.firstIndex(of: cheese) else { return }
        cheeses.remove(at: chesseindex)
        
        run(cheeseCollisionSound)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var manHits = [SKSpriteNode]()
        var cheeseHits = [SKSpriteNode]()
        
        let cheese = contact.bodyA.node?.name
        let man = contact.bodyB.node?.name
        
        if (cheese == "cheese" && man == "man") || (man == "cheese" && cheese == "man") {
            if (cheese == "cheese" && man == "man") {
                let cheeseNode = contact.bodyA.node as! SKSpriteNode
                cheeseHits.append(cheeseNode)
                let manNode = contact.bodyB.node as! SKSpriteNode
                manHits.append(manNode)
            } else if (man == "cheese" && cheese == "man") {
                let cheeseNode = contact.bodyB.node as! SKSpriteNode
                let manNode = contact.bodyA.node as! SKSpriteNode
                cheeseHits.append(cheeseNode)
                manHits.append(manNode)
            }
          
        }
        
        for (index, man) in manHits.enumerated() {
            cheeseHitMan(cheese: cheeseHits[index], man: man)
        }
        
       
    }
    
    
    func debugDrawPlayableArea() {
        let shape = SKShapeNode(rect: playableRect)
        shape.strokeColor = SKColor.black
        shape.lineWidth = 4.0
        addChild(shape)
    }
    
    func boundsCheckForCheese(sprite: SKSpriteNode, index: Int) {
        let bottomLeft = CGPoint(x: 0, y: playableRect.minY)
        let topRight = CGPoint(x: size.width, y: playableRect.maxY)
        
        if sprite.position.x <= bottomLeft.x {
            sprite.position.x = bottomLeft.x
            velocityOfCheeses[index].x = -velocityOfCheeses[index].x
        }
        
        if sprite.position.x >= topRight.x {
            sprite.position.x = topRight.x
            velocityOfCheeses[index].x = -velocityOfCheeses[index].x
        }
        
        if sprite.position.y <= bottomLeft.y {
            sprite.position.y = bottomLeft.y
            velocityOfCheeses[index].y = -velocityOfCheeses[index].y
        }
        
        if sprite.position.y >= topRight.y {
            sprite.position.y = topRight.y
            velocityOfCheeses[index].y = -velocityOfCheeses[index].y
        }
        
    }
    func sheeldCheckForCheese(sprite: SKSpriteNode, index: Int) {
        let sheeldBottomLeft = CGPoint(x: sheeld.frame.origin.x, y: sheeld.frame.origin.y)
        let sheeldTopRight = CGPoint(x: sheeld.frame.width, y: sheeld.frame.height)
        
        if sprite.position.x <= sheeldBottomLeft.x {
            sprite.position.x = sheeldBottomLeft.x
            velocityOfCheeses[index].x = -velocityOfCheeses[index].x
        }
        
        if sprite.position.x >= sheeldTopRight.x {
            sprite.position.x = sheeldTopRight.x
            velocityOfCheeses[index].x = -velocityOfCheeses[index].x
        }
        
        if sprite.position.y <= sheeldBottomLeft.y {
            sprite.position.y = sheeldBottomLeft.y
            velocityOfCheeses[index].y = -velocityOfCheeses[index].y
        }
        
        if sprite.position.y >= sheeldTopRight.y {
            sprite.position.y = sheeldTopRight.y
            velocityOfCheeses[index].y = -velocityOfCheeses[index].y
        }
        
    }
    
    func boundsCheckForMan(sprite: SKSpriteNode, index: Int) {
        let bottomLeft = CGPoint(x: 0, y: playableRect.minY)
        let topRight = CGPoint(x: size.width, y: playableRect.maxY)
        
        if sprite.position.x <= bottomLeft.x {
            sprite.position.x = bottomLeft.x
            velocityOfMen[index].x = -velocityOfMen[index].x
        }
        
        if sprite.position.x >= topRight.x {
            sprite.position.x = topRight.x
            velocityOfMen[index].x = -velocityOfMen[index].x
        }
        
        if sprite.position.y <= bottomLeft.y {
            sprite.position.y = bottomLeft.y
            velocityOfMen[index].y = -velocityOfMen[index].y
        }
        
        if sprite.position.y >= topRight.y {
            sprite.position.y = topRight.y
            velocityOfMen[index].y = -velocityOfMen[index].y
        }
        
        rotate(sprite: sprite, direction: velocityOfMen[index], rotateRadiansPerSec: manRotateRadiansPerSec)
    }
    
    func boundsCheckForSheeld(sprite: SKSpriteNode) {
        
        let bottomLeft = CGPoint(x: 0, y: playableRect.minY)
        let topRight = CGPoint(x: size.width, y: playableRect.maxY)
        
        if sprite.position.x <= bottomLeft.x {
            sprite.position.x = bottomLeft.x
            sheeldVelocity.x = -sheeldVelocity.x
        }
        
        if sprite.position.x >= topRight.x {
            sprite.position.x = topRight.x
            sheeldVelocity.x = -sheeldVelocity.x
        }
        
        if sprite.position.y <= bottomLeft.y {
            sprite.position.y = bottomLeft.y
            sheeldVelocity.y = -sheeldVelocity.y
        }
        
        if sprite.position.y >= topRight.y {
            sprite.position.y = topRight.y
            sheeldVelocity.y = -sheeldVelocity.y
        }
    }
    
}



