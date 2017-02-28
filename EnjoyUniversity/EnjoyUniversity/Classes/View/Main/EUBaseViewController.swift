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
    
    // 导航栏
    lazy var navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
    
    lazy var navitem = UINavigationItem()

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
        
        navbar.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        navbar.setBackgroundImage(UIImage(), for: .default)
        view.addSubview(navbar)
        
        // 设置 NavigationBar 标题颜色
        navbar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        // 设置 NavigationBar 按钮颜色
        navbar.tintColor = UIColor.white
        
        // 缩进 tableview ，防止被 navbar 遮挡
        tableview.contentInset = UIEdgeInsetsMake(navbar.bounds.height, 0, 0, 0)
        
        navbar.items = [navitem]
        
        setupNavItem()
        
    }

    func setupNavItem(){
    
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
