//
//  ActivityViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/3/31.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation
import UIKit

class EUActivityViewController: UIViewController {
    
    // 背景图片
    var backgroudImage = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 180))
 
    // 返回按钮
    var backBtn = UIButton()
    
    // 分享按钮
    var shareBtn = UIButton()
    
    // 收藏按钮
    var collectBtn = UIButton()
    
    // 活动标题文本
    var titleLabel = UILabel()
    
    // 分享按钮
    
    // 收藏按钮
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
}

// MARK: - UI 相关方法
extension EUActivityViewController{
    
    fileprivate func setupUI(){
        
        // 背景图(后面用 Kingfisher 加载)
        backgroudImage = UIImageView(image: UIImage(named: "viewpager_1"))
        
        // 返回按钮
        backBtn.setImage(UIImage(named: "tabbar_back"), for: .normal)
        
        // 分享按钮
        
        
        
    }
    
}
