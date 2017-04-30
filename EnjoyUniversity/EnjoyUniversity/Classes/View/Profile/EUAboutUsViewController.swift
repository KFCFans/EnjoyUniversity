//
//  EUAboutUsViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/25.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUAboutUsViewController: EUBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navitem.title = "关于我们"
        tableview.removeFromSuperview()
        
        let logoImgView = UIImageView(frame: CGRect(x: (UIScreen.main.bounds.width - 140)/2, y: 130, width: 140, height: 140))
        logoImgView.image = UIImage(named: "profile_logo")
        view.addSubview(logoImgView)
        
        let websiteBtn = UIButton()
        websiteBtn.setTitle("www.euswag.com", for: .normal)
        websiteBtn.setTitleColor(UIColor.blue, for: .normal)
        websiteBtn.sizeToFit()
        
        websiteBtn.center.x = view.center.x
        websiteBtn.frame.origin.y = logoImgView.frame.maxY + 20
        websiteBtn.addTarget(nil, action: #selector(openOfficialSite), for: .touchUpInside)
        view.addSubview(websiteBtn)
    }
    
    @objc private func openOfficialSite(){
        
        guard let url = URL(string: "http://www.euswag.com") else{
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
}
