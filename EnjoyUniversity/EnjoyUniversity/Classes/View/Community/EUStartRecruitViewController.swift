//
//  EUStartRecruitViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/21.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUStartRecruitViewController: EUBaseViewController {
    
    /// 输入公告视图
    let recruitTextView = SwiftyTextView(frame: CGRect(x: 0, y: 84, width: UIScreen.main.bounds.width, height: 200),
                                  textContainer: nil,
                                  placeholder: "请输入招新公告")
    
    /// 社团视图模型 （上层传入）
    var viewmodel:CommunityViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        navitem.title = "发布招新"
        tableview.removeFromSuperview()
        let rightBtn = UIBarButtonItem(title: "发布", style: .plain, target: nil, action: #selector(startRecruit))
        navitem.rightBarButtonItem = rightBtn
        
        view.backgroundColor = UIColor.init(red: 0.9, green: 0.9, blue: 0.9, alpha: 1)
        
        recruitTextView.font = UIFont.boldSystemFont(ofSize: 15)
        
        view.addSubview(recruitTextView)
    }
    
    @objc fileprivate func startRecruit(){
        
        guard let cmid = viewmodel?.communitymodel?.cmid else{
            return
        }
        
        let text = recruitTextView.text
        if text == nil || text!.characters.count == 0{
            SwiftyProgressHUD.showBigFaildHUD(text: "请填写招新公告", duration: 1)
            return
        }
        
        // 上传招新公告
        SwiftyProgressHUD.showLoadingHUD()
        EUNetworkManager.shared.changeCommunityAnnouncement(cmid: cmid, announcement: text!) { (isSuccess) in
            if !isSuccess{
                SwiftyProgressHUD.hide()
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            EUNetworkManager.shared.changeCommunityRecruitmentState(cmid: cmid, startRecruit: true, completion: { (isSuccess) in
                SwiftyProgressHUD.hide()
                if !isSuccess{
                    SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                    return
                }
                SwiftyProgressHUD.showSuccessHUD(duration: 1)
                self.viewmodel?.isRecruiting = true
                self.viewmodel?.communitymodel?.cmRecruit = 1
                _ = self.navigationController?.popViewController(animated: true)
            })
        }
    }

}
