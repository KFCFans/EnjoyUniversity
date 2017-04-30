//
//  EURecruitNotificationController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/28.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EURecruitNotificationController: EUBaseViewController {
    
    /// 上层传入
    var cmid:Int = 0
    
    /// 下一级 －2笔试 －1面试 1加入成功 －10拒绝
    var nextposition = -3{
        didSet{
            if nextposition == 0{
                nextposition = 1
            }
        }
    }
    
    /// 联系人列表,上层传入
    var uids:String?
    
    /// 是否开启短袖发送
    let smsSwitch = UISwitch()
    
    /// 是否晋级开关
    let nextSwitch = UISwitch()
    
    
    /// 通知输入框
    let notifyTextView = SwiftyTextView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200), textContainer: nil, placeholder: "赶紧发布通知吧")

    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableview.tableHeaderView = notifyTextView
        tableview.tableFooterView = UIView()
        
        notifyTextView.font = UIFont.boldSystemFont(ofSize: 15)
        navitem.title = "发送通知"
        
        let rightBtn = UIBarButtonItem(title: "发送通知", style: .plain, target: nil, action: #selector(sendNotification))
        navitem.rightBarButtonItem = rightBtn
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        smsSwitch.frame.origin = CGPoint(x: UIScreen.main.bounds.width - 12 - smsSwitch.frame.width, y: (cell.frame.height - smsSwitch.frame.height)/2)
        nextSwitch.frame.origin = CGPoint(x: UIScreen.main.bounds.width - 12 - nextSwitch.frame.width, y: (cell.frame.height - nextSwitch.frame.height)/2)
        smsSwitch.isOn = true
        nextSwitch.isOn = true

        if indexPath.section == 1{
            switch nextposition {
            case 1:
                cell.textLabel?.text = "通过面试"
                break
            case -1:
                cell.textLabel?.text = "通过笔试"
                break
            case -2:
                cell.textLabel?.text = "通过审核"
                break
            default:
                break
            }
            cell.addSubview(nextSwitch)
        }else{
            cell.textLabel?.text = "短信通知"
            cell.addSubview(smsSwitch)
        }
        return cell
    }
    
    @objc private func sendNotification(){
        
        guard let uids = uids,let notificationtext = notifyTextView.text else {
            return
        }
        
        if !nextSwitch.isOn{
            nextposition = -10
        }
        SwiftyProgressHUD.showLoadingHUD()
        EUNetworkManager.shared.verifyCommunityApplyUserList(uids: uids, cmid: cmid, position: nextposition) { (netSuccess, updateSuccess) in
            
            if !netSuccess{
                SwiftyProgressHUD.hide()
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            if !updateSuccess{
                SwiftyProgressHUD.hide()
                SwiftyProgressHUD.showFaildHUD(text: "操作失败", duration: 1)
                return
            }
            // 发送推送
            EUNetworkManager.shared.pushNotificationByAlias(alias: uids, alert: notificationtext, completion: { (netSuccess, pushSuccess) in
                SwiftyProgressHUD.hide()
                if !netSuccess{
                    SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                    return
                }
                if pushSuccess{
                    SwiftyProgressHUD.showFaildHUD(text: "推送失败", duration: 1)
                    return
                }
                SwiftyProgressHUD.showSuccessHUD(duration: 1)
                _ = self.navigationController?.popViewController(animated: true)
            })
            // FIXME: - 短信发送
        }
        
    }
}
