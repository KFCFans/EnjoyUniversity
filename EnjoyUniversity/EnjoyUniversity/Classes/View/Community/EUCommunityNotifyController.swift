//
//  EUCommunityNotifyController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/20.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCommunityNotifyController: EUBaseViewController {
    
    /// 上层传入
    var cmid:Int = 0
    
    var cmname:String = ""
    
    /// 是否作为公告
    let announceSwitch = UISwitch()
    
    /// 是否开启短袖发送
    let smsSwitch = UISwitch()
    
    /// 通知输入框
    let notifyTextView = SwiftyTextView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200), textContainer: nil, placeholder: "赶紧发布社团通知吧")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableview.tableHeaderView = notifyTextView
        tableview.tableFooterView = UIView()
        
        notifyTextView.font = UIFont.boldSystemFont(ofSize: 15)
        
        navitem.title = "发送通知"
        let rightBtn = UIBarButtonItem(title: "选择联系人", style: .plain, target: nil, action: #selector(didClickChoseBtn))
        navitem.rightBarButtonItem = rightBtn
    }
    
    @objc private func didClickChoseBtn(){
        
        // 如果作为公告，直接修改公告
        guard let notification = notifyTextView.text else{
            SwiftyProgressHUD.showBigFaildHUD(text: "请输入通知", duration: 1)
            return
        }
        if notification.characters.count < 1{
            SwiftyProgressHUD.showBigFaildHUD(text: "请输入通知", duration: 1)
            return
        }
        
        if announceSwitch.isOn{
            SwiftyProgressHUD.showLoadingHUD()
            EUNetworkManager.shared.changeCommunityAnnouncement(cmid: cmid, announcement: notification) { (isSuccess) in
                
                SwiftyProgressHUD.hide()
                if !isSuccess{
                    SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                    return
                }
                SwiftyProgressHUD.showSuccessHUD(duration: 1)
                let vc = EUChoseContactsController()
                vc.shouleSendSms = self.smsSwitch.isOn
                vc.notifycationText = notification
                vc.cmid = self.cmid
                vc.cmname = self.cmname
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else{
            let vc = EUChoseContactsController()
            vc.shouleSendSms = smsSwitch.isOn
            vc.notifycationText = notification
            vc.cmid = cmid
            vc.cmname = cmname
            navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        announceSwitch.frame.origin = CGPoint(x: UIScreen.main.bounds.width - 12 - announceSwitch.frame.width, y: (cell.frame.height - announceSwitch.frame.height)/2)
        smsSwitch.frame.origin = CGPoint(x: UIScreen.main.bounds.width - 12 - smsSwitch.frame.width, y: (cell.frame.height - smsSwitch.frame.height)/2)
        switch indexPath.section {
        case 0:
            cell.textLabel?.text = "设为公告"
            cell.addSubview(announceSwitch)
        case 1:
            cell.textLabel?.text = "短信通知"
            cell.addSubview(smsSwitch)
        default:
            break
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

}
