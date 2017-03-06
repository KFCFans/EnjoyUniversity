//
//  EUHomeViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/2/27.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUHomeViewController: EUBaseViewController {

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
