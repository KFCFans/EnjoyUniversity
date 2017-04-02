//
//  EUActivityButton.swift
//  Temple
//
//  Created by lip on 17/4/2.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUActivityButton: UIControl {
    
    var img = UIImageView()
    
    var shadowimg = UIImageView()
    
    var label = UILabel()

    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(frame: CGRect,image:UIImage,text:String,shadowimage:UIImage) {
        super.init(frame: frame)
        label.text = text
        img.image = image
        shadowimg.image = shadowimage
        setupUI()
        
    }

}

// MARK: - UI 相关方法
extension EUActivityButton{
    
    fileprivate func setupUI(){
        
        img.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        shadowimg.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor.black
        label.sizeToFit()
        
        addSubview(shadowimg)
        addSubview(label)
        shadowimg.addSubview(img)
        
        // 遮罩视图
        shadowimg.addConstraint(NSLayoutConstraint(item: shadowimg,
                                             attribute: .width,
                                             relatedBy: .equal,
                                             toItem: nil,
                                             attribute: .notAnAttribute,
                                             multiplier: 1.0,
                                             constant: 35))
        shadowimg.addConstraint(NSLayoutConstraint(item: shadowimg,
                                             attribute: .height,
                                             relatedBy: .equal,
                                             toItem: nil,
                                             attribute: .notAnAttribute,
                                             multiplier: 1.0,
                                             constant: 35))
        self.addConstraint(NSLayoutConstraint(item: shadowimg,
                                             attribute: .centerX,
                                             relatedBy: .equal,
                                             toItem: self,
                                             attribute: .centerX,
                                             multiplier: 1.0,
                                             constant: 0))
        self.addConstraint(NSLayoutConstraint(item: shadowimg,
                                             attribute: .top,
                                             relatedBy: .equal,
                                             toItem: self,
                                             attribute: .top,
                                             multiplier: 1.0,
                                             constant: 0))
        
        // 图像
        img.addConstraint(NSLayoutConstraint(item: img,
                                                   attribute: .width,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: 1.0,
                                                   constant: 20))
        img.addConstraint(NSLayoutConstraint(item: img,
                                                   attribute: .height,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: 1.0,
                                                   constant: 20))
        shadowimg.addConstraint(NSLayoutConstraint(item: img,
                                              attribute: .centerX,
                                              relatedBy: .equal,
                                              toItem: shadowimg,
                                              attribute: .centerX,
                                              multiplier: 1.0,
                                              constant: 0))
        shadowimg.addConstraint(NSLayoutConstraint(item: img,
                                              attribute: .centerY,
                                              relatedBy: .equal,
                                              toItem: shadowimg,
                                              attribute: .centerY,
                                              multiplier: 1.0,
                                              constant: 0))
        
        // Label
        self.addConstraint(NSLayoutConstraint(item: label,
                                              attribute: .centerX,
                                              relatedBy: .equal,
                                              toItem: self,
                                              attribute: .centerX,
                                              multiplier: 1.0,
                                              constant: 0))
        self.addConstraint(NSLayoutConstraint(item: label,
                                              attribute: .top,
                                              relatedBy: .equal,
                                              toItem: img,
                                              attribute: .bottom,
                                              multiplier: 1.0,
                                              constant: 10))
        
     
        
    }
    
}
