//
//  EUCommunityVerifyCell.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/27.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCommunityVerifyCell: UITableViewCell {
    
    let logoImgView = UIImageView()
    
    let nameLabel = UILabel()
    
    let schoolIdLabel = UILabel()
    
    let phoneLabel = UILabel()
    
    let classLabel = UILabel()
    
    let sexImageView = UIImageView()
    
    /// 数据源
    var viewmodel:UserinfoViewModel?{
        didSet{
            nameLabel.text = viewmodel?.model?.name
            phoneLabel.text = "\(viewmodel?.model?.uid ?? 0)"
            schoolIdLabel.text = "\(viewmodel?.model?.studentid ?? 0)"
            classLabel.text = viewmodel?.model?.professionclass
            nameLabel.sizeToFit()
            sexImageView.frame.origin.x = nameLabel.frame.maxX + 7
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
            logoImgView.kf.setImage(with: URL(string: viewmodel?.headsculptureurl ?? ""),
                                      placeholder: UIImage(named: "profile_templogo"),
                                      options: [.transition(.fade(1))],
                                      progressBlock: nil) { (image, _, _, _) in
                                        if let image = image{
                                            self.logoImgView.image = avatarImage(image: image, size: CGSize(width: 84, height: 84), opaque: true, backColor: UIColor.white)
                                        }
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
        
        logoImgView.frame = CGRect(x: 12, y: 15, width: 84, height: 84)
        addSubview(logoImgView)
        
        nameLabel.frame = CGRect(x: 108, y: 10, width: 100, height: 16)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.text = "用户名"
        nameLabel.sizeToFit()
        nameLabel.textColor = TEXTVIEWCOLOR
        addSubview(nameLabel)
        
        sexImageView.frame = CGRect(x: nameLabel.frame.maxX + 7, y: 10, width: 15, height: 15)
        sexImageView.center.y = nameLabel.center.y
        addSubview(sexImageView)
        
        schoolIdLabel.frame = CGRect(x: 108, y: 36, width: 100, height: 14)
        schoolIdLabel.font = UIFont.boldSystemFont(ofSize: 14)
        schoolIdLabel.textColor = TEXTVIEWCOLOR
        schoolIdLabel.text = "1030414119"
        addSubview(schoolIdLabel)
        
        phoneLabel.frame = CGRect(x: 108, y: 60, width: 120, height: 14)
        phoneLabel.font = UIFont.boldSystemFont(ofSize: 14)
        phoneLabel.textColor = TEXTVIEWCOLOR
        phoneLabel.text = "15061883391"
        addSubview(phoneLabel)
        
        classLabel.frame = CGRect(x: 108, y: 84, width: UIScreen.main.bounds.width - 100, height: 12)
        classLabel.font = UIFont.boldSystemFont(ofSize: 12)
        classLabel.textColor = TEXTVIEWCOLOR
        classLabel.text = "江南大学物联网工程学院计科 1401"
        addSubview(classLabel)
        
    }
    

}
