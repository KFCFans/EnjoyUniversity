//
//  ActivityViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/3/31.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation
import UIKit

class EUActivityViewController: EUBaseAvtivityViewController {
    
    
    // 地点
    var placeLabel = UILabel()
    
    // 时间
    var timeLabel = UILabel()
    
    // 价格
    var priceLabel = UILabel()
    
    // 人数
    var numLabel = UILabel()
    
    // 活动详情
    let detailLabel = UILabel()
    
    // 活动详情文本高度
    var detailHeight:CGFloat = 0
    
    /// ViewModel 数据源
    var viewmodel:ActivityViewModel?{
        
        didSet{
            titleLabel.text = viewmodel?.activitymodel.avTitle ?? "标题加载失败"
            placeLabel.text = viewmodel?.activitymodel.avPlace
            timeLabel.text = viewmodel?.allTime
            priceLabel.text = viewmodel?.price
            detailLabel.text = viewmodel?.activitymodel.avDetail ?? "详情加载失败"
            detailHeight = viewmodel?.detailHeight ?? 0.0
            
        }
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLeaderInfoUI()
        setupActivityInfoUI()
        setupActivityDetailUI()
        setupParticipateButton()
        
    }
    
}

// MARK: - UI 相关方法
extension EUActivityViewController{
    
        
    fileprivate func setupLeaderInfoUI(){
     
        /// 发起者视图
        let leaderView = UIView(frame: CGRect(x: 5, y: 190, width: UIScreen.main.bounds.width - 10, height: 70))
        leaderView.backgroundColor = UIColor.white
        scrollView.addSubview(leaderView)
        
        let headimg = UIImageView(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
        headimg.image = UIImage(named: "av_leader")
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
        
        /// 设置滚动空间
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 510 + detailHeight)
        
        /// 活动信息视图
        let activityinfoview = UIView(frame: CGRect(x: 5, y: 270, width: UIScreen.main.bounds.width - 10, height: 176))
        activityinfoview.backgroundColor = UIColor.white
        scrollView.addSubview(activityinfoview)
        
        // 价格
        let avpriceimg = UIImageView(frame: CGRect(x: 12, y: 14, width: 16, height: 16))
        avpriceimg.image = UIImage(named: "av_price")
        activityinfoview.addSubview(avpriceimg)
        
        priceLabel.textColor = UIColor.darkGray
        priceLabel.frame = CGRect(x: 40, y: 15, width: 100, height: 14)
        priceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        activityinfoview.addSubview(priceLabel)
        
        // 地点
        let avplaceimg = UIImageView(frame: CGRect(x: 12, y: 58, width: 16, height: 16))
        avplaceimg.image = UIImage(named: "av_place")
        activityinfoview.addSubview(avplaceimg)
        
        placeLabel.textColor = UIColor.darkGray
        placeLabel.frame = CGRect(x: 40, y: 59, width: 200, height: 14)
        placeLabel.font = UIFont.boldSystemFont(ofSize: 14)
        activityinfoview.addSubview(placeLabel)
        
        // 时间
        let avtimeimg = UIImageView(frame: CGRect(x: 12, y: 102, width: 16, height: 16))
        avtimeimg.image = UIImage(named: "av_time")
        activityinfoview.addSubview(avtimeimg)
        
        timeLabel.textColor = UIColor.darkGray
        timeLabel.frame = CGRect(x: 40, y: 103, width: UIScreen.main.bounds.width, height: 14)
        timeLabel.font = UIFont.boldSystemFont(ofSize: 14)
        activityinfoview.addSubview(timeLabel)
        
        
        // 人数
        let numview = UIImageView(frame: CGRect(x: 0, y: 132, width: activityinfoview.frame.width, height: 44))
        activityinfoview.addSubview(numview)

        let avenrollimg = UIImageView(frame: CGRect(x: 12, y: 14, width: 16, height: 16))
        avenrollimg.image = UIImage(named: "av_enroll")
        numview.addSubview(avenrollimg)
        
        numLabel.text = "已报名30人/限100人"
        numLabel.textColor = UIColor.darkGray
        numLabel.frame = CGRect(x: 40, y: 15, width: 200, height: 14)
        numLabel.font = UIFont.boldSystemFont(ofSize: 14)
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
        

        
        // 活动详情视图
        let detailview = UIView(frame: CGRect(x: 5, y: 456, width: UIScreen.main.bounds.width - 10, height: 44 + detailHeight + 10))
        detailview.backgroundColor = UIColor.white
        scrollView.addSubview(detailview)
        
        let dtitle = UILabel(frame: CGRect(x: 15, y: 15, width: 100, height: 15))
        dtitle.textColor = UIColor.black
        dtitle.text = "活动详情"
        dtitle.font = UIFont.boldSystemFont(ofSize: 15)
        detailview.addSubview(dtitle)
        
        // 详情
        detailLabel.frame = CGRect(x: 15, y: 44, width: UIScreen.main.bounds.width - 30, height: detailHeight)
        detailLabel.numberOfLines = 0
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
    

    
    @objc fileprivate func callButtonIsClicked(){
        print("发起电话")
    }
    
    // 获取参与者列表
    @objc fileprivate func showParticipators(){
        print("showDetail")
        
    }
    
}
