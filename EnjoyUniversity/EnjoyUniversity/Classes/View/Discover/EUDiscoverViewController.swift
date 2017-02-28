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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableview.register(UINib(nibName: "EUCommunityWallCell", bundle: nil), forCellReuseIdentifier: COMMUNITYWALLCELLID)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


// MARK: - UI 相关方法
extension EUDiscoverViewController{


    override func setupNavItem() {
        
        navitem.title = "社团墙"
        let searchbtn = UIBarButtonItem(image: UIImage(named: "tabbar_search"), style: .plain, target: nil, action: #selector(shouldStartSearch))
        navitem.rightBarButtonItem = searchbtn
        
    }
    
}



// MARK: - 重写父类代理方法
extension EUDiscoverViewController{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: COMMUNITYWALLCELLID, for: indexPath) as! EUCommunityWallCell
        return cell
    }
    
    // FIXME: - 不知道如何修改自定义 Cell 的高度，只能采取此策略
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.width * 0.618
    }
    
}

// MARK: - 监听方法
extension EUDiscoverViewController{
    
    @objc fileprivate func shouldStartSearch(){
//        present(EUSearchViewController(), animated: true, completion: nil)

        navigationController?.pushViewController(TestVC(), animated: true)
    }
    
}
