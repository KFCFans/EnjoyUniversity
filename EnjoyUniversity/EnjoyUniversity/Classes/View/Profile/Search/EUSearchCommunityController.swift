//
//  EUSearchCommunityController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/24.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUSearchCommunityController: EUBaseViewController,UISearchBarDelegate {
    
    lazy var listviewmodel = CommunityListViewModel()
    
    var keyword:String?
    
    var isPullUp:Bool = false
    
    var SEARCHCOMMUNITYCELL = "SEARCHCOMMUNITYCELL"
    
    // 底部刷新指示器
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
    
    // 底部说明文本
    let indicatorlabel = UILabel()


    override func viewDidLoad() {
        super.viewDidLoad()

        
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableview.tableFooterView = UIView()
        tableview.register(EUCommunityCollectionCell.self, forCellReuseIdentifier: SEARCHCOMMUNITYCELL)
        tableview.keyboardDismissMode = .onDrag
        
        let searchbar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 60, height: 30))
        searchbar.delegate = self
        searchbar.searchBarStyle = .minimal
        if keyword == nil{
            searchbar.placeholder = "搜索大学社团"
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
        listviewmodel.loadSearchedCommunity(keyword: keyword, isPullUp: isPullUp) { (isSuccess, hadData) in
            self.refreshControl?.endRefreshing()
            if !isSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            if !hadData{
                // 空空如也
            }
            self.tableview.reloadData()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listviewmodel.searchList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = (tableView.dequeueReusableCell(withIdentifier: SEARCHCOMMUNITYCELL) as? EUCommunityCollectionCell) ?? EUCommunityCollectionCell()
        cell.viewmodel = listviewmodel.searchList[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text else {
            SwiftyProgressHUD.showBigFaildHUD(text: "请输入搜索内容", duration: 1)
            return
        }
        self.keyword = keyword
        refreshControl?.beginRefreshing()
        listviewmodel.loadSearchedCommunity(keyword: keyword, isPullUp: false) { (isSuccess, hasData) in
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
        
        let vc = EUCommunityInfoViewController()
        vc.viewmodel = listviewmodel.searchList[indexPath.row]
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
        
        if (currentrow == maxrow - 1) && !isPullUp && listviewmodel.searchList.count > 0 {
            isPullUp = true
            indicator.startAnimating()
            loadData()
        }
    }



}
