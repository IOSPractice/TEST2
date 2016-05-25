//
//  MyLabel.swift
//  実習
//
//  Created by 大木一輝 on 2016/05/25.
//  Copyright © 2016年 mycompany. All rights reserved.
//


import UIKit

@IBDesignable class MyLabel: UILabel {
    @IBInspectable var borderWidth: CGFloat = 0.0
    @IBInspectable var borderColor: UIColor = UIColor.clearColor()
    
    override func drawRect(rect: CGRect) {
        self.layer.borderWidth = self.borderWidth
        self.layer.borderColor = self.borderColor.CGColor
        
        super.drawRect(rect)
    }
}