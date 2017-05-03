//
//  EUMessageViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/2/27.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUMessageViewController: EUBaseViewController {
    
    let notificationName = ["活动通知","社团通知","系统通知"]
    let notificationPicName = ["notify_activity","notify_community","notify_system"]
    var notificationDetail = ["您没有活动通知","您没有社团通知","您没有系统通知"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 巧妙解决 tableview 下面多余的分割线
        tableview.tableFooterView = UIView()
    }
    
    override func loadData() {
        refreshControl?.beginRefreshing()
        EUNetworkManager.shared.getNotificationLite { (isSuccess, dict) in
            self.refreshControl?.endRefreshing()
            if !isSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            guard let dict = dict else{
                return
            }
            self.notificationDetail[0] = dict["activityNotification"] ?? "您没有活动通知"
            self.notificationDetail[1] = dict["communityNotification"] ?? "您没有社团通知"
            self.notificationDetail[2] = dict["systemNotification"] ?? "您没有系统通知"
            self.tableview.reloadData()
        }
    }

}

// MARK: - UI 相关方法
extension EUMessageViewController{
    
    override func setupNavBar() {
        super.setupNavBar()
        
        navitem.title = "消息"
        
        // 缩进 tableview ，防止被 navbar 遮挡
        tableview.contentInset = UIEdgeInsetsMake(navbar.bounds.height, 0, 0, 0)
    }
}



// MARK: - 代理方法
extension EUMessageViewController{
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = EUMessageCell(style: .default, reuseIdentifier: nil)
        cell.titleLabel.text = notificationName[indexPath.row]
        cell.iconimageView.image = UIImage(named: notificationPicName[indexPath.row])
        cell.detailLabel.text = notificationDetail[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        let vc = EUMessageDetailController()
        switch indexPath.row {
        case 0:
            vc.type = .ActivityNotification
        case 1:
            vc.type = .CommunityNotification
        case 2:
            vc.type = .SystemNotification
        default:
            return
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
