//
//  EUMessageDetailController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/5/3.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit



class EUMessageDetailController: EUBaseViewController {
    
    enum MessageType {
        case ActivityNotification
        case CommunityNotification
        case SystemNotification
    }
    
    var type:MessageType = .ActivityNotification
    
    let MESSAGEDETAILCELL = "MESSAGEDETAILCELL"
    
    lazy var messagelistviewmodel = MessageListViewModel()
    
    lazy var tempviewmodellist = [MessageViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        switch type {
        case .ActivityNotification:
            navitem.title = "活动通知"
            break
        case .CommunityNotification:
            navitem.title = "社团通知"
            break
        case .SystemNotification:
            navitem.title = "系统通知"
            break
        }
        
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableview.register(EUMessageDetailCell.self, forCellReuseIdentifier: MESSAGEDETAILCELL)
        tableview.separatorStyle = .none
        tableview.tableFooterView = UIView()
        
    }
    
    override func loadData() {
        refreshControl?.beginRefreshing()
        switch type {
        case .ActivityNotification:
            messagelistviewmodel.loadActivityNotifications(completion: { (netSuccess, hasData) in
                self.refreshControl?.endRefreshing()
                if !netSuccess{
                    SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                    return
                }
                if !hasData{
                    // 暂时没有消息处理
                    return
                }
                self.tempviewmodellist = self.messagelistviewmodel.activityNotifications
                self.tableview.reloadData()
            })
            break
        case .CommunityNotification:
            messagelistviewmodel.loadCommunityNotifications(completion: { (netSuccess, hasData) in
                self.refreshControl?.endRefreshing()
                if !netSuccess{
                    SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                    return
                }
                if !hasData{
                    // 暂时没有消息处理
                    return
                }
                self.tempviewmodellist = self.messagelistviewmodel.communityNotifications
                self.tableview.reloadData()
            })
            break
        case .SystemNotification:
            messagelistviewmodel.loadSystemNotifications(completion: { (netSuccess, hasData) in
                self.refreshControl?.endRefreshing()
                if !netSuccess{
                    SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                    return
                }
                if !hasData{
                    // 暂时没有消息处理
                    return
                }
                self.tempviewmodellist = self.messagelistviewmodel.systemNotifications
                self.tableview.reloadData()
            })
        }
    }
    
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempviewmodellist.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = (tableView.dequeueReusableCell(withIdentifier: MESSAGEDETAILCELL) as? EUMessageDetailCell) ?? EUMessageDetailCell()
        cell.viewmodel = tempviewmodellist[indexPath.row]
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let detailHeight = tempviewmodellist[indexPath.row].messageHeight
        return detailHeight + 52
        
    }

}
