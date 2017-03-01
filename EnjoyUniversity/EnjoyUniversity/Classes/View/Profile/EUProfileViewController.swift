//
//  EUProfileViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/2/27.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUProfileViewController: EUBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupProfilePage()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

// MARK: - UI 相关方法
extension EUProfileViewController{
    
    /// 取消父类的 NavigationBar
    override func setupNavBar() {
        
    }
    
    /// 布局
    fileprivate func setupProfilePage(){
        
        let headview = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 132))
        headview.backgroundColor = UIColor.white
        view.addSubview(headview)
        
        let profileimg = UIImageView(image: UIImage(named: "profile_profile"))
        headview.addSubview(profileimg)
        
        let nickname = UILabel()
        nickname.text = "我的昵称"
        nickname.font = UIFont.boldSystemFont(ofSize: 16)
        nickname.sizeToFit()
        headview.addSubview(nickname)
        
        let vipimg = UIImageView(image: UIImage(named: "profile_vip"))
        headview.addSubview(vipimg)
        
        // 自动布局
        headview.translatesAutoresizingMaskIntoConstraints = false
        headview.addConstraint(NSLayoutConstraint(item: headview,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1.0,
                                                  constant: 132))
        headview.addConstraint(NSLayoutConstraint(item: headview,
                                                  attribute: .width,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 1.0,
                                                  constant: UIScreen.main.bounds.width))
        
        
        
        profileimg.translatesAutoresizingMaskIntoConstraints = false
        headview.addConstraint(NSLayoutConstraint(item: profileimg,
                                                  attribute: .centerY,
                                                  relatedBy: .equal,
                                                  toItem: headview,
                                                  attribute: .centerY,
                                                  multiplier: 1.0,
                                                  constant: 0))
        headview.addConstraint(NSLayoutConstraint(item: profileimg,
                                                  attribute: .left,
                                                  relatedBy: .equal,
                                                  toItem: headview,
                                                  attribute: .left,
                                                  multiplier: 1.0,
                                                  constant: 12))
        
        nickname.translatesAutoresizingMaskIntoConstraints = false
        headview.addConstraint(NSLayoutConstraint(item: nickname,
                                                  attribute: .centerY,
                                                  relatedBy: .equal,
                                                  toItem: headview,
                                                  attribute: .centerY,
                                                  multiplier: 1.0,
                                                  constant: 0))
        headview.addConstraint(NSLayoutConstraint(item: nickname,
                                                  attribute: .left,
                                                  relatedBy: .equal,
                                                  toItem: profileimg,
                                                  attribute: .right,
                                                  multiplier: 1.0,
                                                  constant: 6))
        
        vipimg.translatesAutoresizingMaskIntoConstraints = false
        headview.addConstraint(NSLayoutConstraint(item: vipimg,
                                                  attribute: .centerY,
                                                  relatedBy: .equal,
                                                  toItem: headview,
                                                  attribute: .centerY,
                                                  multiplier: 1.0,
                                                  constant: 0))
        headview.addConstraint(NSLayoutConstraint(item: vipimg,
                                                  attribute: .left,
                                                  relatedBy: .equal,
                                                  toItem: nickname,
                                                  attribute: .right,
                                                  multiplier: 1.0,
                                                  constant: 6))
        
        
    }
    
}
