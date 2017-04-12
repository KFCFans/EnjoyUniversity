//
//  EUFeedBackViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/12.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUFeedBackViewController: EUBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.init(red: 252/255, green: 252/255, blue: 252/255, alpha: 1)
        tableview.removeFromSuperview()
        navitem.title = "意见反馈"
        
        
        let rightBtn = UIBarButtonItem(title: "提交", style: .plain, target: nil, action: #selector(feedbackProblem))
        navitem.rightBarButtonItem = rightBtn
        
        
        let problemtextview = UITextView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 131), textContainer: nil)
        problemtextview.backgroundColor = UIColor.white
        problemtextview.font = UIFont.boldSystemFont(ofSize: 15)
        problemtextview.textColor = UIColor.init(red: 182/255, green: 182/255, blue: 182/255, alpha: 1)
        view.addSubview(problemtextview)
        
        let addresslabel = UILabel(frame: CGRect(x: 16, y: 260, width: 400, height: 13))
        addresslabel.text = "请留下联系方式方便我们与您取得联系"
        addresslabel.font = UIFont.boldSystemFont(ofSize: 13)
        addresslabel.textColor = UIColor.init(red: 109/255, green: 109/255, blue: 114/255, alpha: 1)
        view.addSubview(addresslabel)
        
        let addresstextfield = UITextField(frame: CGRect(x: 0, y: 280, width: UIScreen.main.bounds.width, height: 44))
        addresstextfield.backgroundColor = UIColor.white
        addresstextfield.placeholder = "手机号/QQ/邮箱..."
        addresstextfield.textColor = UIColor.init(red: 182/255, green: 182/255, blue: 182/255, alpha: 1)
        addresstextfield.font = UIFont.boldSystemFont(ofSize: 13)
        addresstextfield.leftViewMode = .always
        addresstextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 13, height: 0))
        view.addSubview(addresstextfield)
        
    }


    
    @objc fileprivate func feedbackProblem(){
        
    }
}
