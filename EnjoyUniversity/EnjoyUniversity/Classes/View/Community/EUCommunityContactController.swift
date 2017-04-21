//
//  EUCommunityContactController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/19.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCommunityContactController: EUBaseViewController {
    
    
    lazy var viewmodellist = UserInfoListViewModel()
    
    /// 用于存放筛选后的数据
    var tempviewmodellist = [UserinfoViewModel]()
    
    /// 社团 ID，从上层传入
    var cmid:Int = 0
    
    /// 记录选择器
    var sexIndex = 0
    var positonIndex = 0
    var gradeIndex = 0
    
    /// 当前年份
    var currentYear:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navitem.title = "内部通讯录"
        tableview.contentInset = UIEdgeInsetsMake(104, 0, 0, 0)
        tableview.tableFooterView = UITableView()
        
        // 获取当前年份
        let currentdate = Date().timeIntervalSince1970 * 1000
        let currentyear = Int(timeStampToString(timeStamp: "\(currentdate)", formate: "YYYY") ?? "") ?? 0
        let gradearray = ["全部年级","\(currentyear) 级","\(currentyear-1) 级","\(currentyear-2) 级","\(currentyear-3) 级"]
        self.currentYear = currentyear
        
        let dropdownmenu = [["所有性别","男","女","保密"],
                            ["全部职位","社长","管理员","社员"],
                            gradearray]
        
        let dropdownmenuview = SwiftyDropdownMenu(orgin: CGPoint(x: 0, y: 64), array: dropdownmenu)
        dropdownmenuview.delegate = self
        view.insertSubview(dropdownmenuview, belowSubview: navbar)
        
    }
    
    /// 加载社团通讯录
    override func loadData() {
        viewmodellist.loadCommunityContactsInfoList(cmid: cmid) { (isSuccess, hasData) in
            self.refreshControl?.endRefreshing()
            if !isSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            if !hasData{
                // 理论上不可能没人（至少有社长，所有不需要做）
                return
            }
            self.filterContacts()
        }
    }
    
    func filterContacts(){
        // 清空原来的数据
        tempviewmodellist.removeAll()
        // 筛选性别
        for viewmodel in viewmodellist.communityContactsList {
            
            if sexIndex == 0{
                tempviewmodellist = viewmodellist.communityContactsList
                break
            }
            
            if (sexIndex - 1) == (viewmodel.model?.gender ?? 0){
                tempviewmodellist.append(viewmodel)
            }
        }
        // 筛选职位
        var temp = [UserinfoViewModel]()
        for viewmodel in tempviewmodellist{
            
            if positonIndex == 0{
                temp = tempviewmodellist
                break
            }
            if (4 - positonIndex) == (viewmodel.model?.position ?? 0){
                temp.append(viewmodel)
            }
        }
        self.tempviewmodellist = temp
        // 筛选年级
        temp.removeAll()
        for viewmodel in tempviewmodellist{
            if gradeIndex == 0{
                temp = tempviewmodellist
                break
            }
            if (currentYear - gradeIndex + 1) == (viewmodel.model?.grade ?? 0) {
                temp.append(viewmodel)
            }
        }
        self.tempviewmodellist = temp
        tableview.reloadData()
    }

}

// MARK: - 代理方法
extension EUCommunityContactController:SwiftyDropdownMenuDelegate{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempviewmodellist.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EUCommunityContactCell()
        cell.viewmodel = tempviewmodellist[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    /// 下拉选择
    func swiftyDropdownMenu(_ swiftyDropdownMenu: SwiftyDropdownMenu, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            sexIndex = indexPath.row
            break
        case 1:
            positonIndex = indexPath.row
            break
        case 2:
            gradeIndex = indexPath.row
            break
        default:
            break
        }
        filterContacts()
    }
    
}
