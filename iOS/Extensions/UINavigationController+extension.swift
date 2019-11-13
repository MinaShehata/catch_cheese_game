//
//  CustomNavigationController.swift
//  IntermediateTraining
//
//  Created by Mina Shehata on 10/8/18.
//  Copyright © 2018 Mina Shehata. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func addRightBarButton(image: UIImage, with selector: Selector) -> UIBarButtonItem {
        let rightButton = UIBarButtonItem(image: image, style: .plain, target: self, action: selector)
        navigationItem.rightBarButtonItem = rightButton
        return rightButton
    }
    
    func addRightBarButton(title: String, selector: Selector) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: selector)
    }
    
    func addLeftBarButton(title: String, selector: Selector) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: self, action: selector)
    }
    
    func addLeftBarButton(image: UIImage, selector: Selector) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: selector)
    }
    
    func addLeftBarButtons(images: [UIImage], selector: [Selector]) {
        var barButtons = [UIBarButtonItem]()
        for (index, image) in images.enumerated() {
            barButtons.append(UIBarButtonItem(image: image, style: .plain, target: self, action: selector[index]))
        }
        navigationItem.leftBarButtonItems = barButtons
    }
    
    func addRightBarButtons(images: [UIImage], selector: [Selector]) {
        var barButtons = [UIBarButtonItem]()
        for (index, image) in images.enumerated() {
            barButtons.append(UIBarButtonItem(image: image, style: .plain, target: self, action: selector[index]))
        }
        navigationItem.rightBarButtonItems = barButtons
    }
    
    
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true)
    }
    
    
    @objc func dismissView() {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
}
