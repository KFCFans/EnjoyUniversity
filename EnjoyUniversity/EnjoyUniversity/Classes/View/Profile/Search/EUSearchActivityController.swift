//
//  EUSearchActivityViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/24.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUSearchActivityController: EUBaseViewController {

    lazy var listviewmodel = ActivityListViewModel()
    
    let SEARCHACTIVITYCELL = "SEARCHACTIVITYCELL"
    
    var keyword:String?
    
    var isPullup:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableview.register(UINib(nibName: "EUActivityCell", bundle: nil), forCellReuseIdentifier: SEARCHACTIVITYCELL)
        
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
    
}
