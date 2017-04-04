//
//  EUMainViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/2/27.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUMainViewController: UITabBarController {
    
    // 子控制器数组
    let childvcArray = [
        ["clsName":"Home","title":"首页","imageName":"home"],
        ["clsName":"Discover","title":"发现","imageName":"discover"],
        ["":""],
        ["clsName":"Message","title":"消息","imageName":"message_center"],
        ["clsName":"Profile","title":"我的","imageName":"profile"]
        ]

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        setupChildViewController(vcarray: childvcArray)
        setupPlusButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

// MARK: - 初始化子控制器
extension EUMainViewController{
    
    /// 根据字典创建控制器
    fileprivate func createChiledViewController(dict:[String:String])->UIViewController{
        
        guard let clsName = dict["clsName"],
            let title = dict["title"],
            let imageName = dict["imageName"],
            let cls = NSClassFromString(Bundle.main.namespace+"." + "EU" + clsName + "ViewController") as? EUBaseViewController.Type
        else {
            return UIViewController()
        }
        
        let vc = cls.init()
        
        vc.title = title
        vc.tabBarItem.image = UIImage(named: "tabbar_" + imageName)
        vc.tabBarItem.selectedImage = UIImage(named: "tabbar_" + imageName + "_selected")?.withRenderingMode(.alwaysOriginal)
        vc.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.orange], for: .highlighted)
        vc.tabBarItem.setTitleTextAttributes([NSFontAttributeName:UIFont.systemFont(ofSize: 12)], for: .normal)
        
        let nav = EUNavigationController(rootViewController: vc)
        
        return nav
        

    }
    
    /// 根据字典数组创建子控制器数组
    fileprivate func setupChildViewController(vcarray:[[String:String]]){
        
        var vcs = [UIViewController]()
        for dict in vcarray{
            vcs.append(createChiledViewController(dict: dict))
        }
        viewControllers = vcs
        
    }
    
    fileprivate func setupPlusButton(){
        
        let btn = UIButton()
        btn.setImage(UIImage(named: "tabbar_plus"), for: .normal)
        
        let width = UIScreen.main.bounds.width / 5
        let height = tabBar.bounds.height
        btn.frame = CGRect(x: 2 * width, y: 0, width: width, height: height)
        
        btn.addTarget(self, action: #selector(plusButtonWasClicked), for: .touchUpInside)
        tabBar.addSubview(btn)
    }
    
    
}

// MARK: - 监听方法
extension EUMainViewController{
    
    /// PlusButton 监听
    @objc fileprivate func plusButtonWasClicked(){
     
        
        let v = EUPlusButtonView()
        
        
        v.showPlusButtonView { [weak v] (clsName) in
            
            guard let cls = NSClassFromString(Bundle.main.namespace + "." + clsName) as? UIViewController.Type else{
                v?.removeFromSuperview()
                return
            }
            
            let vc = cls.init()
            
            self.present(vc, animated: true, completion: {
                v?.removeFromSuperview()
            })
            
        }
    }
    
}
