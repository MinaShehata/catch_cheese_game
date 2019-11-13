//
//  DynamicCollectionView.swift
//  Medica-Egypt-iOS
//
//  Created by Mina Shehata on 2/11/19.
//  Copyright © 2019 Mina Shehata. All rights reserved.
//

import UIKit

class DynamicCollectionView: UICollectionView {

    override func layoutSubviews() {
        super.layoutSubviews()
        if bounds.size != intrinsicContentSize {
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return self.contentSize
    }
}
