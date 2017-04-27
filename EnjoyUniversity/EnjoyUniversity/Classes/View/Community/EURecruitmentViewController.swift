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
    
    /// 是否开启招新开关
    let switchControl = UISwitch()
    
    /// 记录职位（上层传入）
    var position = -1
    
    var viewmodel:CommunityViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

    
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableview.tableFooterView = UIView()
        navitem.title = "招新管理"
    }
    
    /// pop 回来的时候设置开关状态
    override func viewWillAppear(_ animated: Bool) {
        if let viewmodel = viewmodel{
            switchControl.isOn = viewmodel.isRecruiting
            tableview.reloadData()
        }
    }

    @objc fileprivate func changeRecruitStatus(switchcontrol:UISwitch){
        
        guard let cmid = viewmodel?.communitymodel?.cmid else {
            return
        }
        
        // 只有管理员或社长才能发起招新
        if position < 2{
            SwiftyProgressHUD.showFaildHUD(text: "没有权限", duration: 1)
            switchcontrol.isOn = viewmodel?.isRecruiting ?? false
            return
        }
    
        // 开启招新
        if switchcontrol.isOn == true{
            let vc = EUStartRecruitViewController()
            vc.viewmodel = viewmodel
            navigationController?.pushViewController(vc, animated: true)
        }else{
            // 结束招新
            SwiftyProgressHUD.showLoadingHUD()
            EUNetworkManager.shared.changeCommunityRecruitmentState(cmid: cmid, startRecruit: false, completion: { (isSuccess) in
                SwiftyProgressHUD.hide()
                if !isSuccess{
                    SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                    switchcontrol.isOn = true
                    return
                }
                SwiftyProgressHUD.showSuccessHUD(duration: 1)
                self.viewmodel?.isRecruiting = false
                self.viewmodel?.communitymodel?.cmRecruit = 0
                _ = self.navigationController?.popViewController(animated: true)
            })
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 && indexPath.row == 0{
            let vc = EUCommunityVerifyController()
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
