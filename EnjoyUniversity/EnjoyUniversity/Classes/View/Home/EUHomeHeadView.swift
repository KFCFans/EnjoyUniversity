//
//  EUHomeHeadView.swift
//  EnjoyUniversity
//
//  Created by lip on 17/3/6.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUHomeHeadView: UIView {
    
    var activityView:UIView
    
    var communityView:UIView


    override init(frame: CGRect) {
        
//        activityView = UIImageView(image: #imageLiteral(resourceName: "home_background3"))
//        activityView.frame = CGRect(x: 6, y: 6, width: frame.size.width / 2 - 7.5, height: frame.size.height)
        activityView = UIView(frame: CGRect(x: 10, y: 0, width: frame.size.width / 2 - 15, height: frame.size.height))
        activityView.backgroundColor = #colorLiteral(red: 0.00265219924, green: 0.7488125563, blue: 0.7883973718, alpha: 1)
//        communityView = UIImageView(image: #imageLiteral(resourceName: "home_background2"))
//        communityView.frame = CGRect(x: frame.size.width / 2 + 1.5, y: 6, width: frame.size.width / 2 - 7.5, height: frame.size.height)
        communityView = UIView(frame: CGRect(x: frame.size.width / 2 + 5, y: 0, width: frame.size.width / 2 - 15, height: frame.size.height))
        communityView.backgroundColor = #colorLiteral(red: 0.4545698166, green: 0.699503541, blue: 0.2102472186, alpha: 1)
        super.init(frame: frame)
        
        addSubview(activityView)
        addSubview(communityView)
        
        setupActivityView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI 相关方法
extension EUHomeHeadView{
    
    fileprivate func setupActivityView(){
        
        
        
//        let avimgview = UIImageView(image: #imageLiteral(resourceName: "home_activity"))
//        activityView.addSubview(avimgview)
        
        let avtitle = UILabel()
        avtitle.text = "活动"
        avtitle.font = UIFont.boldSystemFont(ofSize: 16)
        avtitle.sizeToFit()
        avtitle.textColor = UIColor.white
        activityView.addSubview(avtitle)
        
        let avdetail = UILabel()
        avdetail.text = "活出精彩"
        avdetail.font = UIFont.boldSystemFont(ofSize: 15)
        avdetail.sizeToFit()
        avdetail.textColor = UIColor.white
        activityView.addSubview(avdetail)
        
        let avimg = UIImageView(image: #imageLiteral(resourceName: "home_activity"))
        activityView.addSubview(avimg)
        
        // 自动布局
        avdetail.translatesAutoresizingMaskIntoConstraints = false
        avtitle.translatesAutoresizingMaskIntoConstraints = false
        avimg.translatesAutoresizingMaskIntoConstraints = false
        
        activityView.addConstraint(NSLayoutConstraint(item: avtitle,
                                                      attribute: .top,
                                                      relatedBy: .equal,
                                                      toItem: activityView,
                                                      attribute: .top,
                                                      multiplier: 1.0,
                                                      constant: 6))
        
        activityView.addConstraint(NSLayoutConstraint(item: avtitle,
                                                      attribute: .left,
                                                      relatedBy: .equal,
                                                      toItem: activityView,
                                                      attribute: .left,
                                                      multiplier: 1.0,
                                                      constant: 17))
        
        activityView.addConstraint(NSLayoutConstraint(item: avdetail,
                                                      attribute: .top,
                                                      relatedBy: .equal,
                                                      toItem: avtitle,
                                                      attribute: .bottom,
                                                      multiplier: 1.0,
                                                      constant: 4))
        
        activityView.addConstraint(NSLayoutConstraint(item: avdetail,
                                                      attribute: .left,
                                                      relatedBy: .equal,
                                                      toItem: avtitle,
                                                      attribute: .left,
                                                      multiplier: 1.0,
                                                      constant: 0))
        
        avimg.addConstraint(NSLayoutConstraint(item: avimg,
                                               attribute: .width,
                                               relatedBy: .equal,
                                               toItem: nil,
                                               attribute: .notAnAttribute,
                                               multiplier: 1.0,
                                               constant: 30))
        
        avimg.addConstraint(NSLayoutConstraint(item: avimg,
                                               attribute: .height,
                                               relatedBy: .equal,
                                               toItem: nil,
                                               attribute: .notAnAttribute,
                                               multiplier: 1.0,
                                               constant: 30))
        
        activityView.addConstraint(NSLayoutConstraint(item: avimg,
                                                      attribute: .right,
                                                      relatedBy: .equal,
                                                      toItem: activityView,
                                                      attribute: .right,
                                                      multiplier: 1.0,
                                                      constant: -18))
        
        activityView.addConstraint(NSLayoutConstraint(item: avimg,
                                                      attribute: .centerY,
                                                      relatedBy: .equal,
                                                      toItem: activityView,
                                                      attribute: .centerY,
                                                      multiplier: 1.0,
                                                      constant: 0))
        
        
        
    }
    
}
