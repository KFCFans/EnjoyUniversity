//
//  EUProfileViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/2/27.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUProfileViewController: EUBaseViewController {
    
    /// 昵称
    let nicknameLabel = UILabel()
    
    /// 节操值
    let reputationLabel = UILabel()

    /// 用户头像
    var logoimg = UIImageView()
    
    /// 认证
    let verifyimgview = UIImageView()
    
    var userinfoviewmodel:UserinfoViewModel?{
        
        didSet{
            nicknameLabel.text = userinfoviewmodel?.model?.name
            reputationLabel.text = userinfoviewmodel?.reputationString
            verifyimgview.image = userinfoviewmodel?.verifyImg
            let avatarurl = userinfoviewmodel?.headsculptureurl ?? ""
            logoimg.kf.setImage(with: URL(string: avatarurl),
                                placeholder: UIImage(named: "profile_templogo"),
                                options: [.transition(.fade(1))],
                                progressBlock: nil,
                                completionHandler: nil)
        }
        
    }
    
    
    let profile = [
        0:["身份认证"],
        1:["意见反馈","联系客服"],
        2:["分享我们"],
        3:["关于我们"],
        4:["给我们评分"]
    ]
    
    let profileimg = [
        0:["profile_verify"],
        1:["profile_response","profile_chatus"],
        2:["profile_share"],
        3:["profile_aboutus"],
        4:["profile_pf"]
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupHeadView()
        
    }
    
    override func loadData() {
        
        SwiftyProgressHUD.showLoadingHUD()
        EUNetworkManager.shared.getUserPrivateInfo { (isSuccess, userinfovm) in
            SwiftyProgressHUD.hide()
            if !isSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络错误", duration: 1)
                return
            }
            guard let userinfovm = userinfovm else{
                SwiftyProgressHUD.showFaildHUD(text: "无权限", duration: 1)
                return
            }
            
            self.userinfoviewmodel = userinfovm
        }
        
    }
    
}

// MARK: - UI 相关方法
extension EUProfileViewController{
    
    /// 取消父类的 NavigationBar
    override func setupNavBar() {
    }
    
    fileprivate func setupHeadView(){
        
        let headview = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 255))
    
        let backgroundview = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 180))
        backgroundview.isUserInteractionEnabled = true
        backgroundview.image = UIImage(named: "profile_temp")
        headview.addSubview(backgroundview)
        
        
        logoimg.layer.masksToBounds = true
        logoimg.layer.cornerRadius = 35
        backgroundview.addSubview(logoimg)
        backgroundview.addSubview(verifyimgview)
        
        // 区域按钮
        let userinfoButton  = UIButton(type: .custom)
        userinfoButton.addTarget(nil, action: #selector(changeUserInfo), for: .touchUpInside)
        backgroundview.addSubview(userinfoButton)
        
        nicknameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        nicknameLabel.textColor = UIColor.white
        nicknameLabel.sizeToFit()
        backgroundview.addSubview(nicknameLabel)
        
        reputationLabel.textColor = UIColor.white
        reputationLabel.font = UIFont.boldSystemFont(ofSize: 13)
        reputationLabel.sizeToFit()
        backgroundview.addSubview(reputationLabel)
        
        let settingbtn = UIButton()
        settingbtn.setImage(UIImage(named: "profile_setting"), for: .normal)
        settingbtn.addTarget(nil, action: #selector(didClickSystemSettings), for: .touchUpInside)
        backgroundview.addSubview(settingbtn)
        
        let moreimg = UIImageView()
        moreimg.image = UIImage(named: "profile_more")
        backgroundview.addSubview(moreimg)
        
        let buttonview = UIView(frame: CGRect(x: 0, y: 180, width: UIScreen.main.bounds.width, height: 75))
        buttonview.backgroundColor = UIColor.white
        headview.addSubview(buttonview)
        
        let line1 = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width/4, y: 15, width: 1, height: 45))
        line1.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        buttonview.addSubview(line1)
        let line2 = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width/2, y: 15, width: 1, height: 45))
        line2.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        buttonview.addSubview(line2)
        let line3 = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width/4*3, y: 15, width: 1, height: 45))
        line3.backgroundColor = UIColor.init(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        buttonview.addSubview(line3)
        
        let myactivityBtn = EUActivityButton(frame: CGRect(x: 0, y: 6, width: UIScreen.main.bounds.width/4, height: 75),
                                             image: UIImage(named: "profile_myactivity")!,
                                             text: "我的活动",
                                             shadowimage: UIImage(),
                                             font: 13,
                                             textcolor: UIColor.init(red: 92/255, green: 92/255, blue: 92/255, alpha: 1),
                                             imgwidth: 35,
                                             shadowimgwidth: 40)
        myactivityBtn.addTarget(nil, action: #selector(showMyActivities), for: .touchUpInside)
        buttonview.addSubview(myactivityBtn)
        
        let mycommunityBtn = EUActivityButton(frame: CGRect(x: UIScreen.main.bounds.width/4, y: 6, width: UIScreen.main.bounds.width/4, height: 75),
                                              image: UIImage(named: "profile_mycommunity")!,
                                              text: "我的社团",
                                              shadowimage: UIImage(),
                                              font: 13,
                                              textcolor: UIColor.init(red: 92/255, green: 92/255, blue: 92/255, alpha: 1),
                                              imgwidth: 35,
                                              shadowimgwidth: 40)
        mycommunityBtn.addTarget(nil, action: #selector(showMyCommunities), for: .touchUpInside)
        buttonview.addSubview(mycommunityBtn)
        
        let activitycollectBtn = EUActivityButton(frame: CGRect(x: UIScreen.main.bounds.width/2, y: 6, width: UIScreen.main.bounds.width/4, height: 75),
                                                  image: UIImage(named: "profile_activitycollect")!,
                                                  text: "活动收藏",
                                                  shadowimage: UIImage(),
                                                  font: 13,
                                                  textcolor: UIColor.init(red: 92/255, green: 92/255, blue: 92/255, alpha: 1),
                                                  imgwidth: 35,
                                                  shadowimgwidth: 40)
        activitycollectBtn.addTarget(nil, action: #selector(showMyActivityCollections), for: .touchUpInside)
        buttonview.addSubview(activitycollectBtn)
        
        let communitycollectBtn = EUActivityButton(frame: CGRect(x: UIScreen.main.bounds.width/4 * 3, y: 6, width: UIScreen.main.bounds.width/4, height: 75),
                                                   image: UIImage(named: "profile_communitycollect")!,
                                                   text: "社团收藏",
                                                   shadowimage: UIImage(),
                                                   font: 13,
                                                   textcolor: UIColor.init(red: 92/255, green: 92/255, blue: 92/255, alpha: 1),
                                                   imgwidth: 35,
                                                   shadowimgwidth: 40)
        communitycollectBtn.addTarget(nil, action: #selector(showMyCommunityCollections), for: .touchUpInside)
        buttonview.addSubview(communitycollectBtn)
        
        tableview.tableHeaderView = headview
        tableview.bounces = false
        tableview.sectionHeaderHeight = 10
        tableview.tableFooterView = UIView()
        
        
        
        logoimg.translatesAutoresizingMaskIntoConstraints = false
        nicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        reputationLabel.translatesAutoresizingMaskIntoConstraints = false
        settingbtn.translatesAutoresizingMaskIntoConstraints = false
        moreimg.translatesAutoresizingMaskIntoConstraints = false
        verifyimgview.translatesAutoresizingMaskIntoConstraints = false
        userinfoButton.translatesAutoresizingMaskIntoConstraints = false
        
        // 头像
        backgroundview.addConstraints([NSLayoutConstraint(item: logoimg,
                                                          attribute: .top,
                                                          relatedBy: .equal,
                                                          toItem: backgroundview,
                                                          attribute: .top,
                                                          multiplier: 1.0,
                                                          constant: 75),
                                       NSLayoutConstraint(item: logoimg,
                                                          attribute: .left,
                                                          relatedBy: .equal,
                                                          toItem: backgroundview,
                                                          attribute: .left,
                                                          multiplier: 1.0,
                                                          constant: 16)])
        logoimg.addConstraints([NSLayoutConstraint(item: logoimg,
                                                   attribute: .width,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: 1.0,
                                                   constant: 70),
                                NSLayoutConstraint(item: logoimg,
                                                   attribute: .height,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: 1.0,
                                                   constant: 70)])
        // 个人信息按钮
        backgroundview.addConstraints([NSLayoutConstraint(item: userinfoButton,
                                                          attribute: .top,
                                                          relatedBy: .equal,
                                                          toItem: logoimg,
                                                          attribute: .top,
                                                          multiplier: 1.0,
                                                          constant: 0),
                                       NSLayoutConstraint(item: userinfoButton,
                                                          attribute: .left,
                                                          relatedBy: .equal,
                                                          toItem: backgroundview,
                                                          attribute: .left,
                                                          multiplier: 1.0,
                                                          constant: 0)])
        backgroundview.addConstraints([NSLayoutConstraint(item: userinfoButton,
                                                         attribute: .width,
                                                         relatedBy: .equal,
                                                         toItem: nil,
                                                         attribute: .notAnAttribute,
                                                         multiplier: 1.0,
                                                         constant: UIScreen.main.bounds.width),
                                      NSLayoutConstraint(item: userinfoButton,
                                                         attribute: .height,
                                                         relatedBy: .equal,
                                                         toItem: logoimg,
                                                         attribute: .height,
                                                         multiplier: 1.0,
                                                         constant: 0)])
        // 昵称
        backgroundview.addConstraints([NSLayoutConstraint(item: nicknameLabel,
                                                          attribute: .centerY,
                                                          relatedBy: .equal,
                                                          toItem: logoimg,
                                                          attribute: .centerY,
                                                          multiplier: 1.0,
                                                          constant: -15),
                                       NSLayoutConstraint(item: nicknameLabel,
                                                          attribute: .left,
                                                          relatedBy: .equal,
                                                          toItem: logoimg,
                                                          attribute: .right,
                                                          multiplier: 1.0,
                                                          constant: 15)])
        // 认证图标
        backgroundview.addConstraints([NSLayoutConstraint(item: verifyimgview,
                                                          attribute: .centerY,
                                                          relatedBy: .equal,
                                                          toItem: nicknameLabel,
                                                          attribute: .centerY,
                                                          multiplier: 1.0,
                                                          constant: 0),
                                       NSLayoutConstraint(item: verifyimgview,
                                                          attribute: .left,
                                                          relatedBy: .equal,
                                                          toItem: nicknameLabel,
                                                          attribute: .right,
                                                          multiplier: 1.0,
                                                          constant: 10)])
        verifyimgview.addConstraints([NSLayoutConstraint(item: verifyimgview,
                                                             attribute: .width,
                                                             relatedBy: .equal,
                                                             toItem: nil,
                                                             attribute: .notAnAttribute,
                                                             multiplier: 1.0,
                                                             constant: 16),
                                          NSLayoutConstraint(item: verifyimgview,
                                                             attribute: .height,
                                                             relatedBy: .equal,
                                                             toItem: nil,
                                                             attribute: .notAnAttribute,
                                                             multiplier: 1.0,
                                                             constant: 16)])
        // 节操值
        backgroundview.addConstraints([NSLayoutConstraint(item: reputationLabel,
                                                          attribute: .centerY,
                                                          relatedBy: .equal,
                                                          toItem: logoimg,
                                                          attribute: .centerY,
                                                          multiplier: 1.0,
                                                          constant: 15),
                                       NSLayoutConstraint(item: reputationLabel,
                                                          attribute: .left,
                                                          relatedBy: .equal,
                                                          toItem: logoimg,
                                                          attribute: .right,
                                                          multiplier: 1.0,
                                                          constant: 15)])
        // 设置按钮
        backgroundview.addConstraints([NSLayoutConstraint(item: settingbtn,
                                                          attribute: .top,
                                                          relatedBy: .equal,
                                                          toItem: backgroundview,
                                                          attribute: .top,
                                                          multiplier: 1.0,
                                                          constant: 32),
                                       NSLayoutConstraint(item: settingbtn,
                                                          attribute: .right,
                                                          relatedBy: .equal,
                                                          toItem: backgroundview,
                                                          attribute: .right,
                                                          multiplier: 1.0,
                                                          constant: -14)])
        settingbtn.addConstraints([NSLayoutConstraint(item: settingbtn,
                                                      attribute: .width,
                                                      relatedBy: .equal,
                                                      toItem: nil,
                                                      attribute: .notAnAttribute,
                                                      multiplier: 1.0,
                                                      constant: 22),
                                   NSLayoutConstraint(item: settingbtn,
                                                      attribute: .height,
                                                      relatedBy: .equal,
                                                      toItem: nil,
                                                      attribute: .notAnAttribute,
                                                      multiplier: 1.0,
                                                      constant: 22)])
        // MORE
        backgroundview.addConstraints([NSLayoutConstraint(item: moreimg,
                                                          attribute: .centerY,
                                                          relatedBy: .equal,
                                                          toItem: logoimg,
                                                          attribute: .centerY,
                                                          multiplier: 1.0,
                                                          constant: 0),
                                       NSLayoutConstraint(item: moreimg,
                                                          attribute: .right,
                                                          relatedBy: .equal,
                                                          toItem: backgroundview,
                                                          attribute: .right,
                                                          multiplier: 1.0,
                                                          constant: -10)])
        moreimg.addConstraints([NSLayoutConstraint(item: moreimg,
                                                   attribute: .width,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: 1.0,
                                                   constant: 17),
                                NSLayoutConstraint(item: moreimg,
                                                   attribute: .height,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: 1.0,
                                                   constant: 17)])
        
    }
    

    
}


// MARK: - 代理方法
extension EUProfileViewController{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return profile.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return profile[section]?.count ?? 0
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var picname:String = ""
        var title = ""
        if indexPath.section == 1 {
            
            picname = profileimg[indexPath.section]?[indexPath.row] ?? ""
            title = profile[indexPath.section]?[indexPath.row] ?? ""
            
        }else{
            picname = profileimg[indexPath.section]?.first ?? ""
            title = profile[indexPath.section]?.first ?? ""
        }
        
        
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = title
        cell.imageView?.image = UIImage(named: picname)
        cell.accessoryType = .disclosureIndicator
        
        return cell
        
    }
    
    // 返回分割线
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "      "
    }
    
    // 监听响应
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableview, didSelectRowAt: indexPath)
        
        if indexPath.section == 0{
            self.navigationController?.pushViewController(EUVerifyViewController(), animated: true)
        }
        else if indexPath.section == 1  {
            if indexPath.row == 0{
                self.navigationController?.pushViewController(EUFeedBackViewController(), animated: true)
            }else{
                openQQToContactUs()
            }
        }else if indexPath.section == 3{
            navigationController?.pushViewController(EUAboutUsViewController(), animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
}

// MARK: - 监听方法
extension EUProfileViewController{
    
    @objc fileprivate func showMyActivities(){
        navigationController?.pushViewController(EUMyActivityViewController(), animated: true)
    }
    
    @objc fileprivate func showMyCommunities(){
        navigationController?.pushViewController(EUMyCommunityViewController(), animated: true)
    }
    
    @objc fileprivate func changeUserInfo(){
        let vc = EUChangeUserInfoController()
        vc.logoimg = self.logoimg.image
        vc.viewmodel = userinfoviewmodel
        navigationController?.pushViewController(vc, animated: true)
    }
    @objc fileprivate func didClickSystemSettings(){
        
        navigationController?.pushViewController(EUSystemSettingsController(), animated: true)
        
    }
    
    @objc fileprivate func showMyActivityCollections(){
        navigationController?.pushViewController(EUActivityCollectionController(), animated: true)
    }
    
    @objc fileprivate func showMyCommunityCollections(){
        navigationController?.pushViewController(EUCommunityCollectionController(), animated: true)
    }
}

// MARK: - 一些小方法
extension EUProfileViewController{
 
    /// 联系客服 (打开 QQ)
    fileprivate func openQQToContactUs(){
        
        let qq = "mqq://im/chat?chat_type=wpa&uin=\(customQQ)&version=1&src_type=web"
        guard let url = URL(string: qq) else{
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    
    
}
