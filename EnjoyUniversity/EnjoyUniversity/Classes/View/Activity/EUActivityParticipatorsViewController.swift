//
//  EUActivityParticipatorsViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/11.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUActivityParticipatorsViewController: EUBaseViewController {
    
    let ACTIVITYPARTICIPATORCELL = "ACTIVITYPARTICIPATORCELL"
    
    /// 参与者数据源
    var participatorslist:UserInfoListViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.register(EUActivityMemberCell.self, forCellReuseIdentifier: ACTIVITYPARTICIPATORCELL)
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        navitem.title = "审核"
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }

}

// MARK: - 代理相关方法
extension EUActivityParticipatorsViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return participatorslist?.activityParticipatorList.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: ACTIVITYPARTICIPATORCELL) as? EUActivityMemberCell
        cell?.userinfo = participatorslist?.activityParticipatorList[indexPath.row]
        return cell ?? UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
