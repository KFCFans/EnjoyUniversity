//
//  EUMessageCell.swift
//  EnjoyUniversity
//
//  Created by lip on 17/3/8.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUMessageCell: UITableViewCell {

    var iconimageView = UIImageView()
    
    var titleLabel = UILabel()
    
    var detailLabel = UILabel()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        iconimageView.frame = CGRect(x: 16, y: 7.5, width: 50, height: 50)
        addSubview(iconimageView)
        
        titleLabel.frame = CGRect(x: 77, y: 15, width: 100, height: 15)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.textColor = TEXTVIEWCOLOR
        addSubview(titleLabel)
        
        detailLabel.frame = CGRect(x: 77, y: 40, width: UIScreen.main.bounds.width - 18 - 77, height: 13)
        detailLabel.font = UIFont.boldSystemFont(ofSize: 13)
        detailLabel.lineBreakMode = .byTruncatingTail
        detailLabel.textColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
        addSubview(detailLabel)
    }
    
}
