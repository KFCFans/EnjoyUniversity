//
//  EUNavigationController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/2/27.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if childViewControllers.count>0 {
            viewController.hidesBottomBarWhenPushed = true
            if let vc = viewController as? EUBaseViewController{
                let backbtn = UIBarButtonItem(image: UIImage(named: "tabbar_back"), style: .plain, target: nil, action: #selector(popToParent))
                
                vc.navitem.leftBarButtonItem = backbtn
            }
        }
        super.pushViewController(viewController, animated: true)
    }
    
    /// POP 返回到上一级控制器
    @objc private func popToParent() {
        popViewController(animated: true)
    }

}
