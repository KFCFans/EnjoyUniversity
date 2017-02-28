//
//  EUBaseViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/2/27.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUBaseViewController: UIViewController {
    
    // 表格视图（每个子视图都要用到）
    lazy var tableview = UITableView(frame: UIScreen.main.bounds, style: .plain)
    
    // 导航栏（子视图不一定用到）
    var navbar:UINavigationBar?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    

}

// MARK: - UI 相关方法
extension EUBaseViewController{
    
    fileprivate func setupUI(){
        
        view.backgroundColor = UIColor.white
        
        // 预估行高
        tableview.rowHeight = UITableViewAutomaticDimension
        tableview.estimatedRowHeight = 240
        
        // tableview 的代理和数据源方法
        tableview.dataSource = self
        tableview.delegate = self
        
        // 滚动条
        tableview.showsVerticalScrollIndicator = false
        tableview.showsHorizontalScrollIndicator = false
        
        //关闭自动缩进来自定义tableview位置，使其完全显示
        automaticallyAdjustsScrollViewInsets = false
        
        view.addSubview(tableview)
        
        setupNavBar()

        
    }
    
    func setupNavBar(){
        
    }
    
}


// MARK: - 代理方法
extension EUBaseViewController:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
