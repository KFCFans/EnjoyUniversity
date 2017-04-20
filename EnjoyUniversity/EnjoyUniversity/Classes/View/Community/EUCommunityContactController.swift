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
    var tempviewmodellist:[UserinfoViewModel]?
    
    /// 社团 ID，从上层传入
    var cmid:Int = 0
    
    /// 记录选择器
    var sexIndex = 0
    var positonIndex = 0
    var gradeIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navitem.title = "内部通讯录"
        tableview.contentInset = UIEdgeInsetsMake(104, 0, 0, 0)
        
        // FIXME : - 全部年级中的年级应该是动态生成的
        let dropdownmenu = [["所有性别","男","女","保密"],
                            ["全部职位","社长","管理员","社员"],
                            ["全部年级","2017级","2016级","2015级","2014级"]]
        
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
                // 显示空空如也
                return
            }
            self.tempviewmodellist = self.viewmodellist.communityContactsList
            self.tableview.reloadData()
        }
    }

}

// MARK: - 代理方法
extension EUCommunityContactController:SwiftyDropdownMenuDelegate{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempviewmodellist?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EUCommunityMemberCell()
        cell.viewmodel = tempviewmodellist?[indexPath.row]
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
        
        // 清空原来的数据
        tempviewmodellist?.removeAll()
        // 筛选性别
        for viewmodel in viewmodellist.communityContactsList {
            
            if sexIndex == 0{
                tempviewmodellist = viewmodellist.communityContactsList
                break
            }
            
            if (sexIndex - 1) == (viewmodel.model?.gender ?? 0){
                tempviewmodellist?.append(viewmodel)
            }
            
        }
     
        tableview.reloadData()
    }
    
}
