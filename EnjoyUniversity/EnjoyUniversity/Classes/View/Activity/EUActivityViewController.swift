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
    
    // 发起者昵称
    let nicknamelabel = UILabel(frame: CGRect(x: 72, y: 20, width: 200, height: 15))

    // 发起者节操值
    let reputationlabel = UILabel(frame: CGRect(x: 72, y: 41, width: 200, height: 10))

    // 发起者头像
    let headimg = UIImageView(frame: CGRect(x: 10, y: 10, width: 50, height: 50))
    
    // 参加活动按钮
    let participateButton = UIButton(frame: CGRect(x: 12, y: UIScreen.main.bounds.height - 50, width: UIScreen.main.bounds.width - 24, height: 44))
    
    /// 参与者数据源
    lazy var participatorslist = UserInfoListViewModel()
    
    /// 活动视图模型列表
    var activitylistviewmodel:ActivityListViewModel?
    
    /// 这是第几个，用于删除
    var row:Int = 0
    
    
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
            registerCode = viewmodel?.activitymodel.avRegister ?? 0
            if EUNetworkManager.shared.userAccount.uid == (viewmodel?.activitymodel.uid ?? 0) && activityStatus == 0{
                activityStatus = 2
            }
            
            let url = URL(string: viewmodel?.imageURL ?? "")
            backgroudImage.kf.setImage(with: url,
                                       placeholder: UIImage(named: "tempbackground"),
                                       options: [.transition(.fade(1))],
                                       progressBlock: nil,
                                       completionHandler: nil)
            
        }
        
    }
    
    /// 活动状态 0默认 1我参加的 2我创建的
    var activityStatus:Int = 0{
        
        didSet{
            
            if activityStatus == 2{
                participateButton.setTitle("无法参加自己创建的活动", for: .normal)
                participateButton.backgroundColor = UIColor.lightGray
                participateButton.isEnabled = false
                
            }else if activityStatus == 1 {
                participateButton.setTitle("退出活动", for: .normal)
                participateButton.backgroundColor = UIColor.red
        
                
            }
            
        }
        
    }
    
    /// 签到码
    var registerCode = 0{
        
        didSet{
            if activityStatus == 1 && registerCode > 999{
                    participateButton.setTitle("我要签到", for: .normal)
                    participateButton.backgroundColor = UIColor.init(red: 46/255, green: 183/255, blue: 144/255, alpha: 1)
            }
        }
    }

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        setupNavUI()
        setupLeaderInfoUI()
        setupParticipateButton()
        
    }
    
    private func loadData(){
        
        guard let uid = viewmodel?.activitymodel.uid,let avid = viewmodel?.activitymodel.avid else {
            return
        }
        
        EUNetworkManager.shared.getUserInfomation(uid: uid) { (isSuccess, dict) in
            
            if !isSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络错误", duration: 1)
            }
            guard let dict = dict else{
                return
            }
            let name = dict["name"] as? String
            let reputation = (dict["reputation"] as? Int) ?? 100
            let avaterurl = dict["avatar"] as? String
            
            self.nicknamelabel.text = name
            self.nicknamelabel.sizeToFit()
            self.reputationlabel.text = "节操值 \(reputation)"
            self.headimg.kf.setImage(with: URL(string: PICTURESERVERADDRESS + "/user/" + (avaterurl ?? "") + ".jpg"),
                                placeholder: UIImage(named: "av_leader"),
                                options: [.transition(.fade(1))],
                                progressBlock: nil,
                                completionHandler: nil)
        }
        
        participatorslist.loadActivityMemberInfoList(avid: avid) { (isSuccess,hasMember) in
            
            if !isSuccess{
                self.participatornumLabel.text = "列表加载失败,请检查网络设置"
                return
            }
            if !hasMember{
                self.participatornumLabel.text = "还没有小伙伴报名参加～"
                return
            }
        
            self.participatornumLabel.text = "已报名\(self.participatorslist.activityParticipatorList.count)人／" + (self.viewmodel?.expectPeople ?? "人数不限")
      
        }
        
        
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
        

        headimg.image = UIImage(named: "av_leader")
        headimg.layer.cornerRadius = 25
        headimg.layer.masksToBounds = true
        leaderView.addSubview(headimg)
        
        nicknamelabel.text = "假诗人"
        nicknamelabel.font = UIFont.boldSystemFont(ofSize: 15)
        nicknamelabel.sizeToFit()
        nicknamelabel.textColor = UIColor.black
        leaderView.addSubview(nicknamelabel)
        
        reputationlabel.text = "节操值 100"
        reputationlabel.textColor = UIColor.lightGray
        reputationlabel.font = UIFont.boldSystemFont(ofSize: 10)
        leaderView.addSubview(reputationlabel)
        
        let shaodwview = UIView(frame: CGRect(x: 72 + nicknamelabel.frame.width + 5, y: 20, width: 37, height: 15))
        shaodwview.center.y = nicknamelabel.center.y
        shaodwview.backgroundColor = UIColor.init(red: 214/255, green: 241/255, blue: 1, alpha: 1)
        leaderView.addSubview(shaodwview)
        
        let leaderlabel = UILabel(frame: CGRect(x: 0, y: 0, width: 37, height: 15))
        leaderlabel.text = "主办者"
        leaderlabel.textColor = UIColor.init(red: 14/255, green: 36/255, blue: 48/255, alpha: 1)
        leaderlabel.font = UIFont.boldSystemFont(ofSize: 10)
        leaderlabel.textAlignment = .center
        shaodwview.addSubview(leaderlabel)
        
        
        let phonebtn = UIButton(frame: CGRect(x: leaderView.frame.width - 60, y: 10, width: 50, height: 50))
        phonebtn.setImage(UIImage(named: "av_call"), for: .normal)
        leaderView.addSubview(phonebtn)
        phonebtn.addTarget(nil, action: #selector(callButtonIsClicked), for: .touchUpInside)
        
    }
    

    
    fileprivate func setupParticipateButton(){
        
        
        if activityStatus == 0{
            participateButton.backgroundColor = UIColor.orange
            participateButton.setTitle("我要参加", for: .normal)
        }
        participateButton.addTarget(nil, action: #selector(participateActivity), for: .touchUpInside)
        view.addSubview(participateButton)
        
    }
    
}


// MARK: - 监听方法集合
extension EUActivityViewController{
    

    
    /// 打电话按钮
    @objc fileprivate func callButtonIsClicked(){
        
        guard let phone = viewmodel?.activitymodel.uid else{
            return
        }
        
        UIApplication.shared.open(URL(string: "telprompt://\(phone)")!, options: [:], completionHandler: nil)

    }
    
    
    /// 分享活动
    @objc fileprivate func shareButtonIsClicked(){
        
    }
    
    /// 收藏
    @objc fileprivate func collectButtonIsClicked(){
        
        guard let avid = viewmodel?.activitymodel.avid else{
            return
        }
        SwiftyProgressHUD.showLoadingHUD()
        EUNetworkManager.shared.collectActivity(avid: avid) { (requestIsSuccess, collectIsSuccess) in
            SwiftyProgressHUD.hide()
            if !requestIsSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络错误", duration: 1)
                return
            }
            
            if !collectIsSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "收藏过啦", duration: 1)
                return
            }
            SwiftyProgressHUD.showSuccessHUD(duration: 1)
            
        }
        
    }
    
    /// 查看已报名列表
    @objc fileprivate func showListOfParticipators(){
        
    }
    
    /// 参加活动
    @objc fileprivate func participateActivity(){
        
        guard let avid = viewmodel?.activitymodel.avid else {
            return
        }
        
        
        if activityStatus == 0 {
            
            // 参加活动
            SwiftyProgressHUD.showLoadingHUD()
            EUNetworkManager.shared.participateActivity(avid: avid,needregist:viewmodel?.needRegisterBool ?? false) { (isSuccess, isParticiateSuccess) in
                SwiftyProgressHUD.hide()
                if !isSuccess{
                    SwiftyProgressHUD.showFaildHUD(text: "网络错误", duration: 1)
                    return
                }
                if !isParticiateSuccess{
                    SwiftyProgressHUD.showFaildHUD(text: "您已参加", duration: 1)
                    return
                }
                SwiftyProgressHUD.showSuccessHUD(duration: 1)
                
            }
        }else if activityStatus == 1 && registerCode < 1000{
            
            let altervc = UIAlertController(title: "退出活动", message: "您确定要退出当前活动吗？", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            let confirm = UIAlertAction(title: "确定", style: .destructive, handler: { (_) in
                
                // 退出活动
                SwiftyProgressHUD.showLoadingHUD()
                EUNetworkManager.shared.leaveActivity(avid: avid, completion: { (isSuccess, isQuitSuccess) in
                    SwiftyProgressHUD.hide()
                    
                    if !isSuccess{
                        SwiftyProgressHUD.showFaildHUD(text: "网络错误", duration: 1)
                        return
                    }
                    
                    if !isQuitSuccess{
                        SwiftyProgressHUD.showFaildHUD(text: "已退出", duration: 1)
                        return
                    }
                    SwiftyProgressHUD.showSuccessHUD(duration: 1)
                    self.activitylistviewmodel?.participatedlist.remove(at: self.row)
                    _ = self.navigationController?.popViewController(animated: true)
                    
                    
                })
            })
            
            altervc.addAction(cancel)
            altervc.addAction(confirm)
            
            present(altervc, animated: true, completion: nil)
            
        }else if activityStatus == 1 && registerCode > 999{
            let vc = EURegisterViewController()
            vc.registerCode = registerCode
            vc.avid = avid
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    /// 返回按钮
    override func backButtonIsClicked() {
        
        if activityStatus == 0{
        
            _ = navigationController?.popToRootViewController(animated: true)
        }else{
            _ = navigationController?.popViewController(animated: true)
        }
        
    }
    
}
        
