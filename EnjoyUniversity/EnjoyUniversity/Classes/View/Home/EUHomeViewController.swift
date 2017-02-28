//
//  EUHomeViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/2/27.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUHomeViewController: EUBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

// MARK: - UI 相关方法
extension EUHomeViewController{


    override func setupNavBar() {
        // NavigationBar
        navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
        guard let navbar = navbar else {
            return
        }
        navbar.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        navbar.setBackgroundImage(UIImage(), for: .default)
        view.addSubview(navbar)

        // 缩进 tableview ，防止被 navbar 遮挡
        tableview.contentInset = UIEdgeInsetsMake(navbar.bounds.height, 0, 0, 0)

    }
    

}
