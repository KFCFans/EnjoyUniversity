//
//  EUCommunityMemberCell.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/21.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCommunityMemberCell: UITableViewCell {

    /// 姓名标签
    let nameLabel = UILabel()
    
    /// 班级标签
    let classLabel = UILabel()
    
    /// 学号标签
    let schoolnumLabel = UILabel()
    
    /// 头像
    let logoImageView = UIImageView()
    
    /// 视图模型
    var viewmodel:UserinfoViewModel?{
        didSet{
            nameLabel.text = viewmodel?.model?.name
            classLabel.text = viewmodel?.model?.professionclass
            schoolnumLabel.text = "\(viewmodel?.model?.studentid ?? 0)"
            logoImageView.kf.setImage(with: URL(string: viewmodel?.headsculptureurl ?? ""),
                                      placeholder: UIImage(named: "av_leader"),
                                      options: [.transition(.fade(1))],
                                      progressBlock: nil,
                                      completionHandler: { (image, _, _, _) in
                                        guard let image = image else {
                                            return
                                        }
                                        self.logoImageView.image = avatarImage(image: image, size: CGSize(width: 50, height: 50), opaque: false, backColor: nil)
            })
        }
    }
    
    
    init(){
        super.init(style: .default, reuseIdentifier: nil)
        setupUI()
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        addSubview(nameLabel)
        
        schoolnumLabel.textColor = UIColor.black
        schoolnumLabel.font = UIFont.boldSystemFont(ofSize: 15)
        schoolnumLabel.sizeToFit()
        addSubview(schoolnumLabel)
        
        classLabel.text = "物联网工程学院计科 1401"
        classLabel.textColor = UIColor.init(red: 146/255, green: 146/255, blue: 146/255, alpha: 1)
        classLabel.font = UIFont.boldSystemFont(ofSize: 13)
        addSubview(classLabel)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        classLabel.translatesAutoresizingMaskIntoConstraints = false
        schoolnumLabel.translatesAutoresizingMaskIntoConstraints = false
        
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
                                                     attribute: .height,
                                                     relatedBy: .equal,
                                                     toItem: nil,
                                                     attribute: .notAnAttribute,
                                                     multiplier: 1.0,
                                                     constant: 15)])
        addConstraints([NSLayoutConstraint(item: nameLabel,
                                           attribute: .top,
                                           relatedBy: .equal,
                                           toItem: self,
                                           attribute: .top,
                                           multiplier: 1.0,
                                           constant: 12),
                        NSLayoutConstraint(item: nameLabel,
                                           attribute: .left,
                                           relatedBy: .equal,
                                           toItem: logoImageView,
                                           attribute: .right,
                                           multiplier: 1.0,
                                           constant: 16)])
        
        // 学号
        schoolnumLabel.addConstraints([NSLayoutConstraint(item: schoolnumLabel,
                                                     attribute: .width,
                                                     relatedBy: .equal,
                                                     toItem: nil,
                                                     attribute: .notAnAttribute,
                                                     multiplier: 1.0,
                                                     constant: 200),
                                  NSLayoutConstraint(item: schoolnumLabel,
                                                     attribute: .height,
                                                     relatedBy: .equal,
                                                     toItem: nil,
                                                     attribute: .notAnAttribute,
                                                     multiplier: 1.0,
                                                     constant: 15)])
        addConstraints([NSLayoutConstraint(item: schoolnumLabel,
                                         attribute: .centerY,
                                         relatedBy: .equal,
                                         toItem: nameLabel,
                                         attribute: .centerY,
                                         multiplier: 1.0,
                                         constant: 0),
                        NSLayoutConstraint(item: schoolnumLabel,
                                           attribute: .left,
                                           relatedBy: .equal,
                                           toItem: nameLabel,
                                           attribute: .right,
                                           multiplier: 1.0,
                                           constant: 12)])
        // 班级
        classLabel.addConstraints([NSLayoutConstraint(item: classLabel,
                                                         attribute: .width,
                                                         relatedBy: .equal,
                                                         toItem: nil,
                                                         attribute: .notAnAttribute,
                                                         multiplier: 1.0,
                                                         constant: 200),
                                      NSLayoutConstraint(item: classLabel,
                                                         attribute: .height,
                                                         relatedBy: .equal,
                                                         toItem: nil,
                                                         attribute: .notAnAttribute,
                                                         multiplier: 1.0,
                                                         constant: 13)])
        addConstraints([NSLayoutConstraint(item: classLabel,
                                           attribute: .bottom,
                                           relatedBy: .equal,
                                           toItem: self,
                                           attribute: .bottom,
                                           multiplier: 1.0,
                                           constant: -12),
                        NSLayoutConstraint(item: classLabel,
                                           attribute: .left,
                                           relatedBy: .equal,
                                           toItem: logoImageView,
                                           attribute: .right,
                                           multiplier: 1.0,
                                           constant: 16)])
        
    }

}
