//
//  EUMessageDetailCell.swift
//  EnjoyUniversity
//
//  Created by lip on 17/5/3.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUMessageDetailCell: UITableViewCell {
    
    let notificationLabel = UILabel()
    let timeLabel = UILabel()

    var viewmodel:MessageViewModel?{
        didSet{
            notificationLabel.frame = CGRect(x: 12, y: 12, width: UIScreen.main.bounds.width - 24, height: viewmodel?.messageHeight ?? 0)
            notificationLabel.text = viewmodel?.model?.msg
            timeLabel.frame.origin.y = 24 + (viewmodel?.messageHeight ?? 0)
            timeLabel.text = viewmodel?.sendTime
            timeLabel.sizeToFit()
            timeLabel.center.x = center.x
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
        
        notificationLabel.font = UIFont.boldSystemFont(ofSize: 15)
        timeLabel.font = UIFont.boldSystemFont(ofSize: 13)
        
        addSubview(notificationLabel)
        addSubview(timeLabel)
        
    }

}
