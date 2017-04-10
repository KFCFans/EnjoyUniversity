//
//  EUProfileViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/2/27.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUProfileViewController: EUBaseViewController {
    
    //FIXME: -判断服务器又无数据，若无数据或请求失败则使用本地数据
    let profile = [
        0:["我的社团","我的活动","我的收藏"],
        1:["系统设置","系统客服"],
        2:["关于我们","分享我们"]
    ]
    let PROFILECELL = "PROFILECELL"

    override func viewDidLoad() {
        super.viewDidLoad()
        setupHeadView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        backgroundview.image = UIImage(named: "profile_temp")
        headview.addSubview(backgroundview)
        
        let logoimg = UIImageView()
        logoimg.image = avatarImage(image: UIImage(named: "profile_dug"), size: CGSize(width: 35, height: 35), opaque: false, backColor: nil)
        backgroundview.addSubview(logoimg)
        
        let nicknameLabel = UILabel()
        nicknameLabel.text = "她是光芒"
        nicknameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        nicknameLabel.textColor = UIColor.white
        nicknameLabel.sizeToFit()
        backgroundview.addSubview(nicknameLabel)
        
        let reputationLabel = UILabel()
        reputationLabel.textColor = UIColor.white
        reputationLabel.text = "节操值 100"
        reputationLabel.font = UIFont.boldSystemFont(ofSize: 10)
        reputationLabel.sizeToFit()
        backgroundview.addSubview(reputationLabel)
        
        let settingbtn = UIButton()
        settingbtn.setImage(UIImage(named: "profile_setting"), for: .normal)
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
        buttonview.addSubview(myactivityBtn)
        
        let mycommunityBtn = EUActivityButton(frame: CGRect(x: UIScreen.main.bounds.width/4, y: 6, width: UIScreen.main.bounds.width/4, height: 75),
                                              image: UIImage(named: "profile_mycommunity")!,
                                              text: "我的社团",
                                              shadowimage: UIImage(),
                                              font: 13,
                                              textcolor: UIColor.init(red: 92/255, green: 92/255, blue: 92/255, alpha: 1),
                                              imgwidth: 35,
                                              shadowimgwidth: 40)
        buttonview.addSubview(mycommunityBtn)
        
        let activitycollectBtn = EUActivityButton(frame: CGRect(x: UIScreen.main.bounds.width/2, y: 6, width: UIScreen.main.bounds.width/4, height: 75),
                                                  image: UIImage(named: "profile_activitycollect")!,
                                                  text: "活动收藏",
                                                  shadowimage: UIImage(),
                                                  font: 13,
                                                  textcolor: UIColor.init(red: 92/255, green: 92/255, blue: 92/255, alpha: 1),
                                                  imgwidth: 35,
                                                  shadowimgwidth: 40)
        buttonview.addSubview(activitycollectBtn)
        
        let communitycollectBtn = EUActivityButton(frame: CGRect(x: UIScreen.main.bounds.width/4 * 3, y: 6, width: UIScreen.main.bounds.width/4, height: 75),
                                                   image: UIImage(named: "profile_communitycollect")!,
                                                   text: "社团收藏",
                                                   shadowimage: UIImage(),
                                                   font: 13,
                                                   textcolor: UIColor.init(red: 92/255, green: 92/255, blue: 92/255, alpha: 1),
                                                   imgwidth: 35,
                                                   shadowimgwidth: 40)
        buttonview.addSubview(communitycollectBtn)
        
        tableview.tableHeaderView = headview
        tableview.sectionHeaderHeight = 10
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: PROFILECELL)
        tableview.separatorStyle = .none
        
        
        
        logoimg.translatesAutoresizingMaskIntoConstraints = false
        nicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        reputationLabel.translatesAutoresizingMaskIntoConstraints = false
        settingbtn.translatesAutoresizingMaskIntoConstraints = false
        moreimg.translatesAutoresizingMaskIntoConstraints = false
        
        //头像
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
        // 昵称
        backgroundview.addConstraints([NSLayoutConstraint(item: nicknameLabel,
                                                          attribute: .centerY,
                                                          relatedBy: .equal,
                                                          toItem: logoimg,
                                                          attribute: .centerY,
                                                          multiplier: 1.0,
                                                          constant: -10),
                                       NSLayoutConstraint(item: nicknameLabel,
                                                          attribute: .left,
                                                          relatedBy: .equal,
                                                          toItem: logoimg,
                                                          attribute: .right,
                                                          multiplier: 1.0,
                                                          constant: 15)])
        // 节操值
        backgroundview.addConstraints([NSLayoutConstraint(item: reputationLabel,
                                                          attribute: .centerY,
                                                          relatedBy: .equal,
                                                          toItem: logoimg,
                                                          attribute: .centerY,
                                                          multiplier: 1.0,
                                                          constant: 10),
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
        
        guard let data = profile[indexPath.section],
            let cell = tableview.dequeueReusableCell(withIdentifier: PROFILECELL)   else{
            return UITableViewCell()
        }
        cell.textLabel?.text = data[indexPath.row]
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
    }
    
    
    
}
