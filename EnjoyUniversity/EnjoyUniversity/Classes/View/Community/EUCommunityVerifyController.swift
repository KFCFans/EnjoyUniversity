//
//  EUCommunityVerifyController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/27.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCommunityVerifyController: EUBaseViewController {

    fileprivate let COMMUNITYVERIFYCELL = "COMMUNITYVERIFYCELL"
    
    /// 根据此状态确定控制器作用
    var communityApplyStatus:Int = 0
    
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
    

}

// MARK: - 代理方法
extension EUCommunityVerifyController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 114
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: COMMUNITYVERIFYCELL) as? EUCommunityVerifyCell) ?? EUCommunityVerifyCell()
        return cell
    }

}
