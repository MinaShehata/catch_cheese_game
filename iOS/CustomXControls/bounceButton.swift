//
//  bounceButton.swift
//  customFontS
//
//  Created by Mina Shehata on 7/12/17.
//  Copyright © 2017 Mina Shehata. All rights reserved.
//

import UIKit

class BounceButton: UIButtonX {

    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        titleLabel?.font = UIFont.systemFont(ofSize: 14)//(name: "Yellowtail", size: 14)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 6, options: .allowUserInteraction, animations: {
            self.transform = .identity
        }, completion: nil)
        
        super.touchesBegan(touches, with: event)
        
    }
    
}

