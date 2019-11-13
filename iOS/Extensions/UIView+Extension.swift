//
//  UIView+Extension.swift
//  aman-user-ios
//
//  Created by Mina Shehata Gad on 6/7/18.
//  Copyright © 2018 Mina Shehata Gad. All rights reserved.
//

import UIKit
import AVFoundation

extension UIView {
    
    public func fillSuperView(padding: UIEdgeInsets = .zero) {
        anchor(top: superview?.topAnchor, leading: superview?.leadingAnchor, bottom: superview?.bottomAnchor, trailing: superview?.trailingAnchor)
    }
    
    public func anchorSize(to view: UIView, size: CGSize = .zero, center: Bool = false, xConstant: CGFloat = 0, yConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        widthAnchor.constraint(equalToConstant: size.width) .isActive = true
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        if center {
            centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: xConstant).isActive = true
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yConstant).isActive = true
        }
    }
    
    @discardableResult
    public func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero, centerX: Bool = false, centerY: Bool = false, toView: UIView = UIView()) -> [NSLayoutConstraint?] {
        translatesAutoresizingMaskIntoConstraints = false
        var topanchor: NSLayoutConstraint?
        var leadinganchor: NSLayoutConstraint?
        var trailinganchor: NSLayoutConstraint?
        var bottomanchor: NSLayoutConstraint?
        
        var widthanchor: NSLayoutConstraint?
        var heightanchor: NSLayoutConstraint?

        if let top = top { topanchor = topAnchor.constraint(equalTo: top, constant: padding.top)
            topanchor?.isActive = true }
        if let leading = leading { leadinganchor = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
            leadinganchor?.isActive = true }
        if let bottom = bottom { bottomanchor = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
            bottomanchor?.isActive = true }
        if let trailing = trailing { trailinganchor = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
            trailinganchor?.isActive = true }
        
        if size.width != 0 { widthanchor = widthAnchor.constraint(equalToConstant: size.width)
            widthanchor?.isActive = true }
        if size.height != 0 { heightanchor = heightAnchor.constraint(equalToConstant: size.height)
            heightanchor?.isActive = true }
        
        if centerX { centerXAnchor.constraint(equalTo: toView.centerXAnchor).isActive = true }
         if centerY { centerYAnchor.constraint(equalTo: toView.centerYAnchor).isActive = true }
        
        return [topanchor, leadinganchor, bottomanchor, trailinganchor, widthanchor, heightanchor]
    }
    
    public func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: viewsDictionary))
    }
}

