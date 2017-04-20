//
//  EUCommunityContactController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/19.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCommunityContactController: EUBaseViewController {
    
    
    lazy var viewmodellist = UserInfoListViewModel()
    
    /// 社团 ID，从上层传入
    var cmid:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navitem.title = "内部通讯录"
        tableview.contentInset = UIEdgeInsetsMake(104, 0, 0, 0)
        
        // FIXME : - 全部年级中的年级应该是动态生成的
        let dropdownmenu = [["所有性别","男","女","保密"],
                            ["全部职位","社长","管理员","社员"],
                            ["全部年级","2017级","2016级","2015级","2014级"]]
        
        let dropdownmenuview = SwiftyDropdownMenu(orgin: CGPoint(x: 0, y: 64), array: dropdownmenu)
        view.insertSubview(dropdownmenuview, belowSubview: navbar)
    }
    
    /// 加载社团通讯录
    override func loadData() {
        viewmodellist.loadCommunityContactsInfoList(cmid: cmid) { (isSuccess, hasData) in
            self.refreshControl?.endRefreshing()
            if !isSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            if !hasData{
                // 显示空空如也
                return
            }
            self.tableview.reloadData()
        }
    }

}

// MARK: - 代理方法
extension EUCommunityContactController:SwiftyDropdownMenuDelegate{
    
    func swiftyDropdownMenu(_ swiftyDropdownMenu: SwiftyDropdownMenu, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewmodellist.communityContactsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EUCommunityMemberCell()
        cell.viewmodel = viewmodellist.communityContactsList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
