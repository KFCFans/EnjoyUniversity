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

    override func setupNavBar() {
        // NavigationBar
        navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
        guard let navbar = navbar else {
            return
        }
        navbar.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        navbar.setBackgroundImage(UIImage(), for: .default)
        view.addSubview(navbar)
        
        let navitem = UINavigationItem(title: "社团 Wall")
        navbar.items = [navitem]
        
        navbar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        // 缩进 tableview ，防止被 navbar 遮挡
        tableview.contentInset = UIEdgeInsetsMake(navbar.bounds.height, 0, 0, 0)
        
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
