//
//  EUCommunityCollectionCellTableViewCell.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/23.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCommunityCollectionCell: UITableViewCell {


    let logoImageView = UIImageView()
    
    let titleLabel = UILabel()
    
    let detailLabel = UILabel()
    
    /// 视图模型数据
    var viewmodel:CommunityViewModel?{
        didSet{
            titleLabel.text = viewmodel?.communitymodel?.cmName
            detailLabel.text = viewmodel?.communitymodel?.cmDetail
            logoImageView.kf.setImage(with: URL(string: viewmodel?.communityLogoUrl ?? ""),
                                     placeholder: UIImage(named: "eu_placeholder"),
                                     options: [.transition(.fade(1))],
                                     progressBlock: nil,
                                     completionHandler: nil)
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
        
        logoImageView.frame = CGRect(x: 20, y: 12, width: 76, height: 76)
        addSubview(logoImageView)
        
        titleLabel.frame = CGRect(x: 110, y: 25, width: UIScreen.main.bounds.width - 110, height: 16)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = UIColor.init(red: 16/255, green: 16/255, blue: 16/255, alpha: 1)
        addSubview(titleLabel)
        
        detailLabel.frame = CGRect(x: 110, y: 50, width: UIScreen.main.bounds.width - 110 - 20, height: 32)
        detailLabel.numberOfLines = 2
        detailLabel.font = UIFont.boldSystemFont(ofSize: 12)
        detailLabel.textColor = UIColor.init(red: 80/255, green: 80/255, blue: 80/255, alpha: 1)
        addSubview(detailLabel)
        
        
    }

}
