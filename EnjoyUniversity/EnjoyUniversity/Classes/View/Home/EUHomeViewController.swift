//
//  EUHomeViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/2/27.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUHomeViewController: EUBaseViewController {
    
    // 搜索栏
    let searchbar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 100, height: 30))

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

// MARK: - UI 相关方法
extension EUHomeViewController{
    
    override func setupNavBar() {
        super.setupNavBar()
        
        let leftbtn = UIBarButtonItem(image: #imageLiteral(resourceName: "nav_qrcode"), style: .plain, target: nil, action: nil)
        navitem.leftBarButtonItem = leftbtn
        
        let rightbtn = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        navitem.rightBarButtonItem = rightbtn
        
        let v = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        searchbar.searchBarStyle = .minimal
        v.addSubview(searchbar)
        navitem.titleView = v
    
        
    }



}

// MARK: - 代理相关方法
extension EUHomeViewController{
    
    // 实现导航栏随着视图滑动而变化
    // 初值 －64 向下拉值变大
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let barimg = self.navbar.subviews.first
        let offsetY = scrollView.contentOffset.y + 64
        if offsetY > 120 {
            barimg?.alpha = 1
        }
        else if offsetY < 0{
            barimg?.alpha = 0
        }
        else{
            barimg?.alpha = offsetY / 120.0
        }
    }
    
}
