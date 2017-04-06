//
//  ActivityViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/3/31.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class EUActivityViewController: EUBaseAvtivityViewController {
    
    // 分享按钮
    var shareBtn = UIButton()
    
    // 收藏按钮
    var collectBtn = UIButton()

    /// ViewModel 数据源
    var viewmodel:ActivityViewModel?{
        
        didSet{
            titleLabel.text = viewmodel?.activitymodel.avTitle ?? "标题加载失败"
            placeLabel.text = viewmodel?.activitymodel.avPlace
            timeLabel.text = viewmodel?.allTime
            priceLabel.text = viewmodel?.price
            detailLabel.text = viewmodel?.activitymodel.avDetail ?? "详情加载失败"
            detailHeight = viewmodel?.detailHeight ?? 0.0
            warnLabel.text = viewmodel?.needRegister
            let url = URL(string: viewmodel?.imageURL ?? "")
            backgroudImage.kf.setImage(with: url,
                                       placeholder: UIImage(named: "tempbackground"),
                                       options: [.transition(.fade(1))],
                                       progressBlock: nil,
                                       completionHandler: nil)
            
        }
        
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavUI()
        setupLeaderInfoUI()

        setupParticipateButton()
        
    }
    
}

// MARK: - UI 相关方法
extension EUActivityViewController{
    
    fileprivate func setupNavUI(){
        // 分享按钮
        let shareshadow = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width - 94, y: 30, width: 30, height: 30))
        shareshadow.image = UIImage(named: "nav_background")
        shareshadow.alpha = 0.7
        view.addSubview(shareshadow)
        shareBtn.setImage(UIImage(named: "nav_share"), for: .normal)
        shareBtn.frame = CGRect(x: 3, y: 3, width: 24, height: 24)
        shareshadow.isUserInteractionEnabled = true
        shareshadow.addSubview(shareBtn)
        shareBtn.addTarget(nil, action: #selector(shareButtonIsClicked), for: .touchUpInside)
        
        // 收藏按钮
        let collectshadow = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width - 50, y: 30, width: 30, height: 30))
        collectshadow.image = UIImage(named: "nav_background")
        collectshadow.alpha = 0.7
        collectshadow.isUserInteractionEnabled = true
        view.addSubview(collectshadow)
        collectBtn.setImage(UIImage(named: "nav_collect"), for: .normal)
        collectBtn.frame = CGRect(x: 3, y: 3, width: 24, height: 24)
        collectBtn.addTarget(nil, action: #selector(collectButtonIsClicked), for: .touchUpInside)
        collectshadow.addSubview(collectBtn)
    }
    
        
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
        phonebtn.setImage(UIImage(named: "av_call"), for: .normal)
        leaderView.addSubview(phonebtn)
        phonebtn.addTarget(nil, action: #selector(callButtonIsClicked), for: .touchUpInside)
        
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
        
        UIApplication.shared.open(URL(string: "telprompt://15061884797")!, options: [:], completionHandler: nil)

    }
    
    
    @objc fileprivate func shareButtonIsClicked(){
        
    }
    
    @objc fileprivate func collectButtonIsClicked(){
        
    }
    
}
