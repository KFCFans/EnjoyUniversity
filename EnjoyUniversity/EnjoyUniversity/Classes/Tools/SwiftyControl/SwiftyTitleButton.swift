//
//  SwiftyTitleButton.swift
//  SwiftyDropdownMenu
//
//  Created by lip on 17/4/19.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class SwiftyTitleButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        guard let titleLabel = titleLabel,let imageView = imageView  else {
            return
        }
        // label 左移一个 imageview 的长度
        titleLabel.frame = titleLabel.frame.offsetBy(dx: -imageView.bounds.width, dy: 0)
        // imageview 右移一个 titlelabel 的长度
        imageView.frame = imageView.frame.offsetBy(dx: titleLabel.bounds.width, dy: 0)
    }

}
