//
//  EUCommunityInfoViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/2.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCommunityInfoViewController: UIViewController {
    
    lazy var listviewmodel = CommunityAuthorityListViewModel()

    var viewmodel:CommunityViewModel?{
        
        didSet{
            titleLabel.text = viewmodel?.communitymodel?.cmName
            announcementHeight = viewmodel?.announcementHeight ?? 0
            announcementLabel.text = viewmodel?.communitymodel?.cmAnnouncement
            detailHeight = viewmodel?.detailHeight ?? 0
            detailLabel.text = viewmodel?.communitymodel?.cmDetail
            typeLabel.text = viewmodel?.communityAttr
            schoolLabel.text = viewmodel?.communitySchool
            //FIXME: 用此 uid 加载社长信息 & 缺少已加入的小伙伴
            bossLabel.text = "现任社长:\(viewmodel?.communitymodel?.cmBoss ?? 0)"
            
            logoImg.kf.setImage(with: URL(string: viewmodel?.communityLogoUrl ?? ""),
                                placeholder: UIImage(named: "eu_placeholder"),
                                options: [.transition(.fade(1))],
                                progressBlock: nil,
                                completionHandler: nil)
            backgroudImage.kf.setImage(with: URL(string: viewmodel?.communityBackgroundURL ?? ""),
                                       placeholder: UIImage(named: "wallbackground"),
                                       options: [.transition(.fade(1))],
                                       progressBlock: nil,
                                       completionHandler: nil)
            
        }
        
    }
    
    // 隐藏状态栏
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    // 背景图片
    var backgroudImage = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 180))
    
    // Logo 图片
    var logoImg = UIImageView()
    
    // 返回按钮
    var backBtn = UIButton()
    
    // 分享按钮
    var shareBtn = UIButton()
    
    // 收藏按钮
    var collectBtn = UIButton()
    
    // 社团名称文本
    var titleLabel = UILabel()
    
    // 社团公告
    var announcementLabel = UILabel()
    
    // 所属学院／学校
    var schoolLabel = UILabel()
    
    // 社团性质
    var typeLabel = UILabel()
    
    // 现任社长
    var bossLabel = UILabel()
    
    // 人数
    var numLabel = UILabel()
    
    // 活动简介
    let detailLabel = UILabel()
    
    // 社团简介文本高度
    var detailHeight:CGFloat = 0
    
    // 社团公告文本高度
    var announcementHeight:CGFloat = 0
    
    // 滑动视图
    var scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 60))

    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        setupCommonUI()
        setupNavUI()
        setupAnnouncementUI()
        setupCommunityInfoUI()
        setupCommunityDetailUI()
        setupCommunityQRCode()
        setupParticipateButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func loadData(){
        
        guard let cmid = viewmodel?.communitymodel?.cmid else {
            return
        }
        
        listviewmodel.loadCommunityMember(cmid: cmid) { (isSuccess) in
            
            if !isSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            self.numLabel.text = "小伙伴们:有\(self.listviewmodel.communitymemberlist.count)个小伙伴哦"
            
        }
        
    }
    

}

// MARK: - UI 相关方法
extension EUCommunityInfoViewController{
    
    fileprivate func setupCommonUI(){
        
        // 设置滚动视图
        view.addSubview(scrollView)
        // 使用 F2F2F2 配色
        scrollView.backgroundColor = UIColor.init(colorLiteralRed: 242.0/255.0, green: 242.0/255.0, blue: 242/255.0, alpha: 1)
        view.backgroundColor = UIColor.init(colorLiteralRed: 242.0/255.0, green: 242.0/255.0, blue: 242/255.0, alpha: 1)
        
        // 背景图(后面用 Kingfisher 加载)
        backgroudImage.clipsToBounds = true
        
        // 返回按钮
        let rightshadow = UIImageView(frame: CGRect(x: 20, y: 30, width: 30, height: 30))
        rightshadow.alpha = 0.7
        rightshadow.image = UIImage(named: "nav_background")
        view.addSubview(rightshadow)
        
        backBtn.setImage(UIImage(named: "nav_back"), for: .normal)
        backBtn.frame = CGRect(x: 3, y: 3, width: 24, height: 24)
        backBtn.isUserInteractionEnabled = true
        rightshadow.isUserInteractionEnabled = true
        backBtn.addTarget(nil, action: #selector(backButtonIsClicked), for: .touchUpInside)
        rightshadow.addSubview(backBtn)
        
        // Logo
        logoImg.frame = CGRect(x: (UIScreen.main.bounds.width - 50) / 2, y: 50, width: 50, height: 50)
        backgroudImage.addSubview(logoImg)
        
        // 标题
        titleLabel.frame = CGRect(x: 0, y: 110, width: UIScreen.main.bounds.width, height: 16)
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = UIColor.white
        
        
        scrollView.addSubview(backgroudImage)
        backgroudImage.addSubview(titleLabel)
        
    }
    
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
    
    fileprivate func setupAnnouncementUI(){
        
        let announcementView = UIView(frame: CGRect(x: 5, y: 190, width: scrollView.bounds.width - 10, height: 64 + announcementHeight))
        announcementView.backgroundColor = UIColor.white
        scrollView.addSubview(announcementView)
        
        let title = UILabel(frame: CGRect(x: 0, y: 0, width: announcementView.bounds.width, height: 44))
        title.text = "公告"
        title.font = UIFont.boldSystemFont(ofSize: 16)
        title.textAlignment = .center
        announcementView.addSubview(title)
        
        let shadow = UIView(frame: CGRect(x: 0, y: 44.1, width: announcementView.bounds.width, height: 0.2))
        shadow.backgroundColor = UIColor.lightGray
        announcementView.addSubview(shadow)
        
        announcementLabel.frame = CGRect(x: 15, y: 54, width: announcementView.bounds.width - 30, height: announcementHeight)
        announcementLabel.numberOfLines = 0
        announcementLabel.textColor = UIColor.lightGray
        announcementLabel.font = UIFont.boldSystemFont(ofSize: 13)
        announcementView.addSubview(announcementLabel)
        
    }
    
    fileprivate func setupCommunityInfoUI(){
        
        /// 设置滚动空间
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 594 + detailHeight + announcementHeight)
        
        /// 活动信息视图
        let communityinfoview = UIView(frame: CGRect(x: 5, y: 264 + announcementHeight, width: UIScreen.main.bounds.width - 10, height: 176))
        communityinfoview.backgroundColor = UIColor.white
        scrollView.addSubview(communityinfoview)
        
        // 所属学校
        let schoolimg = UIImageView(frame: CGRect(x: 12, y: 14, width: 16, height: 16))
        schoolimg.image = UIImage(named: "cm_school")
        communityinfoview.addSubview(schoolimg)
        
        schoolLabel.textColor = UIColor.darkGray
        schoolLabel.frame = CGRect(x: 40, y: 15, width: 200, height: 14)
        schoolLabel.font = UIFont.boldSystemFont(ofSize: 14)
        communityinfoview.addSubview(schoolLabel)
        
        // 社团性质
        let cmtypeimg = UIImageView(frame: CGRect(x: 12, y: 58, width: 16, height: 16))
        cmtypeimg.image = UIImage(named: "cm_type")
        communityinfoview.addSubview(cmtypeimg)
        
        typeLabel.textColor = UIColor.darkGray
        typeLabel.frame = CGRect(x: 40, y: 59, width: 200, height: 14)
        typeLabel.font = UIFont.boldSystemFont(ofSize: 14)
        communityinfoview.addSubview(typeLabel)
        
        // 社长
        let cmbossimg = UIImageView(frame: CGRect(x: 12, y: 102, width: 16, height: 16))
        cmbossimg.image = UIImage(named: "cm_boss")
        communityinfoview.addSubview(cmbossimg)
        
        bossLabel.textColor = UIColor.darkGray
        bossLabel.frame = CGRect(x: 40, y: 103, width: UIScreen.main.bounds.width, height: 14)
        bossLabel.font = UIFont.boldSystemFont(ofSize: 14)
        communityinfoview.addSubview(bossLabel)
        
        
        // 人数
        let numview = UIImageView(frame: CGRect(x: 0, y: 132, width: communityinfoview.frame.width, height: 44))
        communityinfoview.addSubview(numview)
        
        let avenrollimg = UIImageView(frame: CGRect(x: 12, y: 14, width: 16, height: 16))
        avenrollimg.image = UIImage(named: "cm_participate")
        numview.addSubview(avenrollimg)
        
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
    
    
    fileprivate func setupCommunityDetailUI(){
    
        // 活动详情视图
        let detailview = UIView(frame: CGRect(x: 5, y: 450 + announcementHeight, width: UIScreen.main.bounds.width - 10, height: 54 + detailHeight ))
        detailview.backgroundColor = UIColor.white
        scrollView.addSubview(detailview)
        
        let dtitle = UILabel(frame: CGRect(x: 15, y: 15, width: 100, height: 15))
        dtitle.textColor = UIColor.black
        dtitle.text = "社团详情"
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
    
    fileprivate func setupCommunityQRCode(){
        
        let qrcodeview = UIView(frame: CGRect(x: 5, y: 514 + announcementHeight + detailHeight, width: UIScreen.main.bounds.width - 10, height: 80))
        qrcodeview.backgroundColor = UIColor.white
        scrollView.addSubview(qrcodeview)
        
        let qrtitlelabel = UILabel(frame: CGRect(x: 15, y: 20, width: 150, height: 15))
        qrtitlelabel.text = "社团专属二维码"
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
    
    
    fileprivate func setupParticipateButton(){
        
        let changeButton = UIButton(frame: CGRect(x: 12, y: UIScreen.main.bounds.height - 50, width: UIScreen.main.bounds.width - 24, height: 44))
        changeButton.backgroundColor = UIColor.orange
        changeButton.setTitle("申请加入", for: .normal)
        changeButton.addTarget(nil, action: #selector(participateCommunity), for: .touchUpInside)
        view.addSubview(changeButton)
        
    }


    
    

    
}

// MARK: - 监听方法
extension EUCommunityInfoViewController{
    
    @objc fileprivate func backButtonIsClicked(){
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    // 获取参与者列表
    @objc fileprivate func showParticipators(){
        print("showDetail")
        
    }
    
    @objc fileprivate func shareButtonIsClicked(){
        
    }
    
    /// 收藏社团
    @objc fileprivate func collectButtonIsClicked(){
        
        guard let cmid = viewmodel?.communitymodel?.cmid else {
            return
        }
        SwiftyProgressHUD.showLoadingHUD()
        EUNetworkManager.shared.collectCommunity(cmid: cmid) { (netsuccess, collectsuccess) in
            SwiftyProgressHUD.hide()
            if !netsuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            if !collectsuccess{
                SwiftyProgressHUD.showWarnHUD(text: "您已收藏", duration: 1)
                return
            }
            SwiftyProgressHUD.showSuccessHUD(duration: 1)
        }
        
    }
    
    /// 显示二维码
    @objc fileprivate func showQRCode(){
        
        let vc = EUShowQRCodeViewController()
        vc.activityName = viewmodel?.communitymodel?.cmName
        vc.qrString = viewmodel?.qrcodeString
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 参加社团
    @objc fileprivate func participateCommunity(){
        
        guard let cmid = viewmodel?.communitymodel?.cmid, let cmname = viewmodel?.communitymodel?.cmName else {
            return
        }
        
        if !(viewmodel?.isRecruiting ?? false) {
            SwiftyProgressHUD.showFaildHUD(text: "未开启招新", duration: 1)
            return
        }
        
        let alert = SwiftyAlertController(title: "申请理由", message: "\n\n\n\n", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let confirm = UIAlertAction(title: "确定", style: .default) { (_) in
            
            let participatereason = alert.textview.text
            SwiftyProgressHUD.showLoadingHUD()
            EUNetworkManager.shared.participateCommunity(cmid: cmid, reason: participatereason, cmname: cmname,completion: { (isSuccess, joinedSuccess) in
                SwiftyProgressHUD.hide()
                if !isSuccess{
                    SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                    return
                }
                if !joinedSuccess{
                    SwiftyProgressHUD.showWarnHUD(text: "您已申请", duration: 1)
                    return
                }
                SwiftyProgressHUD.showSuccessHUD(duration: 1)
            })
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
        
    }
    
    
}
