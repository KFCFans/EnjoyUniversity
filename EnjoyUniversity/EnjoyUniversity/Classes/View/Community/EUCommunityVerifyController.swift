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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        switch communityApplyStatus {
        case 0:
            navitem.title = "待审核"
            break
        case 1:
            navitem.title = "已审核"
        case 2:
            navitem.title = "已笔试"
            break
        case 3:
            navitem.title = "已面试"
            break
        default:
            break
        }
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableview.register(EUCommunityVerifyCell.self, forCellReuseIdentifier: COMMUNITYVERIFYCELL)
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
        for viewmodel in listviewmodel.applecmMemberList {
            guard let position = viewmodel.model?.position else {
                continue
            }
            if (position + 3) == communityApplyStatus{
                tempviewmodellist.append(viewmodel)
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
        cell.viewmodel = tempviewmodellist[indexPath.row]
        return cell
    }

}
