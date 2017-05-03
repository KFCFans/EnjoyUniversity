//
//  EUCreatedActivityViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/1.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCreatedActivityViewController: EUBaseAvtivityViewController {

    /// 上层传入，用于删除
    var activitylistviewmodel:ActivityListViewModel?
    
    var row:Int = 0
    
    /// 参与者数据源
    lazy var participatorslist = UserInfoListViewModel()

    /// 记录活动 ID
    var avid:Int = 0
    
    /// 参与者数据加载完成标记
    var isFinished:Bool = false
    
    var viewmodel:ActivityViewModel?{
        didSet{
            // 将其它操作移到 viewWillAppear 中，支持修改
            let url = URL(string: viewmodel?.imageURL ?? "")
            detailHeight = viewmodel?.detailHeight ?? 0
            backgroudImage.kf.setImage(with: url,
                                       placeholder: UIImage(named: "tempbackground"),
                                       options: [.transition(.fade(1))],
                                       progressBlock: nil,
                                       completionHandler: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
        setupNavUI()
        setupFunctionUI()
        setupQRCodeUI()
        setupChangeButton()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        titleLabel.text = viewmodel?.activitymodel.avTitle
        placeLabel.text = viewmodel?.activitymodel.avPlace
        priceLabel.text = viewmodel?.price
        timeLabel.text = viewmodel?.allTime
        detailLabel.text = viewmodel?.activitymodel.avDetail
        avid = viewmodel?.activitymodel.avid ?? 0
        warnLabel.text = viewmodel?.needRegister
        self.participatornumLabel.text = "已报名\(self.participatorslist.activityParticipatorList.count)人／" + (self.viewmodel?.expectPeople ?? "人数不限")
        if let img = viewmodel?.activityImg{
            backgroudImage.image = img
        }
        // FIXME: - 活动详情独立的一页，类似于活动行
        detailHeight = viewmodel?.detailHeight ?? 0

    }
    
    private func loadData(){
        
        guard let avid = viewmodel?.activitymodel.avid else {
            return
        }
        self.participatornumLabel.text = "正在加载..."
        participatorslist.loadActivityMemberInfoList(avid: avid) { (isSuccess, hasMember) in
            if !isSuccess{
                self.participatornumLabel.text = "列表加载失败,请检查网络设置"
                return
            }
            self.isFinished = true
            if !hasMember{
                self.participatornumLabel.text = "还没有小伙伴报名参加～"
                return
            }
            
            self.participatornumLabel.text = "已报名\(self.participatorslist.activityParticipatorList.count)人／" + (self.viewmodel?.expectPeople ?? "人数不限")
        }
        
    }
    
}

// MARK: - UI 相关方法
extension EUCreatedActivityViewController{
    
    fileprivate func setupNavUI(){
        
        
        let rightshadow = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width - 50, y: 30, width: 30, height: 30))
        rightshadow.image = UIImage(named: "nav_background")
        rightshadow.alpha = 0.7
        view.addSubview(rightshadow)
        
        let moreactionBtn = UIButton(frame: CGRect(x: 3, y: 3, width: 24, height: 24))
        moreactionBtn.setImage(UIImage(named: "nav_point"), for: .normal)
        moreactionBtn.isUserInteractionEnabled = true
        rightshadow.isUserInteractionEnabled = true
        moreactionBtn.addTarget(nil, action: #selector(moreActionBtnIsClicked), for: .touchUpInside)
        rightshadow.addSubview(moreactionBtn)
        
        /// 滑动区域大小下
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 600 + detailHeight)
        
    }
    
    fileprivate func setupFunctionUI(){
        
        let functionview = UIView(frame: CGRect(x: 5, y: 190, width: UIScreen.main.bounds.width - 10, height: 70))
        functionview.backgroundColor = UIColor.white
        scrollView.addSubview(functionview)
     
        let buttonWidth:CGFloat = 50
        let margin = (functionview.bounds.width - 4 * buttonWidth) / 5
        
        let checkBtn = EUActivityButton(frame: CGRect(x: margin, y: 8, width: buttonWidth, height: 62), image: UIImage(named: "av_check")!, text: "审核", shadowimage: UIImage(named: "av_shadow_orange")!)
        functionview.addSubview(checkBtn)
        
        let notifBtn = EUActivityButton(frame: CGRect(x: margin * 2 + buttonWidth, y: 8, width: buttonWidth, height: 62), image: UIImage(named: "av_notify")!, text: "通知", shadowimage: UIImage(named: "av_shadow_red")!)
        functionview.addSubview(notifBtn)
        
        let shareBtn = EUActivityButton(frame: CGRect(x: margin * 3 + buttonWidth * 2, y: 8, width: buttonWidth, height: 62), image: UIImage(named: "av_share")!, text: "分享", shadowimage: UIImage(named: "av_shadow_blue")!)
        functionview.addSubview(shareBtn)
        
        let registerBtn = EUActivityButton(frame: CGRect(x: margin * 4 + buttonWidth * 3, y: 8, width: buttonWidth, height: 62), image: UIImage(named: "av_register")!, text: "签到", shadowimage: UIImage(named: "av_shadow_purple")!)
        functionview.addSubview(registerBtn)
        
        // 添加监听事件
        checkBtn.addTarget(nil, action: #selector(checkBtnIsClicked), for: .touchUpInside)
        notifBtn.addTarget(nil, action: #selector(notifyParticipators), for: .touchUpInside)
        registerBtn.addTarget(nil, action: #selector(startRegister), for: .touchUpInside)
        
        // 添加点击响应事件
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(checkBtnIsClicked))
        participatornumview.isUserInteractionEnabled = true
        participatornumview.addGestureRecognizer(tapgesture)
        
    }
    
    
    fileprivate func setupQRCodeUI(){
        
        let qrcodeview = UIView(frame: CGRect(x: 5, y: 520 + detailHeight, width: UIScreen.main.bounds.width - 10, height: 80))
        qrcodeview.backgroundColor = UIColor.white
        scrollView.addSubview(qrcodeview)
        
        let qrtitlelabel = UILabel(frame: CGRect(x: 15, y: 20, width: 150, height: 15))
        qrtitlelabel.text = "活动专属二维码"
        qrtitlelabel.textColor = UIColor.black
        qrtitlelabel.font = UIFont.boldSystemFont(ofSize: 15)
        qrcodeview.addSubview(qrtitlelabel)
        
        let qrdetaillabel = UILabel(frame: CGRect(x: 15, y: 50, width: 150, height: 14))
        qrdetaillabel.text = "扫一扫了解详情"
        qrdetaillabel.textColor = UIColor.lightGray
        qrdetaillabel.font = UIFont.boldSystemFont(ofSize: 14)
        qrcodeview.addSubview(qrdetaillabel)
        
        let qrBtn = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 54, y: 32, width: 32, height: 32))
        qrBtn.setImage(UIImage(named: "av_qrcode"), for: .normal)
        qrBtn.addTarget(nil, action: #selector(showQRCode), for: .touchUpInside)
        qrcodeview.addSubview(qrBtn)
        
    }
    
    fileprivate func setupChangeButton(){
        
        let changeButton = UIButton(frame: CGRect(x: 12, y: UIScreen.main.bounds.height - 50, width: UIScreen.main.bounds.width - 24, height: 44))
        changeButton.backgroundColor = UIColor.orange
        changeButton.setTitle("修改活动", for: .normal)
        changeButton.addTarget(nil, action: #selector(changeActiity), for: .touchUpInside)
        view.addSubview(changeButton)
        
    }
    
    
    
}

// MARK: - 监听方法集合
extension EUCreatedActivityViewController{
    
    /// 更多按钮
    @objc fileprivate func moreActionBtnIsClicked(){
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let confirm = UIAlertAction(title: "删除活动", style: .destructive) { (_) in
            
            SwiftyProgressHUD.showLoadingHUD()
            EUNetworkManager.shared.deleteActivity(avid: self.avid, completion: { (isSuccess, hasPermission) in
                SwiftyProgressHUD.hide()
                if !isSuccess{
                    SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                    return
                }
                if !hasPermission{
                    SwiftyProgressHUD.showFaildHUD(text: "没有权限", duration: 1)
                    return
                }
                SwiftyProgressHUD.showSuccessHUD(duration: 1)
                self.activitylistviewmodel?.createdlist.remove(at: self.row)
                _ = self.navigationController?.popViewController(animated: true)
                
            })
            
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
        
    }
    
    /// 审核
    @objc fileprivate func checkBtnIsClicked(){
        
        if !isFinished{
            SwiftyProgressHUD.showFaildHUD(text: "列表加载中", duration: 1)
            return
        }
        
        if viewmodel?.isFinished ?? true{
            SwiftyProgressHUD.showFaildHUD(text: "活动已结束", duration: 1)
            return
        }
        
        let vc = EUActivityParticipatorsViewController()
        vc.participatorslist = participatorslist
        vc.avid = avid
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    /// 显示二维码
    @objc fileprivate func showQRCode(){
        
        let vc = EUShowQRCodeViewController()
        vc.activityName = viewmodel?.activitymodel.avTitle
        vc.qrString = viewmodel?.qrcodeString
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    /// 通知按钮
    @objc fileprivate func notifyParticipators(){
        
        if viewmodel?.isFinished ?? true{
            SwiftyProgressHUD.showFaildHUD(text: "活动已结束", duration: 1)
            return
        }
    
        let vc = EUActivityNotificationController()
        vc.avid = avid
        vc.avname = viewmodel?.activitymodel.avTitle ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 开始签到
    @objc fileprivate func startRegister(){
        
        if !(viewmodel?.needRegisterBool ?? false){
            SwiftyProgressHUD.showFaildHUD(text: "无需签到", duration: 1)
            return
        }
        
        if viewmodel?.isFinished ?? true{
            SwiftyProgressHUD.showFaildHUD(text: "活动已结束", duration: 1)
            return
        }
        
        guard let startime = Double(viewmodel?.activitymodel.avStarttime ?? ""),let avid = viewmodel?.activitymodel.avid else{
            return
        }
        
        /// 4位数字，说明已经发起签到
        if (viewmodel?.activitymodel.avRegister ?? 0) > 999{
            let vc = EURegisterInfoViewController()
            vc.participatorlist = self.participatorslist
            vc.code = viewmodel?.activitymodel.avRegister ?? 0
            vc.avid = avid
            vc.activityName = self.viewmodel?.activitymodel.avTitle ?? ""
            vc.activityviewmodel = viewmodel
            self.navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        /// 最大时间差（超过这个值显示天数）
        let MAXTIMEDIFFERENCE:TimeInterval = 172800
        
        /// 最小时间差（超过这个时间显示警告）
        let MINTIMEDIFFERENCE:TimeInterval = 21600
        
        let date = Date()
        
        let timedifference = -date.timeIntervalSince(Date(timeIntervalSince1970: startime/1000))
        
        var alertmessage:String = ""
        
        if timedifference < MINTIMEDIFFERENCE{
            alertmessage = "您确定要发起签到吗？"
        }else if timedifference < MAXTIMEDIFFERENCE{
            // 显示小时
            let days = lround(timedifference/3600)
            alertmessage = "距离活动开始还有\(days)小时，您确定要发起签到吗？"
        }else{
            // 显示天数
            let days = lround(timedifference/(3600*24))
            alertmessage = "距离活动开始还有\(days)天，您确定要发起签到吗？"
        }
        
        let alert = UIAlertController(title: nil, message: alertmessage, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let confirm = UIAlertAction(title: "确定", style: .default) { (_) in
            
            // 发起签到网络请求
            SwiftyProgressHUD.showLoadingHUD()
            EUNetworkManager.shared.startActivityRegist(avid: avid, completion: { (isSuccess, canStartRegister, code) in
                SwiftyProgressHUD.hide()
                guard let code = code,let intcode = Int(code) else{
                    return
                }
                
                if !isSuccess{
                    SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                    return
                }
                if !canStartRegister{
                    SwiftyProgressHUD.showFaildHUD(text: "没有权限", duration: 1)
                    return
                }
                
                // 弹窗提醒签到码
                let codealert = UIAlertController(title: nil, message: "本次活动的签到码为 \(intcode)", preferredStyle: .alert)
                let codealertAction = UIAlertAction(title: "确定", style: .default, handler: { (_) in
                    
                    // 发起签到成功跳到签到详情页
                    self.viewmodel?.activitymodel.avRegister = intcode
                    let vc = EURegisterInfoViewController()
                    vc.participatorlist = self.participatorslist
                    vc.code = intcode
                    vc.activityviewmodel = self.viewmodel
                    vc.avid = avid
                    vc.activityName = self.viewmodel?.activitymodel.avTitle ?? ""
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                })
                codealert.addAction(codealertAction)
                self.present(codealert, animated: true, completion: nil)
                
            })
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
        
    }
    
    /// 修改活动
    @objc fileprivate func changeActiity(){
        
        if viewmodel?.isFinished ?? true{
            SwiftyProgressHUD.showFaildHUD(text: "活动已结束", duration: 1)
            return
        }
        
        let vc = EUStartActivityViewController()
        vc.viewmodel = viewmodel
        vc.addPicBtn.setImage(backgroudImage.image, for: .normal)
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
