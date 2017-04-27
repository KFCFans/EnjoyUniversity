//
//  EUCommunityVerifyController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/27.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCommunityVerifyController: EUBaseViewController {

    let COMMUNITYVERIFYCELL = "COMMUNITYVERIFYCELL"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navitem.title = "待审核"
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
