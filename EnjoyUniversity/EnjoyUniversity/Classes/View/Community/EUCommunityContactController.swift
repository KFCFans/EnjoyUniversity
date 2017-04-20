//
//  EUCommunityContactController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/19.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCommunityContactController: EUBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navitem.title = "内部通讯录"
        tableview.contentInset = UIEdgeInsetsMake(104, 0, 0, 0)
        
        // FIXME : - 全部年级中的年级应该是动态生成的
        let dropdownmenu = [["所有性别","男","女","保密"],
                            ["全部职位","社长","管理员","社员"],
                            ["全部年级","2017级","2016级","2015级","2014级"]]
        
        let dropdownmenuview = SwiftyDropdownMenu(orgin: CGPoint(x: 0, y: 64), array: dropdownmenu)
        view.insertSubview(dropdownmenuview, belowSubview: navbar)
    }
    

}

// MARK: - 代理方法
extension EUCommunityContactController:SwiftyDropdownMenuDelegate{
    
    func swiftyDropdownMenu(_ swiftyDropdownMenu: SwiftyDropdownMenu, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EUCommunityMemberCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
}
