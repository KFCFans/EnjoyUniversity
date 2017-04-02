//
//  EUCreatedActivityViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/1.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCreatedActivityViewController: EUBaseAvtivityViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavUI()
        setupFunctionUI()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()


    }
    
}

// MARK: - UI 相关方法
extension EUCreatedActivityViewController{
    
    fileprivate func setupNavUI(){
        
        view.backgroundColor  = UIColor.lightGray
        
        let rightshadow = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width - 50, y: 30, width: 30, height: 30))
        rightshadow.image = UIImage(named: "nav_background")
        rightshadow.alpha = 0.7
        view.addSubview(rightshadow)
        
        let moreactionBtn = UIButton(frame: CGRect(x: 3, y: 3, width: 24, height: 24))
        moreactionBtn.setImage(UIImage(named: "nav_point"), for: .normal)
        moreactionBtn.addTarget(nil, action: #selector(moreActionBtnIsClicked), for: .touchUpInside)
        rightshadow.addSubview(moreactionBtn)
        
    }
    
    fileprivate func setupFunctionUI(){
        
        let functionview = UIView(frame: CGRect(x: 5, y: 190, width: UIScreen.main.bounds.width - 10, height: 75))
        functionview.backgroundColor = UIColor.white
        scrollView.addSubview(functionview)
     
        let buttonWidth:CGFloat = 50
        let margin = (UIScreen.main.bounds.width - 4 * buttonWidth) / 5
        
        let checkBtn = EUActivityButton(frame: CGRect(x: margin, y: 8, width: buttonWidth, height: buttonWidth), image: UIImage(named: "av_check")!, text: "审核", shadowimage: UIImage(named: "av_shadow_orange")!)
        functionview.addSubview(checkBtn)
        
        let notifBtn = EUActivityButton(frame: CGRect(x: margin * 2 + buttonWidth, y: 8, width: buttonWidth, height: buttonWidth), image: UIImage(named: "av_notify")!, text: "通知", shadowimage: UIImage(named: "av_shadow_red")!)
        functionview.addSubview(notifBtn)
        
        let shareBtn = EUActivityButton(frame: CGRect(x: margin * 3 + buttonWidth * 2, y: 8, width: buttonWidth, height: buttonWidth), image: UIImage(named: "av_share")!, text: "分享", shadowimage: UIImage(named: "av_shadow_blue")!)
        functionview.addSubview(shareBtn)
        
        let registerBtn = EUActivityButton(frame: CGRect(x: margin * 4 + buttonWidth * 3, y: 8, width: buttonWidth, height: buttonWidth), image: UIImage(named: "av_register")!, text: "签到", shadowimage: UIImage(named: "av_shadow_purple")!)
        functionview.addSubview(registerBtn)
        
    }
    
    
    
}

// MARK: - 监听方法集合
extension EUCreatedActivityViewController{
    
    @objc fileprivate func moreActionBtnIsClicked(){
        
    }
    
    @objc fileprivate func checkBtnIsClicked(){
        print("zzzzz")
    }
    
}
