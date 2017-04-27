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
        
        nameLabel.frame = CGRect(x: 108, y: 15, width: 100, height: 18)
        nameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        nameLabel.text = "用户名"
        nameLabel.sizeToFit()
        nameLabel.textColor = TEXTVIEWCOLOR
        addSubview(nameLabel)
        
        sexImageView.frame = CGRect(x: nameLabel.frame.maxX + 7, y: 15, width: 15, height: 15)
        addSubview(sexImageView)
        
        schoolIdLabel.frame = CGRect(x: 108, y: 43, width: 100, height: 14)
        schoolIdLabel.font = UIFont.boldSystemFont(ofSize: 14)
        schoolIdLabel.textColor = TEXTVIEWCOLOR
        schoolIdLabel.text = "1030414119"
        addSubview(schoolIdLabel)
        
        phoneLabel.frame = CGRect(x: 108, y: 67, width: 120, height: 14)
        phoneLabel.font = UIFont.boldSystemFont(ofSize: 14)
        phoneLabel.textColor = TEXTVIEWCOLOR
        phoneLabel.text = "15061883391"
        addSubview(phoneLabel)
        
        classLabel.frame = CGRect(x: 108, y: 91, width: UIScreen.main.bounds.width - 100, height: 12)
        classLabel.font = UIFont.boldSystemFont(ofSize: 12)
        classLabel.textColor = TEXTVIEWCOLOR
        classLabel.text = "江南大学物联网工程学院计科 1401"
        addSubview(classLabel)
        
    }
    

}
