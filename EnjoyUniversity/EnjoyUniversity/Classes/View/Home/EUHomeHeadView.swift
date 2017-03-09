//
//  EUHomeHeadView.swift
//  EnjoyUniversity
//
//  Created by lip on 17/3/6.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUHomeHeadView: UIView {
    
    var activityView:UIButton
    
    var communityView:UIButton

    // 用于跳转
    var navigationController:UINavigationController?

    override init(frame: CGRect) {
        

        activityView = UIButton(frame: CGRect(x: 10, y: 0, width: frame.size.width / 2 - 15, height: frame.size.height))
        activityView.backgroundColor = #colorLiteral(red: 0.00265219924, green: 0.7488125563, blue: 0.7883973718, alpha: 1)

        communityView = UIButton(frame: CGRect(x: frame.size.width / 2 + 5, y: 0, width: frame.size.width / 2 - 15, height: frame.size.height))
        communityView.backgroundColor = #colorLiteral(red: 0.4545698166, green: 0.699503541, blue: 0.2102472186, alpha: 1)
        super.init(frame: frame)
        
        activityView.addTarget(nil, action: #selector(didClickMyActivity), for: .touchUpInside)
        communityView.addTarget(nil, action: #selector(didClickMyCommunity), for: .touchUpInside)
        
        addSubview(activityView)
        addSubview(communityView)
        
        setupMiniHeadView(title: "活动", detail: "活出精彩", image: #imageLiteral(resourceName: "home_activity"), superview: activityView)
        
        setupMiniHeadView(title: "社团", detail: "释放热情", image: #imageLiteral(resourceName: "home_organization"), superview: communityView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func giveNavigationController(navc:UINavigationController?){
        navigationController = navc
    }
    
}

// MARK: - UI 相关方法
extension EUHomeHeadView{
    

    
    fileprivate func setupMiniHeadView(title:String,detail:String,image:UIImage,superview:UIView){
        
        let titlelabel = UILabel()
        titlelabel.text = title
        titlelabel.font = UIFont.boldSystemFont(ofSize: 16)
        titlelabel.sizeToFit()
        titlelabel.textColor = UIColor.white
        superview.addSubview(titlelabel)
        
        let detaillabel = UILabel()
        detaillabel.text = detail
        detaillabel.font = UIFont.boldSystemFont(ofSize: 15)
        detaillabel.sizeToFit()
        detaillabel.textColor = UIColor.white
        superview.addSubview(detaillabel)
        
        let imageview = UIImageView(image: image)
        superview.addSubview(imageview)
        
        // 自动布局
        detaillabel.translatesAutoresizingMaskIntoConstraints = false
        titlelabel.translatesAutoresizingMaskIntoConstraints = false
        imageview.translatesAutoresizingMaskIntoConstraints = false
        
        superview.addConstraint(NSLayoutConstraint(item: titlelabel,
                                                      attribute: .top,
                                                      relatedBy: .equal,
                                                      toItem: superview,
                                                      attribute: .top,
                                                      multiplier: 1.0,
                                                      constant: 6))
        
        superview.addConstraint(NSLayoutConstraint(item: titlelabel,
                                                      attribute: .left,
                                                      relatedBy: .equal,
                                                      toItem: superview,
                                                      attribute: .left,
                                                      multiplier: 1.0,
                                                      constant: 17))
        
        superview.addConstraint(NSLayoutConstraint(item: detaillabel,
                                                      attribute: .top,
                                                      relatedBy: .equal,
                                                      toItem: titlelabel,
                                                      attribute: .bottom,
                                                      multiplier: 1.0,
                                                      constant: 4))
        
        superview.addConstraint(NSLayoutConstraint(item: detaillabel,
                                                      attribute: .left,
                                                      relatedBy: .equal,
                                                      toItem: titlelabel,
                                                      attribute: .left,
                                                      multiplier: 1.0,
                                                      constant: 0))
        
        imageview.addConstraint(NSLayoutConstraint(item: imageview,
                                               attribute: .width,
                                               relatedBy: .equal,
                                               toItem: nil,
                                               attribute: .notAnAttribute,
                                               multiplier: 1.0,
                                               constant: 30))
        
        imageview.addConstraint(NSLayoutConstraint(item: imageview,
                                               attribute: .height,
                                               relatedBy: .equal,
                                               toItem: nil,
                                               attribute: .notAnAttribute,
                                               multiplier: 1.0,
                                               constant: 30))
        
        superview.addConstraint(NSLayoutConstraint(item: imageview,
                                                      attribute: .right,
                                                      relatedBy: .equal,
                                                      toItem: superview,
                                                      attribute: .right,
                                                      multiplier: 1.0,
                                                      constant: -18))
        
        superview.addConstraint(NSLayoutConstraint(item: imageview,
                                                      attribute: .centerY,
                                                      relatedBy: .equal,
                                                      toItem: superview,
                                                      attribute: .centerY,
                                                      multiplier: 1.0,
                                                      constant: 0))
        
        
        
    }
    
}


// MARK: - 监听方法
extension EUHomeHeadView{
    
    @objc fileprivate func didClickMyActivity(){
        
        navigationController?.pushViewController(EUMyActivityViewController(), animated: true)
        
    }
    
    
    @objc fileprivate func didClickMyCommunity(){
        
        
    }
    
}
