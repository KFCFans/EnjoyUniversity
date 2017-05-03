//
//  EUMessageDetailCell.swift
//  EnjoyUniversity
//
//  Created by lip on 17/5/3.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUMessageDetailCell: UITableViewCell {
    
    /// 通知标题
    let notificationTitileLabel = UILabel()
    
    /// 通知时间
    let timeLabel = UILabel()
    
    /// 通知内容遮挡视图
    let detailShadowView = UIView()
    
    /// 通知内容
    let notificationDetailLabel = UILabel()
    
    /// 通知头像
    let notificationLogo = UIImageView()
    
    /// 选择用于什么通知
    var choice:Int = 0{
        didSet{
            notificationLogo.image = UIImage(named: notificationLogoAraay[choice])
        }
    }
    
    let notificationLogoAraay = ["notification_avcell","notification_cmcell","notification_syscell"]
    
    let sWidth = UIScreen.main.bounds.width

    var viewmodel:MessageViewModel?{
        didSet{
            timeLabel.text = viewmodel?.sendTime
            notificationDetailLabel.text = viewmodel?.model?.msg
            notificationTitileLabel.text = viewmodel?.model?.sender
            detailShadowView.frame.size = CGSize(width: detailShadowView.frame.width, height: 20 + (viewmodel?.messageHeight ?? 0))
            notificationDetailLabel.frame.size = CGSize(width: detailShadowView.frame.width - 20, height: viewmodel?.messageHeight ?? 0)
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
        
        backgroundColor = BACKGROUNDCOLOR
        
        let timeshadowView = UIView(frame: CGRect(x: (sWidth - 130)/2, y: 4, width: 130, height: 22))
        timeshadowView.backgroundColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
        timeshadowView.layer.masksToBounds = true
        timeshadowView.layer.cornerRadius = 11
        addSubview(timeshadowView)
        
        timeLabel.frame = CGRect(x: 0, y: 5, width: timeshadowView.frame.width, height: 12)
        timeLabel.font = UIFont.boldSystemFont(ofSize: 12)
        timeLabel.textAlignment = .center
        timeLabel.textColor = UIColor.white
        timeshadowView.addSubview(timeLabel)
        
        notificationLogo.frame = CGRect(x: 10, y: 32, width: 42, height: 42)
        addSubview(notificationLogo)
        
        let topshadowView = UIView(frame: CGRect(x: 58, y: 33, width: sWidth - 58 - 25, height: 36))
        topshadowView.backgroundColor = UIColor.init(red: 1, green: 212/255, blue: 48/255, alpha: 1)
        addSubview(topshadowView)
        
        notificationTitileLabel.frame = CGRect(x: 12, y: 10, width: topshadowView.frame.width - 24, height: 17)
        notificationTitileLabel.textColor = UIColor.white
        notificationTitileLabel.font = UIFont.boldSystemFont(ofSize: 16)
        topshadowView.addSubview(notificationTitileLabel)
        
        detailShadowView.frame = CGRect(x: 58, y: 69, width: topshadowView.frame.width, height: 20 + (viewmodel?.messageHeight ?? 0))
        detailShadowView.backgroundColor = UIColor.white
        addSubview(detailShadowView)
        
        notificationDetailLabel.frame = CGRect(x: 10, y: 10, width: detailShadowView.frame.width - 20, height: 14)
        notificationDetailLabel.font = UIFont.boldSystemFont(ofSize: 14)
        notificationDetailLabel.numberOfLines = 0
        notificationDetailLabel.textColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
        detailShadowView.addSubview(notificationDetailLabel)
        
        
        
    }

}
