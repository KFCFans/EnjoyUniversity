//
//  EUMessageViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/2/27.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUMessageViewController: EUBaseViewController {
    
    let EUMESSAGECELL = "EUMESSAGECELL"

    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.register(UINib(nibName: "EUMessageCell", bundle: nil), forCellReuseIdentifier: EUMESSAGECELL)
        
        // 巧妙解决 tableview 下面多余的分割线
        tableview.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

// MARK: - UI 相关方法
extension EUMessageViewController{
    
    override func setupNavBar() {
        super.setupNavBar()
        
        navitem.title = "消息"
        
        // 缩进 tableview ，防止被 navbar 遮挡
        tableview.contentInset = UIEdgeInsetsMake(navbar.bounds.height, 0, 0, 0)
    }
    
}



// MARK: - 代理方法
extension EUMessageViewController{
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: EUMESSAGECELL) as! EUMessageCell
        return cell
        
    }
    
    
    
}
