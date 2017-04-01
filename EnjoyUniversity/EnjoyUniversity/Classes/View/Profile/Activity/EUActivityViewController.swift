//
//  ActivityViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/3/31.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation
import UIKit

class EUActivityViewController: UIViewController {
    
    
    /// 头部视图，到时候可以抽取成父类
    // 背景图片
    var backgroudImage = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 180))
 
    // 返回按钮
    var backBtn = UIButton()
    
    // 分享按钮
    var shareBtn = UIButton()
    
    // 收藏按钮
    var collectBtn = UIButton()
    
    // 活动标题文本
    var titleLabel = UILabel()
    
    // 是否需要签到
    var warnLabel = UILabel()
    
    // 滑动视图
    var scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 60))
    
    /// 下面的布局
    // 地点
    var placeLabel = UILabel()
    
    // 时间
    var timeLabel = UILabel()
    
    // 价格
    var priceLabel = UILabel()
    
    // 人数
    var numLabel = UILabel()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeadUI()
        setupLeaderInfoUI()
        setupActivityInfoUI()
        setupActivityDetailUI()
        setupParticipateButton()
        
    }
    
}

// MARK: - UI 相关方法
extension EUActivityViewController{
    
    fileprivate func setupHeadUI(){
        
        // FIXME: 在视图模型中计算 ContenSize
        // 设置滚动视图
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 100)
        view.addSubview(scrollView)
        // 使用 F2F2F2 配色
        scrollView.backgroundColor = UIColor.init(colorLiteralRed: 242.0/255.0, green: 242.0/255.0, blue: 242/255.0, alpha: 1)
        view.backgroundColor = UIColor.init(colorLiteralRed: 242.0/255.0, green: 242.0/255.0, blue: 242/255.0, alpha: 1)
        
        // 背景图(后面用 Kingfisher 加载)
        backgroudImage.image = UIImage(named: "background")
        backgroudImage.clipsToBounds = true
        
        // 返回按钮
        backBtn.setImage(UIImage(named: "nav_back"), for: .normal)
        backBtn.frame = CGRect(x: 20, y: 30, width: 24, height: 24)
        
        // 分享按钮
        shareBtn.setImage(UIImage(named: "nav_share"), for: .normal)
        shareBtn.frame = CGRect(x: UIScreen.main.bounds.width - 88, y: 30, width: 24, height: 24)
        
        // 收藏按钮
        collectBtn.setImage(UIImage(named: "nav_collect"), for: .normal)
        collectBtn.frame = CGRect(x: UIScreen.main.bounds.width - 44, y: 30, width: 24, height: 24)
        
        // 标题
        titleLabel.text = "我是标题党"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = UIColor.white
        
        // 提醒
        let noticeview = UIView(frame: CGRect(x: 12, y: 152, width: 80, height: 18))
        noticeview.backgroundColor = UIColor.darkGray
        noticeview.alpha = 0.4
        
        let warn = UIImageView(image: UIImage(named: "nav_warn"))
        warn.frame = CGRect(x: 3, y: 1.5, width: 15, height: 15)
        noticeview.addSubview(warn)
        
        warnLabel.text = "需要签到"
        warnLabel.textColor = UIColor.white
        warnLabel.font = UIFont.boldSystemFont(ofSize: 12)
        warnLabel.frame = CGRect(x: 22, y: 1.5, width: 60, height: 15)
        noticeview.addSubview(warnLabel)
        
        
        scrollView.addSubview(backgroudImage)
        view.addSubview(backBtn)
        view.addSubview(shareBtn)
        view.addSubview(collectBtn)
        backgroudImage.addSubview(titleLabel)
        backgroudImage.addSubview(noticeview)

    }
    
    fileprivate func setupLeaderInfoUI(){
     
        /// 发起者视图
        let leaderView = UIView(frame: CGRect(x: 5, y: 190, width: UIScreen.main.bounds.width - 10, height: 70))
        leaderView.backgroundColor = UIColor.white
        scrollView.addSubview(leaderView)
        
        let headimg = UIImageView(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
        headimg.image = UIImage(named: "nav_avat")
        leaderView.addSubview(headimg)
        
        let nicknamelabel = UILabel(frame: CGRect(x: 72, y: 20, width: 200, height: 15))
        nicknamelabel.text = "假诗人"
        nicknamelabel.font = UIFont.boldSystemFont(ofSize: 15)
        nicknamelabel.textColor = UIColor.black
        leaderView.addSubview(nicknamelabel)
        
        let reputationlabel = UILabel(frame: CGRect(x: 72, y: 41, width: 200, height: 10))
        reputationlabel.text = "节操值 100"
        reputationlabel.textColor = UIColor.lightGray
        reputationlabel.font = UIFont.boldSystemFont(ofSize: 10)
        leaderView.addSubview(reputationlabel)
        
        let phonebtn = UIButton(frame: CGRect(x: leaderView.frame.width - 60, y: 10, width: 50, height: 50))
        phonebtn.setImage(UIImage(named: "nav_call"), for: .normal)
        leaderView.addSubview(phonebtn)
        phonebtn.addTarget(nil, action: #selector(callButtonIsClicked), for: .touchUpInside)
        
    }
    
    fileprivate func setupActivityInfoUI(){
        
        /// 活动信息视图
        let activityinfoview = UIView(frame: CGRect(x: 5, y: 270, width: UIScreen.main.bounds.width - 10, height: 176))
        activityinfoview.backgroundColor = UIColor.white
        scrollView.addSubview(activityinfoview)
        
        // 价格
        let avpriceimg = UIImageView(frame: CGRect(x: 12, y: 14, width: 16, height: 16))
        avpriceimg.image = UIImage(named: "av_price")
        activityinfoview.addSubview(avpriceimg)
        
        priceLabel.text = "免费"
        priceLabel.textColor = UIColor.darkGray
        priceLabel.frame = CGRect(x: 40, y: 17, width: 100, height: 10)
        priceLabel.font = UIFont.boldSystemFont(ofSize: 10)
        activityinfoview.addSubview(priceLabel)
        
        // 地点
        let avplaceimg = UIImageView(frame: CGRect(x: 12, y: 58, width: 16, height: 16))
        avplaceimg.image = UIImage(named: "av_place")
        activityinfoview.addSubview(avplaceimg)
        
        placeLabel.text = "江南大学图书馆"
        placeLabel.textColor = UIColor.darkGray
        placeLabel.frame = CGRect(x: 40, y: 61, width: 200, height: 10)
        placeLabel.font = UIFont.boldSystemFont(ofSize: 10)
        activityinfoview.addSubview(placeLabel)
        
        // 时间
        let avtimeimg = UIImageView(frame: CGRect(x: 12, y: 102, width: 16, height: 16))
        avtimeimg.image = UIImage(named: "av_time")
        activityinfoview.addSubview(avtimeimg)
        
        timeLabel.text = "04-28 10:00 ~ 04-29 10:00"
        timeLabel.textColor = UIColor.darkGray
        timeLabel.frame = CGRect(x: 40, y: 105, width: 200, height: 10)
        timeLabel.font = UIFont.boldSystemFont(ofSize: 10)
        activityinfoview.addSubview(timeLabel)
        
        
        // 人数
        let numview = UIImageView(frame: CGRect(x: 0, y: 132, width: activityinfoview.frame.width, height: 44))
        activityinfoview.addSubview(numview)

        let avenrollimg = UIImageView(frame: CGRect(x: 12, y: 14, width: 16, height: 16))
        avenrollimg.image = UIImage(named: "av_enroll")
        numview.addSubview(avenrollimg)
        
        numLabel.text = "已报名30人/限100人"
        numLabel.textColor = UIColor.darkGray
        numLabel.frame = CGRect(x: 40, y: 17, width: 200, height: 10)
        numLabel.font = UIFont.boldSystemFont(ofSize: 10)
        numview.addSubview(numLabel)
        
        let moreimg = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width - 28, y: 14, width: 16, height: 16))
        moreimg.image = UIImage(named: "nav_more")
        numview.addSubview(moreimg)

        // 添加点击响应事件
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(showParticipators))
        numview.isUserInteractionEnabled = true
        numview.addGestureRecognizer(tapgesture)
        
    }
    
    fileprivate func setupActivityDetailUI(){
        
        // 计算文本所需高度
        let text = "我是详情我是详情我是详情我是详情我是详情我是详情我是详情我是详情我是详情我是详情我是详情我是详情我是详情我是详情我是详情我是详情我是详情我是详情我是详情我是详情我是详情我是详情我是详情我是详情我是"
        let size = CGSize(width: UIScreen.main.bounds.width - 40, height: 5000)
        let height = (text as NSString).boundingRect(with: size,
                                                     options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                     attributes: [NSFontAttributeName:UIFont.boldSystemFont(ofSize: 14)],
                                                     context: nil).height
        
        // 活动详情视图
        let detailview = UIView(frame: CGRect(x: 5, y: 456, width: UIScreen.main.bounds.width - 10, height: 44 + height + 10))
        detailview.backgroundColor = UIColor.white
        scrollView.addSubview(detailview)
        
        let dtitle = UILabel(frame: CGRect(x: 15, y: 15, width: 100, height: 15))
        dtitle.textColor = UIColor.black
        dtitle.text = "活动详情"
        dtitle.font = UIFont.boldSystemFont(ofSize: 15)
        detailview.addSubview(dtitle)
        
        // 详情
        let detailLabel = UILabel(frame: CGRect(x: 15, y: 44, width: UIScreen.main.bounds.width - 30, height: height))
        detailLabel.numberOfLines = 0
        detailLabel.text = text
        detailLabel.backgroundColor = UIColor.white
        detailLabel.textColor = UIColor.darkGray
        detailLabel.font = UIFont.boldSystemFont(ofSize: 14)
        detailview.addSubview(detailLabel)
        
    }
    
    fileprivate func setupParticipateButton(){
        
        let participateButton = UIButton(frame: CGRect(x: 12, y: UIScreen.main.bounds.height - 50, width: UIScreen.main.bounds.width - 24, height: 44))
        participateButton.backgroundColor = UIColor.orange
        participateButton.setTitle("我要参加", for: .normal)
        view.addSubview(participateButton)
        
    }
    
}


// MARK: - 监听方法集合
extension EUActivityViewController{
    
    @objc fileprivate func backButtonIsClicked(){
        
    }
    
    @objc fileprivate func shareButtonIsClicked(){
        
    }
    
    @objc fileprivate func collectButtonIsClicked(){
        
    }
    
    @objc fileprivate func callButtonIsClicked(){
        print("发起电话")
    }
    
    // 获取参与者列表
    @objc fileprivate func showParticipators(){
        print("showDetail")
        
    }
    
}
