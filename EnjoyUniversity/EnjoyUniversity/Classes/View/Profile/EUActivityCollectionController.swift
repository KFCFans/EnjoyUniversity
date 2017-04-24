//
//  EUActivityCollectionController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/18.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUActivityCollectionController: EUBaseViewController {
    
    /// cell ID
    let ACTIVITYCOLLECTIONCELL = "ACTIVITYCOLLECTIONCELL"
    
    lazy var viewmodellist = ActivityListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        navitem.title = "活动收藏"
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableview.register(UINib(nibName: "EUActivityCell", bundle: nil), forCellReuseIdentifier: ACTIVITYCOLLECTIONCELL)
        tableview.tableFooterView = UIView()
    }
    
    override func loadData() {
        
        refreshControl?.beginRefreshing()
        viewmodellist.loadMyCollectedActivity { (isSuccess, hasValue) in
        
            self.refreshControl?.endRefreshing()
            if !isSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            if !hasValue{
                // 没有数据,显示暂无数据
                return
            }
            self.tableview.reloadData()
        }
        
    }

}

// MARK: - 代理方法
extension EUActivityCollectionController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodellist.collectedlist.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableview.dequeueReusableCell(withIdentifier: ACTIVITYCOLLECTIONCELL) as? EUActivityCell) ?? EUActivityCell()
        cell.activityVM = viewmodellist.collectedlist[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        let vc = EUActivityViewController()
        vc.viewmodel = viewmodellist.collectedlist[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    /// 左滑删除
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /// 定义文字
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "取消收藏"
    }
    
    /// 取消收藏
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let avid = viewmodellist.collectedlist[indexPath.row].activitymodel.avid
        
        SwiftyProgressHUD.showLoadingHUD()
        EUNetworkManager.shared.discollectActivity(avid: avid) { (netsuccess, discollectsuccess) in
            SwiftyProgressHUD.hide()
            if !netsuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            if !discollectsuccess{
                SwiftyProgressHUD.showWarnHUD(text: "已取消收藏", duration: 1)
                return
            }
            SwiftyProgressHUD.showSuccessHUD(duration: 1)
            self.viewmodellist.collectedlist.remove(at: indexPath.row)
            self.tableview.reloadData()
        }
        
    }
    
}
