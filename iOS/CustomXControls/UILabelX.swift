//
//  UILabelX.swift
//  DesignableXTesting
//
//  Created by Mark Moeykens on 1/28/17.
//  Copyright © 2017 Moeykens. All rights reserved.
//

import UIKit

@IBDesignable
class UILabelX: UILabel {
    
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0.0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear {
        didSet {
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable var rotationAngle: CGFloat = 0 {
        didSet {
            self.transform = CGAffineTransform(rotationAngle: rotationAngle * .pi / 180)
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
//        textAlignment = Language.currentLanguage().contains("ar") ? .right : .left
    }
    
    // MARK: - Shadow
    
    @IBInspectable public var ShadowOpacity: Float = 0 {
        didSet {
            layer.shadowOpacity = ShadowOpacity
        }
    }
    @IBInspectable public var ShadowwColor: UIColor = UIColor.clear {
        didSet {
            layer.shadowColor = ShadowwColor.cgColor
        }
    }
    @IBInspectable public var ShadowRadius: CGFloat = 0{
        didSet {
            layer.shadowRadius = ShadowRadius
        }
    }
    @IBInspectable public var ShadowwOffset: CGSize = CGSize(width: 0, height: 0){
        didSet {
            layer.shadowOffset = ShadowwOffset
        }
    }
    
}
