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
    
    
    lazy var viewpagerlist = VPListViewModel()
    
    lazy var activitylist = ActivityListViewModel()
    
    // 上拉加载标记，防止重复刷新
    var isPullUp = false
    
    // 轮播图控件
    let viewpager = SwiftyViewPager(viewpagerHeight: 180.0)
    
    // 搜索栏
    let searchbar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 100, height: 30))
    
    // 底部刷新指示器
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
    // 底部说明文本
    let indicatorlabel = UILabel()


    // 活动 Cell Id
    let ACTIVITYCELL = "EUACTIVITYCELL"
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        navbar.subviews.first?.alpha = 0
        
        setupViewPager()
        
        setupTableView()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadData(){
        
        if viewpagerlist.imageArray.count == 0{
            // 加载轮播图
            viewpagerlist.loadViewPagers { (_) in
                
                self.viewpager.loadViewPager(imageArray: self.viewpagerlist.imageArray)
            }
        }
        
        activitylist.loadActivityList(isPullingUp: isPullUp) { (isSuccess,needReload) in
         
            self.refreshControl?.endRefreshing()
            if needReload {

                self.tableview.reloadData()
                self.isPullUp = false
            }
            
            if isSuccess && !needReload{
                self.isPullUp = false
                
                self.indicator.stopAnimating()
                self.indicatorlabel.isHidden = false
                
            }
            
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
        
        
        
    }
    
    func setupTableView(){
        
        // 表格视图的底部缩进
        tableview.contentInset = UIEdgeInsetsMake(0, 0, 40, 0)
        
        // 注册可重用 Cell
        tableview.register(UINib(nibName: "EUActivityCell", bundle: nil), forCellReuseIdentifier: ACTIVITYCELL)
        
        // 底部加载视图
        let loadmoreview = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        tableview.tableFooterView = loadmoreview
        
        // 设置指示器
        indicator.color = UIColor.darkGray
        indicator.center.x = loadmoreview.center.x
        indicator.center.y = loadmoreview.bounds.height / 2
        
        
        // 设置提醒文字
        indicatorlabel.text = "没有更多了"
        indicatorlabel.font = UIFont.boldSystemFont(ofSize: 12)
        indicatorlabel.sizeToFit()
        indicatorlabel.textColor = UIColor.lightGray
        indicatorlabel.center.x = loadmoreview.center.x
        indicatorlabel.center.y = 16
        indicatorlabel.isHidden = true
        loadmoreview.addSubview(indicatorlabel)
        
        loadmoreview.addSubview(indicator)
    }
    
    
    // 设置轮播图
    func setupViewPager(){
        
        
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let av = EUActivityViewController()
        av.viewmodel = activitylist.vmlist[indexPath.row]
        navigationController?.pushViewController(av, animated: true)
//        navigationController?.present(av, animated: true, completion: nil)
        
    }
    

    

    
    // 封装上拉刷新逻辑
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let  section = tableView.numberOfSections - 1
        let  maxrow = tableView.numberOfRows(inSection: section)
        let currentrow = indexPath.row
        
        // 数据条数非常少时，无需使用上拉加载更多
        if maxrow < EUREQUESTCOUNT {
            indicator.isHidden = true
            indicatorlabel.isHidden = false
            return
        }
        
        if (currentrow == maxrow - 1) && !isPullUp && activitylist.vmlist.count > 0 {
            isPullUp = true
            indicator.startAnimating()
            loadData()
        }
        
    }
    
    
}

// MARK: - 监听方法
extension EUHomeViewController{
    
    @objc fileprivate func didClickQRCodeScanner(){
        
        let scanner = EUQRScanViewController()
        navigationController?.pushViewController(scanner, animated: true)
        
    }
    
}
