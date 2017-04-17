//
//  EUChangeUserInfoController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/17.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUChangeUserInfoController: EUBaseViewController {
    
    
    let userinfotitle = ["头像","昵称","性别","姓名","学号","专业","个人简介"]
    let securitytitle = ["校友认证","修改密码","更改手机号"]
    
    /// 视图模型数据源
    var viewmodel:UserinfoViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        navitem.title = "个人信息"
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
    }

}

// MARK: - 代理方法
extension EUChangeUserInfoController{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? userinfotitle.count : securitytitle.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        indexPath.section == 0 ? (cell.textLabel?.text = userinfotitle[indexPath.row]) : (cell.textLabel?.text = securitytitle[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        
        if indexPath.section == 0 && indexPath.row == 0{
            
            let logoimg = UIImageView(frame: CGRect(x: 280, y: 10, width: 50, height: 50))
            cell.addSubview(logoimg)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 && indexPath.section == 0{
            return 70
        }
        return 44
    }
    
    
    
}
