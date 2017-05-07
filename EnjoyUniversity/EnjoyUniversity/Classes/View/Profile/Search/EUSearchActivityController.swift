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
    
    var isPullUp:Bool = false
    
    // 底部刷新指示器
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
    // 底部说明文本
    let indicatorlabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableview.register(UINib(nibName: "EUActivityCell", bundle: nil), forCellReuseIdentifier: SEARCHACTIVITYCELL)
        tableview.keyboardDismissMode = .onDrag
        tableview.tableFooterView = UIView()
        
        let searchbar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 60, height: 30))
        searchbar.searchBarStyle = .minimal
        searchbar.barTintColor = UIColor.white
        searchbar.tintColor = UIColor.white
        searchbar.delegate = self
        
        let titleview = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 60, height: 30))
        titleview.addSubview(searchbar)
        navitem.titleView = titleview

        
        let searchBarTextField = searchbar.subviews.first?.subviews.last as? UITextField
        searchBarTextField?.textColor = UIColor.white
        if keyword == nil{
            searchBarTextField?.attributedPlaceholder = NSAttributedString(string: "搜索校园活动", attributes: [NSForegroundColorAttributeName:UIColor.white])
            searchbar.becomeFirstResponder()
        }else{
            searchbar.text = keyword
        }
        
    }
    
    override func loadData() {
        guard let keyword = keyword else {
            return
        }
        refreshControl?.beginRefreshing()
        listviewmodel.loadSearchedActivity(keyword: keyword, isPullup: isPullUp) { (isSuccess, hasData) in
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
        self.keyword = keyword
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
        
        if (currentrow == maxrow - 1) && !isPullUp && listviewmodel.searchedlist.count > 0 {
            isPullUp = true
            indicator.startAnimating()
            loadData()
        }
    }
    
}
