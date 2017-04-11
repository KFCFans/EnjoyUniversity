//
//  EUActivityNotificationController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/11.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUActivityNotificationController: EUBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.removeFromSuperview()
        
        view.backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        
        let notificationtextview = SwiftyTextView(frame: CGRect(x: 5, y: 74, width: UIScreen.main.bounds.width - 10, height: 180), textContainer: nil, placeholder: "填写活动通知")
        notificationtextview.font = UIFont.boldSystemFont(ofSize: 15)
        notificationtextview.becomeFirstResponder()
        view.addSubview(notificationtextview)
        
        navitem.title = "活动通知"
        let rightBtn = UIBarButtonItem(title: "发送", style: .plain, target: nil, action: #selector(sendActivityNotification))
        navitem.rightBarButtonItem = rightBtn
    }
    
    @objc fileprivate func sendActivityNotification(){
        
        print("Notification")
        
    }

}
