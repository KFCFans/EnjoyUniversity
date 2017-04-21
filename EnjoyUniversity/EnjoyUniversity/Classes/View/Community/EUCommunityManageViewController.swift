//
//  EUCommunityManageViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/21.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCommunityManageViewController: EUBaseViewController {
    
    /// 社团 ID，上层传入
    var cmid:Int = 0
    
    /// 社团权力列表
    var communityauthoritylist:CommunityAuthorityListViewModel?
    var communityauthoritylistIndex:Int = 0
    
    let functionarray = [["社团信息"],
                         ["发布公告"],
                         ["设置管理员","取消管理员"],
                         ["移除社员"],
                         ["转交社团"]]
    let fuctionimgarray = [["cm_changecm"],
                           ["cm_announce"],
                           ["cm_manager","cm_removemanager"],
                           ["cm_manager"],
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
        if indexPath.section == 2 || indexPath.section == 3 || indexPath.section == 4{
            
            guard let position = communityauthoritylist?.communityauthoritylist[communityauthoritylistIndex].position else {
                return
            }
            if position != 3{
                SwiftyProgressHUD.showFaildHUD(text: "无权限", duration: 1)
                return
            }
            
            let vc = EUCommunityMemberManageController()
            vc.cmid = cmid
            
            switch indexPath.section {
            case 2:
                vc.choice = indexPath.row
                break
            case 3:
                vc.choice = 2
                break
            case 4:
                vc.choice = 3
                break
            default:
                break
            }
            
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
