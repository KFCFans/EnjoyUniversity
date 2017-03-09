//
//  EUSearchViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/2/28.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUSearchViewController: EUBaseViewController {
    

    let searchbar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 60, height: 30))

    override func viewDidLoad() {
        super.viewDidLoad()


        setupSearchBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}


// MARK: - UI 相关方法
extension EUSearchViewController{
    
    /// 设置导航栏
    override func setupNavBar() {
        
        super.setupNavBar()
        let v = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        v.addSubview(searchbar)
        navitem.titleView = v
        
    }
    
    /// 设置搜索栏
    fileprivate func setupSearchBar(){
        
        //FIXME: - 自定义 UISearchBar ，修改字体颜色
        searchbar.placeholder = "搜索                                                              "
        searchbar.searchBarStyle = .minimal
        searchbar.barTintColor = UIColor.white
        
        
    }
    
    
}

// MARK: - 监听方法
extension EUSearchViewController{
    
    
}
