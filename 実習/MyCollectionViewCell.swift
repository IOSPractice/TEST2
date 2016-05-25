//
//  MyCollectionViewCell.swift
//  実習
//
//  Created by 大木一輝 on 2016/05/23.
//  Copyright © 2016年 mycompany. All rights reserved.
//

import UIKit

class MyCollectionViewCell : UICollectionViewCell {
        

    @IBOutlet weak var textView: UITextView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
}


