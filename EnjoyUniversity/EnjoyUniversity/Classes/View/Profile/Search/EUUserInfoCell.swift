//
//  EUUserInfoCell.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/24.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUUserInfoCell: UITableViewCell {

    /// 头像
    let logoImageView = UIImageView()
    
    /// 姓名
    let nameLabel = UILabel()
    
    /// 班级
    let classLabel = UILabel()
    
    /// 性别
    let sexImageView = UIImageView()
    
    var viewmodel:UserinfoViewModel?{
        
        didSet{
            nameLabel.text = viewmodel?.model?.name
            classLabel.text = viewmodel?.model?.professionclass
            nameLabel.sizeToFit()
            sexImageView.frame.origin = CGPoint(x: nameLabel.frame.maxX + 7, y: 24)
            switch viewmodel?.model?.gender ?? 3{
            case 0:
                sexImageView.image = UIImage(named: "user_man")
                break
            case 1:
                sexImageView.image = UIImage(named: "user_woman")
                break
            case 3:
                sexImageView.image = UIImage(named: "user_secret")
                break
            default:
                break
            }
            logoImageView.kf.setImage(with: URL(string: viewmodel?.headsculptureurl ?? ""),
                                      placeholder: UIImage(named: "profile_templogo"),
                                      options: [.transition(.fade(1))],
                                      progressBlock: nil) { (image, _, _, _) in
                                        self.logoImageView.image = avatarImage(image: image, size: CGSize(width: 50, height: 50), opaque: true, backColor: UIColor.white)
            }
            
        }
        
    }

    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        logoImageView.frame = CGRect(x: 12, y: 15, width: 50, height: 50)
        addSubview(logoImageView)
        
        nameLabel.frame = CGRect(x: 75, y: 22.5, width: 50, height: 18)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        nameLabel.sizeToFit()
        nameLabel.textColor = TEXTVIEWCOLOR
        addSubview(nameLabel)
        
        sexImageView.frame = CGRect(x: 172, y: 24, width: 15, height: 15)
        sexImageView.center.y = nameLabel.center.y
        addSubview(sexImageView)
        
        classLabel.frame = CGRect(x: 75, y: 46, width: UIScreen.main.bounds.width - 100, height: 12)
        classLabel.font = UIFont.boldSystemFont(ofSize: 12)
        classLabel.textColor = UIColor.init(red: 158/255, green: 158/255, blue: 158/255, alpha: 1)
        addSubview(classLabel)
        
    }

}
