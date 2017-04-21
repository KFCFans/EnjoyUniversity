//
//  EUCommunityManageViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/21.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCommunityManageViewController: EUBaseViewController {
    
    let functionarray = [["社团信息"],
                         ["发布公告"],
                         ["设置管理员","移除社团成员"],
                         ["转交社团"]]
    let fuctionimgarray = [["cm_changecm"],
                           ["cm_announce"],
                           ["cm_manager","cm_remove"],
                           ["cm_givecm"]]

    override func viewDidLoad() {
        super.viewDidLoad()

        navitem.title = "管理社团"
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableview.tableFooterView = UIView()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return functionarray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return functionarray[section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = functionarray[indexPath.section][indexPath.row]
        cell.imageView?.image = UIImage(named: fuctionimgarray[indexPath.section][indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
    }
}
