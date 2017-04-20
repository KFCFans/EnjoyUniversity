//
//  EURecruitmentViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/20.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EURecruitmentViewController: EUBaseViewController {
    
    let functionArray = ["待审核","已笔试","已面试"]
    
    var viewmodel:CommunityViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

    
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableview.tableFooterView = UIView()
        navitem.title = "招新管理"
    }

    @objc fileprivate func changeRecruitStatus(switchcontrol:UISwitch){
    
        // 开启招新
        if switchcontrol.isOn == true{
            
        }else{
            // 结束招新
        }
    }
    

}

// MARK: - 代理相关方法
extension EURecruitmentViewController{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (viewmodel?.isRecruiting) ?? false ? 2 :1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return functionArray.count
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        if indexPath.section == 0 && indexPath.row == 0{
            cell.textLabel?.text = "开启招新"
            let switchControl = UISwitch()
            switchControl.addTarget(self, action: #selector(changeRecruitStatus(switchcontrol:)), for: .valueChanged)
            switchControl.center.y = cell.center.y
            switchControl.frame.origin.x = UIScreen.main.bounds.width - switchControl.frame.width - 20
            switchControl.isOn = viewmodel?.isRecruiting ?? false
            cell.addSubview(switchControl)
        }
        if indexPath.section == 1{
            cell.textLabel?.text = functionArray[indexPath.row]
            cell.accessoryType = .disclosureIndicator
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
}
