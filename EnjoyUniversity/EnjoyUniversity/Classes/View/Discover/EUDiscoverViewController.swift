//
//  EUDiscoverViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/2/27.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUDiscoverViewController: EUBaseViewController {

    let COMMUNITYWALLCELLID = "COMMUNITYCELLID"
    
    lazy var communityListVM = CommunityListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadData()
        tableview.register(UINib(nibName: "EUCommunityWallCell", bundle: nil), forCellReuseIdentifier: COMMUNITYWALLCELLID)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    fileprivate func loadData(){
        communityListVM.loadCommunityList { (isSuccess) in
            // 处理刷新数据成功的逻辑，比如收回下拉刷新控件
            self.tableview.reloadData()
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
        tableview.contentInset = UIEdgeInsetsMake(navbar.bounds.height, 0, 0, 0)
        
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
        
        print(communityListVM.modelList[indexPath.row])
        return cell
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width * 0.618
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
