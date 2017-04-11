//
//  EUCreatedActivityViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/1.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCreatedActivityViewController: EUBaseAvtivityViewController {
    
    /// 参与者数据源
    lazy var participatorslist = UserInfoListViewModel()
    
    /// 记录活动 ID
    var avid:Int = 0
    
    /// 参与者数据加载完成标记
    var isFinished:Bool = false
    
    var viewmodel:ActivityViewModel?{
        didSet{
            titleLabel.text = viewmodel?.activitymodel.avTitle
            placeLabel.text = viewmodel?.activitymodel.avPlace
            priceLabel.text = viewmodel?.price
            timeLabel.text = viewmodel?.allTime
            detailLabel.text = viewmodel?.activitymodel.avDetail
            detailHeight = viewmodel?.detailHeight ?? 0
            avid = viewmodel?.activitymodel.avid ?? 0 
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
        
        loadData()
        setupNavUI()
        setupFunctionUI()
        setupQRCodeUI()
        setupChangeButton()

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
        view.addSubview(changeButton)
        
    }
    
    
    
}

// MARK: - 监听方法集合
extension EUCreatedActivityViewController{
    
    @objc fileprivate func moreActionBtnIsClicked(){
        
    }
    
    @objc fileprivate func checkBtnIsClicked(){
        
        if !isFinished{
            
            SwiftyProgressHUD.showFaildHUD(text: "列表加载中", duration: 1)
            return
            
        }
        
        let vc = EUActivityParticipatorsViewController()
        vc.participatorslist = participatorslist
        vc.avid = avid
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc fileprivate func showQRCode(){
        
        let vc = EUShowQRCodeViewController()
        vc.qrString = "TestZZZ"
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @objc fileprivate func notifyParticipators(){
    
        let vc = EUActivityNotificationController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
