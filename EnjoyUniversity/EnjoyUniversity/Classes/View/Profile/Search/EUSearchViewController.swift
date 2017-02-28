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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}


// MARK: - UI 相关方法
extension EUSearchViewController{
    
//    override func setupNavItem() {
        
//        let backbtn = UIBarButtonItem(image: UIImage(named: "tabbar_back"), style: .plain, target: nil, action: #selector(goBack))
//        let navitem = UINavigationItem()
//        navbar.items = [navitem]
//        navitem.leftBarButtonItem = backbtn
//        
//        navitem.titleView = searchcontroller.searchBar
        
//    }
    
}

// MARK: - 监听方法
extension EUSearchViewController{
    
    @objc fileprivate func goBack(){
        dismiss(animated: true, completion: nil)
    }
    
}
