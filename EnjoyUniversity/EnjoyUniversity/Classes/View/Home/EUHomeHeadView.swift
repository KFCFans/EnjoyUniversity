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
        let activitytitle = UILabel()
        activitytitle.text = "活动"
        activitytitle.font = UIFont.boldSystemFont(ofSize: 16)
        activitytitle.sizeToFit()
        activitytitle.textColor = UIColor.white
        activityView.addSubview(activitytitle)
        
        let activitydetail = UILabel()
        activitydetail.text = "活出精彩"
        activitydetail.font = UIFont.boldSystemFont(ofSize: 15)
        activitydetail.sizeToFit()
        activitydetail.textColor = UIColor.white
        activityView.addSubview(activitydetail)
        
        let activityimage = UIImageView(image: #imageLiteral(resourceName: "home_activity"))
        activityView.addSubview(activityimage)
        
        setupAutoLayout(title: activitytitle, detail: activitydetail, image: activityimage, superview: activityView)
    }
    
    fileprivate func setupCommunityView(){
        
        
        
    }
    
    fileprivate func setupAutoLayout(title:UILabel,detail:UILabel,image:UIImageView,superview:UIView){
        
        
        // 自动布局
        detail.translatesAutoresizingMaskIntoConstraints = false
        title.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        
        superview.addConstraint(NSLayoutConstraint(item: title,
                                                      attribute: .top,
                                                      relatedBy: .equal,
                                                      toItem: superview,
                                                      attribute: .top,
                                                      multiplier: 1.0,
                                                      constant: 6))
        
        superview.addConstraint(NSLayoutConstraint(item: title,
                                                      attribute: .left,
                                                      relatedBy: .equal,
                                                      toItem: superview,
                                                      attribute: .left,
                                                      multiplier: 1.0,
                                                      constant: 17))
        
        superview.addConstraint(NSLayoutConstraint(item: detail,
                                                      attribute: .top,
                                                      relatedBy: .equal,
                                                      toItem: title,
                                                      attribute: .bottom,
                                                      multiplier: 1.0,
                                                      constant: 4))
        
        superview.addConstraint(NSLayoutConstraint(item: detail,
                                                      attribute: .left,
                                                      relatedBy: .equal,
                                                      toItem: title,
                                                      attribute: .left,
                                                      multiplier: 1.0,
                                                      constant: 0))
        
        image.addConstraint(NSLayoutConstraint(item: image,
                                               attribute: .width,
                                               relatedBy: .equal,
                                               toItem: nil,
                                               attribute: .notAnAttribute,
                                               multiplier: 1.0,
                                               constant: 30))
        
        image.addConstraint(NSLayoutConstraint(item: image,
                                               attribute: .height,
                                               relatedBy: .equal,
                                               toItem: nil,
                                               attribute: .notAnAttribute,
                                               multiplier: 1.0,
                                               constant: 30))
        
        superview.addConstraint(NSLayoutConstraint(item: image,
                                                      attribute: .right,
                                                      relatedBy: .equal,
                                                      toItem: superview,
                                                      attribute: .right,
                                                      multiplier: 1.0,
                                                      constant: -18))
        
        superview.addConstraint(NSLayoutConstraint(item: image,
                                                      attribute: .centerY,
                                                      relatedBy: .equal,
                                                      toItem: superview,
                                                      attribute: .centerY,
                                                      multiplier: 1.0,
                                                      constant: 0))
        
        
        
    }
    
}
