//
//  EUCommunityNotifyController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/20.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCommunityNotifyController: EUBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.removeFromSuperview()
        navitem.title = "通知"
        let rightBtn = UIBarButtonItem(title: "发送", style: .plain, target: nil, action: #selector(sendCommunityNotification))
        navitem.rightBarButtonItem = rightBtn
        
        let notifyTextview = SwiftyTextView(frame: CGRect(x: 20, y: 20, width: UIScreen.main.bounds.width, height: 200), textContainer: nil, placeholder: "")
    }
    
    @objc fileprivate func sendCommunityNotification(){
        
        
    }

}
