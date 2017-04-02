//
//  EUDiscoverViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/2/27.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUDiscoverViewController: EUBaseViewController {
    
    // 上拉加载标记，防止重复刷新
    var isPullUp = false
    
    // 底部刷新指示器
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
    // 底部说明文本
    let indicatorlabel = UILabel()

    let COMMUNITYWALLCELLID = "COMMUNITYCELLID"
    
    
    lazy var communityListVM = CommunityListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupTableView()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func loadData(){
        
        refreshControl.beginRefreshing()
        
        communityListVM.loadCommunityList(isPullUp: true) { (isSuccess,needRefresh) in
            // 处理刷新数据成功的逻辑，比如收回下拉刷新控件
            self.refreshControl.endRefreshing()
            self.isPullUp = false
            
            if isSuccess && needRefresh{
                self.tableview.reloadData()
            }
            if isSuccess && !needRefresh{
                self.indicator.stopAnimating()
                self.indicatorlabel.isHidden = false
            }
            
        }
    }
    

}


// MARK: - UI 相关方法
extension EUDiscoverViewController{


    override func setupNavBar() {
        
        super.setupNavBar()
        navitem.title = "社团墙"
        let searchbtn = UIBarButtonItem(image: UIImage(named: "tabbar_search"), style: .plain, target: nil, action: #selector(shouldStartSearch))
        navitem.rightBarButtonItem = searchbtn
        
        // 缩进 tableview ，防止被 navbar 遮挡
        tableview.contentInset = UIEdgeInsetsMake(navbar.bounds.height, 0, 40, 0)
        
        
    }
    
    func setupTableView(){
        
        

        // 注册可重用 Cell
        tableview.register(UINib(nibName: "EUCommunityWallCell", bundle: nil), forCellReuseIdentifier: COMMUNITYWALLCELLID)

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

    
}



// MARK: - 重写父类代理方法
extension EUDiscoverViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communityListVM.modelList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: COMMUNITYWALLCELLID, for: indexPath) as! EUCommunityWallCell
        cell.communityModel = communityListVM.modelList[indexPath.row]
        
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width * 0.618
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = EUCommunityInfoViewController()
        vc.viewmodel = communityListVM.modelList[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // 封装上拉刷新逻辑
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let  section = tableView.numberOfSections - 1
        let  maxrow = tableView.numberOfRows(inSection: section)
        let currentrow = indexPath.row
        
        if maxrow < EUREQUESTCOUNT {
            indicator.isHidden = true
            indicatorlabel.isHidden = false
            return
        }
        
        // 只有当前数量大于请求条数才能加载更多（小于一次请求数说明数据条数很少，无需上拉加载更多）
        if (currentrow == maxrow - 1) && !isPullUp  {
            isPullUp = true
            indicator.startAnimating()
            loadData()
        }
        
    }
    
}

// MARK: - 监听方法
extension EUDiscoverViewController{
    
    @objc fileprivate func shouldStartSearch(){
//        present(EUSearchViewController(), animated: true, completion: nil)

        navigationController?.pushViewController(EUSearchViewController(), animated: true)
//        navigationController?.pushViewController(TestVC(), animated: true)
    }
    
}
