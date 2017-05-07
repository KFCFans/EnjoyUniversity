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
        tableview.backgroundColor = BACKGROUNDCOLOR
        
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
        cell.choice = type.hashValue
        switch type {
        case .ActivityNotification:
            cell.topshadowView.backgroundColor = UIColor.init(red: 254/255, green: 85/255, blue: 0, alpha: 1)
            break
        case .SystemNotification:
            cell.topshadowView.backgroundColor = UIColor.init(red: 96/255, green: 188/255, blue: 1, alpha: 1)
            break
        default:
            break
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let detailHeight = tempviewmodellist[indexPath.row].messageHeight
        return detailHeight + 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if type == .ActivityNotification{
            
            guard let avid = tempviewmodellist[indexPath.row].model?.avid else{
                return
            }
            
            SwiftyProgressHUD.showLoadingHUD()
            EUNetworkManager.shared.getActivityInfoByID(avid: avid, completion: { (isSuccess, viewmodel) in
                SwiftyProgressHUD.hide()
                if !isSuccess{
                    SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                    return
                }
                let vc = EUActivityViewController()
                vc.activityStatus = 1
                vc.viewmodel = viewmodel
                self.navigationController?.pushViewController(vc, animated: true)
            })
        }else if type == .CommunityNotification{
            guard let cmid = tempviewmodellist[indexPath.row].model?.cmid else{
                return
            }
            let vc = EUMyCommunityViewController()
            vc.outsidecmid = cmid
            self.navigationController?.pushViewController(vc, animated: true)
        }else{
            var url = "http://www.euswag.com"
            if let nexturl = tempviewmodellist[indexPath.row].model?.nexturl {
                url = nexturl
                return
            }
            
            // FIXME: - 显示网页,https 升级主页
            print(url)
            
        }
    }

}
