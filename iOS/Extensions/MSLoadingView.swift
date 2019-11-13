//
//  MSLoadingView.swift
//  Template-iOS
//
//  Created by Mina Shehata on 1/3/19.
//  Copyright © 2019 Mina Shehata. All rights reserved.
//

import UIKit

protocol SpinnerView {
    func ShowSpinner()
    func HideSpinner()
}

class MSLoadingView: UIViewXRadialGradient {
    
    let blackView: UIVisualEffectViewX = {
        let bv = UIVisualEffectViewX()
        bv.backgroundColor = UIColor.clear//.withAlphaComponent(0.5)
        bv.alpha = 0.8
        bv.cornerRadius = 15
        bv.shadowColor = .black
        bv.shadowOffset = CGSize(width: 0.5, height: 0.5)
        bv.shadowRadius = 4
        bv.shadowOpacity = 0.5
        return bv
    }()
    
    let upload_Label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.orangeColor.withAlphaComponent(0.3)//.clear
        //        InsideColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        //        OutsideColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2643407534)
        upload_Label.text = nil
        
        addSubview(blackView)
        blackView.anchorSize(to: self, size: CGSize(width: 100, height: 100), center: true)
        
        //        blackView.contentView.addSubview(activityIndicator)
        //        activityIndicator.anchorSize(to: blackView.contentView, size: .zero, center: true)
        addSubview(upload_Label)
        upload_Label.anchor(top: blackView.bottomAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 16, left: 0, bottom: 0, right: 0), centerX: true, toView: blackView)
    }
    
    
    class func addLoadingImageOn(view: UIView) {
        
        let imageView = UIImageView()
        view.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        // setypAnimation.......
        
        var arrayOfImages = [UIImage]()
        for i in 0...29 {
            if let img = UIImage(named: "\(i)") {
                arrayOfImages.append(img)
            }
        }
        // start animation loading.......
        
        imageView.animationImages = arrayOfImages
        imageView.animationDuration = 1.1
        imageView.animationRepeatCount = 0 // infinite
        imageView.startAnimating()
        
    }
    
}


extension UIViewController {
    
    public func StartLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.showApplicationNetworkActivityIndicator()
            guard let window = UIApplication.shared.keyWindow else { return }
            let view = MSLoadingView(frame: window.frame)
            window.addSubview(view)
            MSLoadingView.addLoadingImageOn(view: view.blackView.contentView)
            //            view.activityIndicator.startAnimating()
//            Transition.transition(with: window)
        }
    }
    
    public func StopLoading() {
        DispatchQueue.main.async { [weak self] in
            guard let window = UIApplication.shared.keyWindow else { return }
            self?.hideApplicationNetworkActivityIndicator()
            window.subviews.forEach {
                if let msLoaderView = $0 as? MSLoadingView {
                    //                    msLoaderView.activityIndicator.stopAnimating()
                    msLoaderView.removeFromSuperview()
                }
            }
//            Transition.transition(with: window)
        }
    }
    
    // MARK: - Helpers
    private func showApplicationNetworkActivityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    private func hideApplicationNetworkActivityIndicator() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}

