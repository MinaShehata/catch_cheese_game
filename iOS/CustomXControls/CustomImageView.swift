//
//  CustomImageView.swift
//  IntermediateTraining
//
//  Created by Mina Shehata on 11/1/18.
//  Copyright © 2018 Mina Shehata. All rights reserved.
//

import UIKit
import AVFoundation

let imageCashe = NSCache<NSURL , UIImage>()

class CustomImageView: UIImageViewX {

//    var imageUrl: URL?
    
    func loadProfileImageWithUrl(url: URL) {
        image = nil
        imageUrl = url
        if let image = imageCashe.object(forKey: url as NSURL) {
            self.image = image
            return
        }
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            do {
                let imageData = try Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let downloadesImage = UIImage(data: imageData), url == self?.imageUrl {
                        imageCashe.setObject(downloadesImage, forKey: url as NSURL)
                        self?.image = downloadesImage
                    }
                }
            }
            catch
            {
                print(error.localizedDescription)
            }
        }
    }
    
//    func drawPDFfromURL(url: URL) {
//        image = nil
//        imageUrl = url
//        if let image = imageCashe.object(forKey: url as NSURL) {
//            self.image = image
//            return
//        }
//        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
//            guard let document = CGPDFDocument(url as CFURL) else { return }
//            guard let page = document.page(at: 1) else { return  }
//            let pageRect = page.getBoxRect(.mediaBox)
//            let renderer = UIGraphicsImageRenderer(size: pageRect.size)
//            let img = renderer.image { ctx in
//                UIColor.white.set()
//                ctx.fill(pageRect)
//                ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
//                ctx.cgContext.scaleBy(x: 1.0, y: -1.0)
//                ctx.cgContext.drawPDFPage(page)
//            }
//            DispatchQueue.main.async {
//                if url == self?.imageUrl {
//                    imageCashe.setObject(img, forKey: url as NSURL)
//                    self?.image = img
//                }
//            }
//        }
//    }
}

