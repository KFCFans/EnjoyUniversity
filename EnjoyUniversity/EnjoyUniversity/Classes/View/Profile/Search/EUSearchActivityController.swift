//
//  EUSearchActivityViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/24.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUSearchActivityController: EUBaseViewController,UISearchBarDelegate {

    lazy var listviewmodel = ActivityListViewModel()
    
    let SEARCHACTIVITYCELL = "SEARCHACTIVITYCELL"
    
    var keyword:String?
    
    var isPullup:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableview.register(UINib(nibName: "EUActivityCell", bundle: nil), forCellReuseIdentifier: SEARCHACTIVITYCELL)
        tableview.tableFooterView = UIView()
        
        let searchbar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 60, height: 30))
        searchbar.delegate = self
        searchbar.searchBarStyle = .minimal
        if keyword == nil{
            searchbar.placeholder = "搜索校园活动"
            searchbar.becomeFirstResponder()
        }else{
            searchbar.text = keyword
        }
        
        let titleview = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 60, height: 30))
        titleview.addSubview(searchbar)
        navitem.titleView = titleview
        
    }
    
    override func loadData() {
        guard let keyword = keyword else {
            return
        }
        refreshControl?.beginRefreshing()
        listviewmodel.loadSearchedActivity(keyword: keyword, isPullup: isPullup) { (isSuccess, hasData) in
            self.refreshControl?.endRefreshing()
            if !isSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            if !hasData{
                return
            }
            self.tableview.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listviewmodel.searchedlist.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: SEARCHACTIVITYCELL) as? EUActivityCell ?? EUActivityCell()
        cell.activityVM = listviewmodel.searchedlist[indexPath.row]
        return cell
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else {
            SwiftyProgressHUD.showBigFaildHUD(text: "请输入搜索内容", duration: 1)
            return
        }
        refreshControl?.beginRefreshing()
        listviewmodel.loadSearchedActivity(keyword: keyword, isPullup: false) { (isSuccess, hasData) in
            self.refreshControl?.endRefreshing()
            if !isSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            if !hasData{
                // 显示空空如也
            }
            self.tableview.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        let vc = EUActivityViewController()
        vc.viewmodel = listviewmodel.searchedlist[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
