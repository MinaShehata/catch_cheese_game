//
//  IndentLabel.swift
//  IntermediateTraining
//
//  Created by Mina Shehata on 10/25/18.
//  Copyright © 2018 Mina Shehata. All rights reserved.
//

import UIKit

class IndentLabel: UILabelX {
    
    override func drawText(in rect: CGRect) {
        let customRect = CGRect(x: 3, y: 0, width: self.frame.width - 6, height: self.frame.height)
        super.drawText(in: customRect)
    }
    
}

class InsuranceIndentLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        let customRect = CGRect(x: 3, y: 0, width: (self.frame.width - 6), height: self.frame.height)
        super.drawText(in: customRect)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
       

    }
    
}
