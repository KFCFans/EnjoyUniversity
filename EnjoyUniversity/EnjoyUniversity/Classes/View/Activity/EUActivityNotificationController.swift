//
//  EUActivityNotificationController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/11.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUActivityNotificationController: EUBaseViewController {
    
    var avid:Int = 0
    
    let notificationtextview = SwiftyTextView(frame: CGRect(x: 5, y: 74, width: UIScreen.main.bounds.width - 10, height: 180), textContainer: nil, placeholder: "填写活动通知")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.removeFromSuperview()
        
        view.backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        

        notificationtextview.font = UIFont.boldSystemFont(ofSize: 15)
        notificationtextview.becomeFirstResponder()
        view.addSubview(notificationtextview)
        
        navitem.title = "活动通知"
        let rightBtn = UIBarButtonItem(title: "发送", style: .plain, target: nil, action: #selector(sendActivityNotification))
        navitem.rightBarButtonItem = rightBtn
    }
    
    @objc fileprivate func sendActivityNotification(){
        
        guard let notificationText = notificationtextview.text else {
            return
        }
        
        SwiftyProgressHUD.showLoadingHUD()
        EUNetworkManager.shared.pushActivityNotificationByTag(avid: avid, alert: notificationText) { (netSuccess, pushSuccess) in
            SwiftyProgressHUD.hide()
            if !netSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            if !pushSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "推送失败", duration: 1)
                return
            }
            SwiftyProgressHUD.showSuccessHUD(duration: 1)
        }
    }

}
