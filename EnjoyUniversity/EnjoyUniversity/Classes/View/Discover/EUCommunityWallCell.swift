//
//  EUCommunityWallCell.swift
//  EnjoyUniversity
//
//  Created by lip on 17/5/2.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCommunityWallCell: UITableViewCell {

    var communityModel:CommunityViewModel?{
        
        didSet{
            communityName.text = communityModel?.communitymodel?.cmName
            communityIntro.text = communityModel?.communitymodel?.cmDetail
            let logourl = URL(string: communityModel?.communityLogoUrl ?? "")
            let bgiurl = URL(string: communityModel?.communityBackgroundURL ?? "")
            communityIcon.kf.setImage(with: logourl,
                                      placeholder: UIImage(named: "Facebook_25"),
                                      options: [.transition(.fade(1))],
                                      progressBlock: nil,
                                      completionHandler: nil)
            communityBGI.kf.setImage(with: bgiurl,
                                     placeholder: UIImage(named: "wallbackground"),
                                     options: [.transition(.fade(1))],
                                     progressBlock: nil,
                                     completionHandler: nil)
        }
        
    }
    
    /// 社团名称
    var communityName = UILabel()
    
    /// 社团简介
    var communityIntro = UILabel()
    
    /// 社团图标
    var communityIcon = UIImageView()
    
    /// 社团背景图
    var communityBGI = UIImageView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        communityBGI.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width * 0.618)
        addSubview(communityBGI)
        
        communityBGI.addSubview(communityIcon)
        
        communityName.font = UIFont.boldSystemFont(ofSize: 21)
        communityName.textColor = UIColor.white
        communityName.textAlignment = .center
        communityBGI.addSubview(communityName)
        
        communityIntro.font = UIFont.boldSystemFont(ofSize: 13)
        communityIntro.textColor = UIColor.white
        communityIntro.numberOfLines = 0
        communityIntro.textAlignment = .center
        communityBGI.addSubview(communityIntro)
        
        communityIcon.translatesAutoresizingMaskIntoConstraints = false
        communityIntro.translatesAutoresizingMaskIntoConstraints = false
        communityName.translatesAutoresizingMaskIntoConstraints = false
        
        // 社团名称
        communityBGI.addConstraints([NSLayoutConstraint(item: communityName,
                                                        attribute: .left,
                                                        relatedBy: .equal,
                                                        toItem: communityBGI,
                                                        attribute: .left,
                                                        multiplier: 1.0,
                                                        constant: 20),
                                     NSLayoutConstraint(item: communityName,
                                                        attribute: .right,
                                                        relatedBy: .equal,
                                                        toItem: communityBGI,
                                                        attribute: .right,
                                                        multiplier: 1.0,
                                                        constant: -20),
                                     NSLayoutConstraint(item: communityName,
                                                        attribute: .centerY,
                                                        relatedBy: .equal,
                                                        toItem: communityBGI,
                                                        attribute: .centerY,
                                                        multiplier: 1.0,
                                                        constant: 0)])
        communityName.addConstraints([NSLayoutConstraint(item: communityName,
                                                         attribute: .width,
                                                         relatedBy: .equal,
                                                         toItem: nil,
                                                         attribute: .notAnAttribute,
                                                         multiplier: 1.0,
                                                         constant: UIScreen.main.bounds.width),
                                      NSLayoutConstraint(item: communityName,
                                                         attribute: .height,
                                                         relatedBy: .equal,
                                                         toItem: nil,
                                                         attribute: .notAnAttribute,
                                                         multiplier: 1.0,
                                                         constant: 21)])
        
        // Logo
        communityIcon.addConstraints([NSLayoutConstraint(item: communityIcon,
                                                         attribute: .width,
                                                         relatedBy: .equal,
                                                         toItem: nil,
                                                         attribute: .notAnAttribute,
                                                         multiplier: 1.0,
                                                         constant: 80),
                                      NSLayoutConstraint(item: communityIcon,
                                                         attribute: .height,
                                                         relatedBy: .equal,
                                                         toItem: nil,
                                                         attribute: .notAnAttribute,
                                                         multiplier: 1.0,
                                                         constant: 80)])
        communityBGI.addConstraints([NSLayoutConstraint(item: communityIcon,
                                                        attribute: .bottom,
                                                        relatedBy: .equal,
                                                        toItem: communityName,
                                                        attribute: .top,
                                                        multiplier: 1.0,
                                                        constant: -8),
                                     NSLayoutConstraint(item: communityIcon,
                                                        attribute: .centerX,
                                                        relatedBy: .equal,
                                                        toItem: communityBGI,
                                                        attribute: .centerX,
                                                        multiplier: 1.0,
                                                        constant: 0)])
        
        // 详情
        communityBGI.addConstraints([NSLayoutConstraint(item: communityIntro,
                                                        attribute: .left,
                                                        relatedBy: .equal,
                                                        toItem: communityBGI,
                                                        attribute: .left,
                                                        multiplier: 1.0,
                                                        constant: 20),
                                     NSLayoutConstraint(item: communityIntro,
                                                        attribute: .right,
                                                        relatedBy: .equal,
                                                        toItem: communityBGI,
                                                        attribute: .right,
                                                        multiplier: 1.0,
                                                        constant: -20),
                                     NSLayoutConstraint(item: communityIntro,
                                                        attribute: .top,
                                                        relatedBy: .equal,
                                                        toItem: communityName,
                                                        attribute: .bottom,
                                                        multiplier: 1.0,
                                                        constant: 20),
                                     NSLayoutConstraint(item: communityIntro,
                                                        attribute: .bottom,
                                                        relatedBy: .lessThanOrEqual,
                                                        toItem: communityBGI,
                                                        attribute: .bottom,
                                                        multiplier: 1.0,
                                                        constant: -10)])
        
    }

}
