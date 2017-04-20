//
//  EURecruitmentViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/20.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EURecruitmentViewController: EUBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        navitem.title = "招新管理"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}

// MARK: - 代理相关方法
extension EURecruitmentViewController{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
}
