//
//  EUSearchViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/2/28.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUSearchViewController: EUBaseViewController {
    
    // 搜索控制器
    var searchcontroller = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        searchcontroller.searchBar.placeholder = "Ohhhhhhhhh"
        searchcontroller.dimsBackgroundDuringPresentation = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}


// MARK: - UI 相关方法
extension EUSearchViewController{
    
    override func setupNavItem() {
                
        navitem.titleView = searchcontroller.searchBar
        
    }
    
}

// MARK: - 监听方法
extension EUSearchViewController{
    
    @objc fileprivate func goBack(){
        dismiss(animated: true, completion: nil)
    }
    
}
