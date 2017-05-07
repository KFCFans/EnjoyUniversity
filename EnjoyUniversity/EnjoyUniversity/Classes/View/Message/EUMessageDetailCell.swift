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
    
    /// 线
    let lineView = UIView()
    
    /// 查看详情
    let showmoreLabel = UILabel()
    
    // 箭头
    let moreIndicator = UIImageView()
    
    let topshadowView = UIView()
    
    
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
            detailShadowView.frame.size = CGSize(width: detailShadowView.frame.width, height: 20 + (viewmodel?.messageHeight ?? 0) + 35)
            notificationDetailLabel.frame.size = CGSize(width: detailShadowView.frame.width - 20, height: viewmodel?.messageHeight ?? 0)
            lineView.frame.origin = CGPoint(x: 10, y: notificationDetailLabel.frame.maxY + 10)
            showmoreLabel.frame.origin = CGPoint(x: 10, y: notificationDetailLabel.frame.maxY + 21)
            moreIndicator.frame.origin = CGPoint(x: detailShadowView.frame.width - 22, y: notificationDetailLabel.frame.maxY + 21)
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
        selectionStyle = .none
        
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
        
        topshadowView.frame = CGRect(x: 58, y: 33, width: sWidth - 58 - 25, height: 36)
        topshadowView.backgroundColor = UIColor.init(red: 1, green: 212/255, blue: 48/255, alpha: 1)
        addSubview(topshadowView)
        
        notificationTitileLabel.frame = CGRect(x: 12, y: 10, width: topshadowView.frame.width - 24, height: 17)
        notificationTitileLabel.textColor = UIColor.white
        notificationTitileLabel.font = UIFont.boldSystemFont(ofSize: 16)
        topshadowView.addSubview(notificationTitileLabel)
        
        detailShadowView.frame = CGRect(x: 58, y: 69, width: topshadowView.frame.width, height: 20 + (viewmodel?.messageHeight ?? 14) + 35)
        detailShadowView.backgroundColor = UIColor.white
        addSubview(detailShadowView)
        
        notificationDetailLabel.frame = CGRect(x: 10, y: 10, width: detailShadowView.frame.width - 20, height: 14)
        notificationDetailLabel.font = UIFont.boldSystemFont(ofSize: 14)
        notificationDetailLabel.numberOfLines = 0
        notificationDetailLabel.textColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
        detailShadowView.addSubview(notificationDetailLabel)
        
        lineView.frame = CGRect(x: 10, y: notificationDetailLabel.frame.maxY , width: detailShadowView.frame.width - 20, height: 1)
        lineView.backgroundColor = UIColor.init(red: 220/255, green: 224/255, blue: 224/255, alpha: 1)
        detailShadowView.addSubview(lineView)
        
        showmoreLabel.frame = CGRect(x: 10, y: notificationDetailLabel.frame.maxY + 11, width: 80, height: 15)
        showmoreLabel.font = UIFont.boldSystemFont(ofSize: 14)
        showmoreLabel.textColor = UIColor.init(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
        showmoreLabel.text = "查看详情"
        detailShadowView.addSubview(showmoreLabel)
        
        moreIndicator.frame = CGRect(x: detailShadowView.frame.width - 22, y: notificationDetailLabel.frame.maxY + 11, width: 14, height: 14)
        moreIndicator.image = UIImage(named: "notification_indicator")
        detailShadowView.addSubview(moreIndicator)
        
    }

}
