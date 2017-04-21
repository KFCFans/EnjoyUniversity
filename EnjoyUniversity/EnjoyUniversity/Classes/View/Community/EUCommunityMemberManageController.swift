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
    
    lazy var userinfolistviewmodel = UserInfoListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navitem.title = "移除社员"
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
    }
    
    override func loadData() {
        userinfolistviewmodel.loadCommunityMemberList(cmid: cmid) { (isSuccess, hasData) in
            
            if !isSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            self.tableview.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userinfolistviewmodel.communityMemberList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EUCommunityMemberCell()
        cell.viewmodel = userinfolistviewmodel.communityMemberList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
