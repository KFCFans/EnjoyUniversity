//
//  EUCommunityAnnounceController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/22.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCommunityAnnounceController: EUBaseViewController {

    let announceTextView = SwiftyTextView(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: 200), textContainer: nil, placeholder: "请输入社团公告")
    
    /// 上层传入的 社团ID
    var cmid:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navitem.title = "发布公告"
        tableview.removeFromSuperview()
        
        announceTextView.font = UIFont.boldSystemFont(ofSize: 15)
        announceTextView.textColor = TEXTVIEWCOLOR
        
        view.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        view.addSubview(announceTextView)
        
        let rightBtn = UIBarButtonItem(title: "发布", style: .plain, target: nil, action: #selector(commitAnnouncement))
        navitem.rightBarButtonItem = rightBtn
        
        announceTextView.becomeFirstResponder()
    }

    @objc private func commitAnnouncement(){
        
        guard let text = announceTextView.text else{
            
            SwiftyProgressHUD.showBigFaildHUD(text: "请输入公告", duration: 1)
            return
        }
        
        if text.characters.count < 1 {
            SwiftyProgressHUD.showBigFaildHUD(text: "请输入公告", duration: 1)
            return
        }
        
        SwiftyProgressHUD.showLoadingHUD()
        EUNetworkManager.shared.changeCommunityAnnouncement(cmid: cmid, announcement: text) { (isSuccess) in
            SwiftyProgressHUD.hide()
            
            if !isSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            SwiftyProgressHUD.showSuccessHUD(duration: 1)
            _ = self.navigationController?.popViewController(animated: true)
        }
        
    }

}
