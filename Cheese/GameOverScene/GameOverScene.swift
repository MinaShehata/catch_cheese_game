//
//  GameOverScene.swift
//  Cheese
//
//  Created by Mac Shop on 11/4/19.
//  Copyright © 2019 Mina Shehata. All rights reserved.
//

import Foundation
import SpriteKit

class GameOverScene: SKScene {
    
    private var timer: Timer!
    var seconds = 0
    let isWin: Bool
    var background: SKSpriteNode!
    var score: Int
    var scoreLabel: SKLabelNode!
    init(size: CGSize, isWin: Bool, score: Int) {
        self.isWin = isWin
        self.score = score
        super.init(size: size)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMove(to view: SKView) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(resetToStart), userInfo: nil, repeats: true)
        timer.fire()
        switch isWin {
        case true:
            background = SKSpriteNode(imageNamed: "win_screen")
        case false:
            background = SKSpriteNode(imageNamed: "lose_screen")
        }
        background.size = CGSize(width: size.width, height: size.height)
        background.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        background.zPosition = -1
        background.position = CGPoint(x: size.width / 2, y: size.height / 2)
        addChild(background)
        
        scoreLabel = SKLabelNode(attributedText: NSAttributedString(string: "Your score is : \(score)", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white, NSAttributedString.Key.font : UIFont.systemFont(ofSize: 60, weight: .medium)]))
        
        scoreLabel.position = CGPoint(x: size.width / 2, y: size.height / 3)
        addChild(scoreLabel)
    }
    
    
    @objc func resetToStart() {
        seconds += 1
        if seconds == 5 {
            guard let window = UIApplication.shared.keyWindow else { return }
            window.rootViewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
            UIView.transition(with: window, duration: 0.5, options: [.transitionCrossDissolve], animations: nil, completion: nil)
        }
    }
    
    deinit {
        timer = nil
    }
}
