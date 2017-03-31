//
//  EUHomeViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/2/27.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit
import Alamofire

class EUHomeViewController: EUBaseViewController {
    
    // 下拉刷新控件
    let refreshControl = EURefreshControl()
    
    lazy var viewpagerlist = VPListViewModel()
    
    lazy var activitylist = ActivityListViewModel()
    
    // 轮播图控件
    let viewpager = SwiftyViewPager(viewpagerHeight: 180.0)
    
    // 搜索栏
    let searchbar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 100, height: 30))

    // 活动 Cell Id
    let ACTIVITYCELL = "EUACTIVITYCELL"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navbar.subviews.first?.alpha = 0
        

        tableview.register(UINib(nibName: "EUActivityCell", bundle: nil), forCellReuseIdentifier: ACTIVITYCELL)
        
        loadData()
        
        setupViewPager()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func loadData(){
        
        
        if viewpagerlist.imageArray.count == 0{
            // 加载轮播图
            viewpagerlist.loadViewPagers { (_) in
                
                self.viewpager.loadViewPager(imageArray: self.viewpagerlist.imageArray)
                
            }
        }
        
        activitylist.loadActivityList { (isSuccess) in
         
            self.refreshControl.endRefreshing()
            self.tableview.reloadData()
            
        }
        
        
    }
    



}

// MARK: - UI 相关方法
extension EUHomeViewController{
    
    // 设置导航栏
    override func setupNavBar() {
        super.setupNavBar()
        
        // 导航栏左部扫描二维码按钮
        let leftbtn = UIBarButtonItem(image: #imageLiteral(resourceName: "nav_qrcode"), style: .plain, target: nil, action: #selector(didClickQRCodeScanner))
        navitem.leftBarButtonItem = leftbtn
        
        // 导航栏右部更多菜单按钮
        let rightbtn = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        navitem.rightBarButtonItem = rightbtn
        
        // 搜索框视图
        let searchbarview = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        searchbar.searchBarStyle = .minimal
        searchbar.barTintColor = UIColor.white
        searchbar.placeholder = "搜索活动、社团、人"
        
        searchbarview.addSubview(searchbar)
        navitem.titleView = searchbarview
        
        tableview.addSubview(refreshControl)
        refreshControl.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
    }
    
    // 设置轮播图
    func setupViewPager(){
        
        //        tableview.tableHeaderView = vp
        
        let headview = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 242.0))
        headview.addSubview(viewpager)
        
        let view2 = EUHomeHeadView(frame: CGRect(x: 0, y: 185, width: UIScreen.main.bounds.width, height: 50.0))
        headview.addSubview(view2)
        
        view2.giveNavigationController(navc: self.navigationController)
        
        self.tableview.tableHeaderView = headview
        
    }



}

// MARK: - 代理相关方法
extension EUHomeViewController{
    
    // 实现导航栏随着视图滑动而变化
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let barimg = self.navbar.subviews.first
        let offsetY = scrollView.contentOffset.y 
        if offsetY > 120 {
            
            navbar.isHidden = false
            barimg?.alpha = 1
        }
        else if offsetY < 0{
            navbar.isHidden = true
        }
        else{
            navbar.isHidden = false
            barimg?.alpha = offsetY / 120.0
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activitylist.vmlist.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: ACTIVITYCELL) as! EUActivityCell
        cell.activityVM = activitylist.vmlist[indexPath.row]
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 93.0
//    }
    
    
}

// MARK: - 监听方法
extension EUHomeViewController{
    
    @objc fileprivate func didClickQRCodeScanner(){
        
        let scanner = EUQRScanViewController()
        navigationController?.pushViewController(scanner, animated: true)
        
    }
    
}
