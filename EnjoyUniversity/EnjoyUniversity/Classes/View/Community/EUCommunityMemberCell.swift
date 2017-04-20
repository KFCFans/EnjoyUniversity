//
//  EUCommunityMemberCell.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/19.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCommunityMemberCell: UITableViewCell {
    
    /// 姓名标签
    let nameLabel = UILabel()
    
    /// 职务标签
    let positionLabel = UILabel()
    
    /// 头像
    let logoImageView = UIImageView()
    
    /// 视图模型
    var viewmodel:UserinfoViewModel?{
        didSet{
            nameLabel.text = viewmodel?.model?.name
            
        }
    }

    
    init(){
        super.init(style: .default, reuseIdentifier: nil)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI 相关方法
extension EUCommunityMemberCell{
    
    fileprivate func setupUI(){
        
        addSubview(logoImageView)
        
        nameLabel.textColor = UIColor.black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        addSubview(nameLabel)
        
        positionLabel.text = "主席"
        positionLabel.textColor = UIColor.init(red: 146/255, green: 146/255, blue: 146/255, alpha: 1)
        positionLabel.font = UIFont.boldSystemFont(ofSize: 13)
        addSubview(positionLabel)
        
        let phoneBtn = UIButton()
        phoneBtn.setImage(UIImage(named: "cm_phone"), for: .normal)
        addSubview(phoneBtn)
        
        let smsBtn = UIButton()
        smsBtn.setImage(UIImage(named: "cm_sms"), for: .normal)
        addSubview(smsBtn)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        positionLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneBtn.translatesAutoresizingMaskIntoConstraints = false
        smsBtn.translatesAutoresizingMaskIntoConstraints = false
        
        // 头像
        logoImageView.addConstraints([NSLayoutConstraint(item: logoImageView,
                                                         attribute: .width,
                                                         relatedBy: .equal,
                                                         toItem: nil,
                                                         attribute: .notAnAttribute,
                                                         multiplier: 1.0,
                                                         constant: 50),
                                      NSLayoutConstraint(item: logoImageView,
                                                         attribute: .height,
                                                         relatedBy: .equal,
                                                         toItem: nil,
                                                         attribute: .notAnAttribute,
                                                         multiplier: 1.0,
                                                         constant: 50)])
        addConstraints([NSLayoutConstraint(item: logoImageView,
                                           attribute: .centerY,
                                           relatedBy: .equal,
                                           toItem: self,
                                           attribute: .centerY,
                                           multiplier: 1.0,
                                           constant: 0),
                        NSLayoutConstraint(item: logoImageView,
                                           attribute: .left,
                                           relatedBy: .equal,
                                           toItem: self,
                                           attribute: .left,
                                           multiplier: 1.0,
                                           constant: 8)])
        
        // 姓名
        nameLabel.addConstraints([NSLayoutConstraint(item: nameLabel,
                                                         attribute: .width,
                                                         relatedBy: .equal,
                                                         toItem: nil,
                                                         attribute: .notAnAttribute,
                                                         multiplier: 1.0,
                                                         constant: 200),
                                      NSLayoutConstraint(item: nameLabel,
                                                         attribute: .height,
                                                         relatedBy: .equal,
                                                         toItem: nil,
                                                         attribute: .notAnAttribute,
                                                         multiplier: 1.0,
                                                         constant: 16)])
        addConstraints([NSLayoutConstraint(item: nameLabel,
                                           attribute: .bottom,
                                           relatedBy: .equal,
                                           toItem: self,
                                           attribute: .centerY,
                                           multiplier: 1.0,
                                           constant: -5),
                        NSLayoutConstraint(item: nameLabel,
                                           attribute: .left,
                                           relatedBy: .equal,
                                           toItem: logoImageView,
                                           attribute: .right,
                                           multiplier: 1.0,
                                           constant: 8)])
        
        // 职务
        positionLabel.addConstraints([NSLayoutConstraint(item: positionLabel,
                                                     attribute: .width,
                                                     relatedBy: .equal,
                                                     toItem: nil,
                                                     attribute: .notAnAttribute,
                                                     multiplier: 1.0,
                                                     constant: 200),
                                  NSLayoutConstraint(item: positionLabel,
                                                     attribute: .height,
                                                     relatedBy: .equal,
                                                     toItem: nil,
                                                     attribute: .notAnAttribute,
                                                     multiplier: 1.0,
                                                     constant: 13)])
        addConstraints([NSLayoutConstraint(item: positionLabel,
                                           attribute: .top,
                                           relatedBy: .equal,
                                           toItem: self,
                                           attribute: .centerY,
                                           multiplier: 1.0,
                                           constant: 5),
                        NSLayoutConstraint(item: positionLabel,
                                           attribute: .left,
                                           relatedBy: .equal,
                                           toItem: logoImageView,
                                           attribute: .right,
                                           multiplier: 1.0,
                                           constant: 8)])
        
        // 电话
        phoneBtn.addConstraints([NSLayoutConstraint(item: phoneBtn,
                                                         attribute: .width,
                                                         relatedBy: .equal,
                                                         toItem: nil,
                                                         attribute: .notAnAttribute,
                                                         multiplier: 1.0,
                                                         constant: 25),
                                      NSLayoutConstraint(item: phoneBtn,
                                                         attribute: .height,
                                                         relatedBy: .equal,
                                                         toItem: nil,
                                                         attribute: .notAnAttribute,
                                                         multiplier: 1.0,
                                                         constant: 25)])
        addConstraints([NSLayoutConstraint(item: phoneBtn,
                                           attribute: .centerY,
                                           relatedBy: .equal,
                                           toItem: self,
                                           attribute: .centerY,
                                           multiplier: 1.0,
                                           constant: 0),
                        NSLayoutConstraint(item: phoneBtn,
                                           attribute: .right,
                                           relatedBy: .equal,
                                           toItem: self,
                                           attribute: .right,
                                           multiplier: 1.0,
                                           constant: -60)])
        // 短信
        smsBtn.addConstraints([NSLayoutConstraint(item: smsBtn,
                                                    attribute: .width,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1.0,
                                                    constant: 25),
                                 NSLayoutConstraint(item: smsBtn,
                                                    attribute: .height,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1.0,
                                                    constant: 25)])
        addConstraints([NSLayoutConstraint(item: smsBtn,
                                           attribute: .centerY,
                                           relatedBy: .equal,
                                           toItem: self,
                                           attribute: .centerY,
                                           multiplier: 1.0,
                                           constant: 0),
                        NSLayoutConstraint(item: smsBtn,
                                           attribute: .right,
                                           relatedBy: .equal,
                                           toItem: self,
                                           attribute: .right,
                                           multiplier: 1.0,
                                           constant: -15)])
    }
    
}
