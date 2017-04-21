//
//  EUCommunityMemberManageController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/21.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCommunityMemberManageController: EUBaseViewController {
    
    /// 社团 ID，上层传入
    var cmid:Int = 0
    
    /// 功能 0表示设置管理员 1表示移除管理员 2表示移除社员 3表示转交社团
    var choice:Int = -1
    
    /// 左滑操作
    var tableviewrowAction:UITableViewRowAction?
    
    lazy var userinfolistviewmodel = UserInfoListViewModel()
    
    var tempuserinfolist = [UserinfoViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initFunction()
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableview.tableFooterView = UIView()
    }
    
    override func loadData() {
        refreshControl?.beginRefreshing()
        userinfolistviewmodel.loadCommunityContactsInfoList(cmid: cmid) { (isSuccess, _) in
            self.refreshControl?.endRefreshing()
            if !isSuccess {
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            self.tempuserinfolist.removeAll()
            if self.choice == 0{
                for viewmodel in self.userinfolistviewmodel.communityContactsList {
                    if (viewmodel.model?.position ?? 0 ) == 1{
                        self.tempuserinfolist.append(viewmodel)
                    }
                }
            }else if self.choice == 1{
                for viewmodel in self.userinfolistviewmodel.communityContactsList {
                    if (viewmodel.model?.position ?? 0 ) == 2{
                        self.tempuserinfolist.append(viewmodel)
                    }
                }
            }else{
                self.userinfolistviewmodel.communityContactsList.removeFirst()
                self.tempuserinfolist = self.userinfolistviewmodel.communityContactsList
            }
            self.tableview.reloadData()
        }
    }
    
    private func initFunction(){
        
        
        if choice == 0{
            
            navitem.title = "设置管理员"
            tableviewrowAction = UITableViewRowAction(style: .default, title: "设为管理员", handler: { (_, indexpath) in
                
                let name = self.tempuserinfolist[indexpath.row].model?.name ?? ""
                let alert = UIAlertController(title: nil, message: "您确定要将\(name)设为社团管理员吗？", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                let confirm = UIAlertAction(title: "确定", style: .default, handler: { (_) in
                    
                    self.setCommunityManager(row: indexpath.row,position: 2)
                })
                alert.addAction(cancel)
                alert.addAction(confirm)
                self.present(alert, animated: true, completion: nil)
            })
            tableviewrowAction?.backgroundColor = UIColor.green
            
        }else if choice == 1{
            
            navitem.title = "移除管理员"
            tableviewrowAction = UITableViewRowAction(style: .destructive, title: "移除管理员", handler: { (_, indexpath) in
                
                let name = self.tempuserinfolist[indexpath.row].model?.name ?? ""
                let alert = UIAlertController(title: nil, message: "您确定移除管理员 \(name)吗？", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                let confirm = UIAlertAction(title: "确定", style: .destructive, handler: { (_) in
                    
                    self.setCommunityManager(row: indexpath.row,position: 1)
                })
                alert.addAction(cancel)
                alert.addAction(confirm)
                self.present(alert, animated: true, completion: nil)
            })
            
        }else if choice == 2{
            navitem.title = "移除社员"
            tableviewrowAction = UITableViewRowAction(style: .destructive, title: "移除", handler: { (_, indexpath) in
                let name = self.tempuserinfolist[indexpath.row].model?.name ?? ""
                let alert = UIAlertController(title: nil, message: "您确定要将\(name)移除社团吗？", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                let confirm = UIAlertAction(title: "移除", style: .destructive, handler: { (_) in
                    self.removeCommunityMember(row: indexpath.row)
                    
                })
                alert.addAction(cancel)
                alert.addAction(confirm)
                self.present(alert, animated: true, completion: nil)
            })
            
        }else if choice == 3{
            
            navitem.title = "转交社团"
            tableviewrowAction = UITableViewRowAction(style: .normal, title: "转交社团", handler: { (_, indexpath) in
                let name = self.tempuserinfolist[indexpath.row].model?.name ?? ""
                let alert = UIAlertController(title: nil, message: "您确定要将社团转交给\(name)？", preferredStyle: .alert)
                let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
                let confirm = UIAlertAction(title: "转交", style: .default, handler: { (_) in
                    
                    self.giveCommunityToOthers(row: indexpath.row)
                })
                alert.addAction(cancel)
                alert.addAction(confirm)
                self.present(alert, animated: true, completion: nil)
                
            })
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempuserinfolist.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EUCommunityMemberCell()
        cell.viewmodel = tempuserinfolist[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        return [tableviewrowAction ?? UITableViewRowAction()]
    }
    
    /// 网络方法
    /// 设置管理员
    private func setCommunityManager(row:Int,position:Int){
        
        guard let uid = tempuserinfolist[row].model?.uid else {
            return
        }
        
        SwiftyProgressHUD.showLoadingHUD()
        EUNetworkManager.shared.manageCommunity(cmid: cmid, uid: uid, position: position) { (isSuccess) in
            SwiftyProgressHUD.hide()
            if !isSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            self.tempuserinfolist.remove(at: row)
            self.tableview.reloadData()
            SwiftyProgressHUD.showSuccessHUD(duration: 1)
        }
    }
    /// 删除成员
    private func removeCommunityMember(row:Int){
        guard let uid = tempuserinfolist[row].model?.uid else {
            return
        }
        SwiftyProgressHUD.showLoadingHUD()
        EUNetworkManager.shared.leaveCommunity(cmid: cmid, uid: uid) { (netsuccess, leavesuccess) in
            SwiftyProgressHUD.hide()
            if !netsuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            if !leavesuccess{
                SwiftyProgressHUD.showWarnHUD(text: "已删除", duration: 1)
                return
            }
            self.tempuserinfolist.remove(at: row)
            self.tableview.reloadData()
            SwiftyProgressHUD.showSuccessHUD(duration: 1)
        }
    }
    /// 转交社团
    private func giveCommunityToOthers(row:Int){
        
        guard let newboss = tempuserinfolist[row].model?.uid else {
            return
        }
        SwiftyProgressHUD.showLoadingHUD()
        EUNetworkManager.shared.changeCommunityBoss(cmid: cmid, newboss: newboss) { (isSuccess, success) in
            SwiftyProgressHUD.hide()
            if !isSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            if !success{
                SwiftyProgressHUD.showFaildHUD(text: "异常", duration: 1)
                return
            }
            
            SwiftyProgressHUD.showSuccessHUD(duration: 1)
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
    

}
