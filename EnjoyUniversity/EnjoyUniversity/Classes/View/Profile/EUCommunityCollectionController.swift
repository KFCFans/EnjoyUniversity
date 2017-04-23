//
//  EUCommunityCollectionController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/19.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCommunityCollectionController: EUBaseViewController {
    
    lazy var communitylistviewmodel = CommunityListViewModel()
    
    let COMMUNITYCOLLECTIONCELL = "COMMUNITYCOLLECTIONCELL"

    override func viewDidLoad() {
        super.viewDidLoad()

        navitem.title = "社团收藏"
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableview.register(EUCommunityCollectionCell.self, forCellReuseIdentifier: COMMUNITYCOLLECTIONCELL)
        tableview.tableFooterView = UIView()
    }
    
    override func loadData() {
        
        refreshControl?.beginRefreshing()
        communitylistviewmodel.loadMyCommunityCollection { (isSuccess, hasData) in
            self.refreshControl?.endRefreshing()
            if !isSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            if !hasData{
                // 暂无数据处理
                return
            }
            self.tableview.reloadData()
        }
        
    }

}

extension EUCommunityCollectionController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communitylistviewmodel.collectedlist.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: COMMUNITYCOLLECTIONCELL) as? EUCommunityCollectionCell) ?? EUCommunityCollectionCell(style: .default, reuseIdentifier: COMMUNITYCOLLECTIONCELL)
        cell.viewmodel = communitylistviewmodel.collectedlist[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "取消收藏"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let cmid = communitylistviewmodel.collectedlist[indexPath.row].communitymodel?.cmid else{
            return
        }
        SwiftyProgressHUD.showLoadingHUD()
        EUNetworkManager.shared.discollectCommunity(cmid: cmid) { (netsuccess, discollectsuccess) in
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
            self.communitylistviewmodel.collectedlist.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = EUCommunityInfoViewController()
        vc.viewmodel = communitylistviewmodel.collectedlist[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
