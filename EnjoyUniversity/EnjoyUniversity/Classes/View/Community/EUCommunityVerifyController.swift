//
//  EUCommunityVerifyController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/27.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCommunityVerifyController: EUBaseViewController {
    
    lazy var listviewmodel = UserInfoListViewModel()
    
    lazy var tempviewmodellist = [UserinfoViewModel]()

    fileprivate let COMMUNITYVERIFYCELL = "COMMUNITYVERIFYCELL"
    
    /// 根据此状态确定控制器作用
    var communityApplyStatus:Int = 0
    
    /// 社团 ID
    var cmid:Int = 0
    
    /// 状态
    var selectStatus:Bool = false
    
    /// 只是记录按钮状态
    var isSelectAll:Bool = false
    
    var selectIndex = [Int]()
    
    var originalIndex = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        switch communityApplyStatus {
        case 0:
            navitem.title = "待审核"
            break
        case 1:
            navitem.title = "待笔试"
        case 2:
            navitem.title = "待面试"
            break
        default:
            break
        }
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableview.register(EUCommunityVerifyCell.self, forCellReuseIdentifier: COMMUNITYVERIFYCELL)
        tableview.tableFooterView = UIView()
        
        let rightBtn = UIBarButtonItem(title: "选择", style: .plain, target: self, action: #selector(didClickSelectButton))
        navitem.rightBarButtonItem = rightBtn
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if selectStatus{
            loadData()
        }
    }
    
    override func loadData() {
        
        refreshControl?.beginRefreshing()
        listviewmodel.loadApplyCommunityUserList(cmid: cmid) { (isSuccess, hasData) in
            self.refreshControl?.endRefreshing()
            if !isSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            if !hasData{
                // 暂无成员处理
            }
            self.choseData()
        }
        
    }
    
    private func choseData(){
        tempviewmodellist.removeAll()
        for (index,viewmodel) in listviewmodel.applycmMemberList.enumerated() {
            guard let position = viewmodel.model?.position else {
                continue
            }
            if (position + 3) == communityApplyStatus{
                tempviewmodellist.append(viewmodel)
                selectIndex.append(0)
                originalIndex.append(index)
            }
        }
        tableview.reloadData()
    }
    

}

// MARK: - 代理方法
extension EUCommunityVerifyController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempviewmodellist.count
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: COMMUNITYVERIFYCELL) as? EUCommunityVerifyCell) ?? EUCommunityVerifyCell()
        cell.selectionStyle = .none
        if  isSelectAll {
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        cell.viewmodel = tempviewmodellist[indexPath.row]
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !selectStatus{
            return
        }
        let cell = tableView.cellForRow(at: indexPath)
        if selectIndex[indexPath.row] == 1{
            cell?.accessoryType = .none
            selectIndex[indexPath.row] = 0
        }else{
            cell?.accessoryType = .checkmark
            selectIndex[indexPath.row] = 1
        }
    }
    
}

// MARK: - 监听方法
extension EUCommunityVerifyController{
    
    /// 选择／发送按钮
    @objc fileprivate func didClickSelectButton(btn:UIBarButtonItem){
        
        if !selectStatus{
        
            selectStatus = true
            btn.title = "下一步"
            let allselectBtn = UIBarButtonItem(title: "全选", style: .plain, target: nil, action: #selector(didClickSelectAllBtn(btn:)))
            navitem.rightBarButtonItems = [btn,allselectBtn]
            
        }else{
            
            var uids = ""
            for (index,_) in selectIndex.enumerated(){
                if selectIndex[index] == 1{
                    uids = uids + "\(tempviewmodellist[index].model?.uid ?? 0),"
                }
            }
            
            // 如果是待审核询问是否要进行笔试
            if communityApplyStatus == 0{
                
                let alert = UIAlertController(title: "是否需要进行笔试", message: nil, preferredStyle: .alert)
                let cancel = UIAlertAction(title: "否", style: .cancel, handler: { (_) in
                    let vc = EURecruitNotificationController()
                    vc.nextposition = self.communityApplyStatus - 1
                    vc.uids = uids
                    vc.cmid = self.cmid
                    self.navigationController?.pushViewController(vc, animated: true)
                })
                let confirm = UIAlertAction(title: "是", style: .default, handler: { (_) in
                    let vc = EURecruitNotificationController()
                    vc.nextposition = self.communityApplyStatus - 2
                    vc.uids = uids
                    vc.cmid = self.cmid
                    self.navigationController?.pushViewController(vc, animated: true)
                })
                alert.addAction(cancel)
                alert.addAction(confirm)
                present(alert, animated: true, completion: nil)
                
            }
            
            // 其他的直接跳转
            let vc = EURecruitNotificationController()
            vc.nextposition = communityApplyStatus - 2
            vc.uids = uids
            vc.cmid = cmid
            navigationController?.pushViewController(vc, animated: true)
            
            
        }
        
        
    }
    /// 全选／取消全选按钮
    @objc fileprivate func didClickSelectAllBtn(btn:UIBarButtonItem){
        
        var replace = 0
        if isSelectAll{
            isSelectAll = false
            btn.title = "全选"
        }else{
            isSelectAll = true
            btn.title = "清空"
            replace = 1
        }
        for (index,_) in selectIndex.enumerated(){
            selectIndex[index] = replace
        }
        
        tableview.reloadData()
    }
    
}
