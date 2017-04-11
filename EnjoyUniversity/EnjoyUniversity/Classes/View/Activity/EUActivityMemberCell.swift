//
//  EUActivityMemberCell.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/11.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit
import Kingfisher

class EUActivityMemberCell: UITableViewCell {
    
    /// 头像
    var logoImgView:UIImageView?
    
    /// 姓名
    var nameLabel:UILabel?
    
    /// 节操值
    var reputationLabel:UILabel?
    
    /// 认证图标
    var verifyImgView:UIImageView?
    
    /// 手机号
    var phoneLabel:UILabel?
    
    /// 数据源
    var userinfo:UserinfoViewModel?{
        
        didSet{
            nameLabel?.text = userinfo?.model?.name ?? "加载失败"
            reputationLabel?.text = userinfo?.reputationString
            phoneLabel?.text = "\(userinfo?.model?.uid ?? 10086)"
            verifyImgView?.image = userinfo?.verifyImg
            let url = URL(string: userinfo?.headsculptureurl ?? "")
            logoImgView?.kf.setImage(with: url,
                                     placeholder: UIImage(named: "av_leader"),
                                     options: [.transition(.fade(1))],
                                     progressBlock: nil,
                                     completionHandler: { (image, _, _, _) in
                                        guard let image = image else {
                                            return
                                        }
                                        self.logoImgView?.image = avatarImage(image: image, size: CGSize(width: 50, height: 50), opaque: false, backColor: nil)
            })
            
        
            
        }
        
    }
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: nil)
        logoImgView = UIImageView()
        nameLabel = UILabel()
        reputationLabel = UILabel()
        verifyImgView = UIImageView()
        phoneLabel = UILabel()
        
        
        nameLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        nameLabel?.textColor = UIColor.init(red: 112/255, green: 112/255, blue: 112/255, alpha: 1)
        nameLabel?.sizeToFit()
        
        reputationLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        reputationLabel?.textColor = UIColor.init(red: 143/255, green: 143/255, blue: 148/255, alpha: 1)
        reputationLabel?.sizeToFit()
        
        phoneLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        phoneLabel?.textColor = UIColor.lightGray
        sizeToFit()
        
        addSubview(logoImgView!)
        addSubview(nameLabel!)
        addSubview(reputationLabel!)
        addSubview(phoneLabel!)
        addSubview(verifyImgView!)
        
        accessoryType = .disclosureIndicator
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - UI 相关方法
extension EUActivityMemberCell{
    
    fileprivate func setupUI(){
        
        guard let logoImgView = logoImgView,let verifyImgView = verifyImgView,let phoneLabel = phoneLabel,let nameLabel = nameLabel,let reputationLabel = reputationLabel else {
            return
        }

        logoImgView.translatesAutoresizingMaskIntoConstraints = false
        verifyImgView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        reputationLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        verifyImgView.translatesAutoresizingMaskIntoConstraints = false
        
        // AutoLayout
        // logoImgVieq
        addConstraints([NSLayoutConstraint(item: logoImgView,
                                           attribute: .centerY,
                                           relatedBy: .equal,
                                           toItem: self,
                                           attribute: .centerY,
                                           multiplier: 1.0,
                                           constant: 0),
                        NSLayoutConstraint(item: logoImgView,
                                            attribute: .left,
                                            relatedBy: .equal,
                                            toItem: self,
                                            attribute: .left,
                                            multiplier: 1.0,
                                            constant: 6)])
        logoImgView.addConstraints([NSLayoutConstraint(item: logoImgView,
                                                       attribute: .width,
                                                       relatedBy: .equal,
                                                       toItem: nil,
                                                       attribute: .notAnAttribute,
                                                       multiplier: 1.0,
                                                       constant: 50),
                                    NSLayoutConstraint(item: logoImgView,
                                                       attribute: .height,
                                                       relatedBy: .equal,
                                                       toItem: nil,
                                                       attribute: .notAnAttribute,
                                                       multiplier: 1.0,
                                                       constant: 50)])
        // NameLabel
        addConstraints([NSLayoutConstraint(item: nameLabel,
                                           attribute: .centerY,
                                           relatedBy: .equal,
                                           toItem: logoImgView,
                                           attribute: .centerY,
                                           multiplier: 1.0,
                                           constant: -10),
                        NSLayoutConstraint(item: nameLabel,
                                           attribute: .left,
                                           relatedBy: .equal,
                                           toItem: logoImgView,
                                           attribute: .right,
                                           multiplier: 1.0,
                                           constant: 10)])
        // ReputationLabel
        addConstraints([NSLayoutConstraint(item: reputationLabel,
                                           attribute: .centerY,
                                           relatedBy: .equal,
                                           toItem: logoImgView,
                                           attribute: .centerY,
                                           multiplier: 1.0,
                                           constant: 10),
                        NSLayoutConstraint(item: reputationLabel,
                                           attribute: .left,
                                           relatedBy: .equal,
                                           toItem: logoImgView,
                                           attribute: .right,
                                           multiplier: 1.0,
                                           constant: 10)])
        // PhoneLabel
        addConstraints([NSLayoutConstraint(item: phoneLabel,
                                           attribute: .centerY,
                                           relatedBy: .equal,
                                           toItem: self,
                                           attribute: .centerY,
                                           multiplier: 1.0,
                                           constant: 0),
                        NSLayoutConstraint(item: phoneLabel,
                                           attribute: .right,
                                           relatedBy: .equal,
                                           toItem: self,
                                           attribute: .right,
                                           multiplier: 1.0,
                                           constant: -30)])
        // 认证图标
        addConstraints([NSLayoutConstraint(item: verifyImgView,
                                           attribute: .centerY,
                                           relatedBy: .equal,
                                           toItem: nameLabel,
                                           attribute: .centerY,
                                           multiplier: 1.0,
                                           constant: 0),
                        NSLayoutConstraint(item: verifyImgView,
                                           attribute: .left,
                                           relatedBy: .equal,
                                           toItem: nameLabel,
                                           attribute: .right,
                                           multiplier: 1.0,
                                           constant: 5)])
        addConstraints([ NSLayoutConstraint(item: verifyImgView,
                                            attribute: .height,
                                            relatedBy: .equal,
                                            toItem: nil,
                                            attribute: .notAnAttribute,
                                            multiplier: 1.0,
                                            constant: 15),
                        NSLayoutConstraint(item: verifyImgView,
                                           attribute: .width,
                                           relatedBy: .equal,
                                           toItem: verifyImgView,
                                           attribute: .height,
                                           multiplier: 1.0,
                                           constant: 0)])
        
        
    }
    
}
