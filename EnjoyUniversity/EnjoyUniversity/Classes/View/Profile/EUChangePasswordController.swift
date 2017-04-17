//
//  EUChangePasswordController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/17.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUChangePasswordController: EUBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.removeFromSuperview()
        navitem.title = "更改密码"
        view.backgroundColor = UIColor.init(red: 243/255, green: 241/255, blue: 238/255, alpha: 1)
        
        let oldpassword = UITextField(frame: CGRect(x: 0, y: 15 + 64, width: UIScreen.main.bounds.width, height: 44))
        oldpassword.font = UIFont.boldSystemFont(ofSize: 16)
        oldpassword.leftViewMode = .always
        oldpassword.isSecureTextEntry = true
        oldpassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        oldpassword.backgroundColor = UIColor.white
        oldpassword.placeholder = "请输入原始密码"
        view.addSubview(oldpassword)
        
        let newpassword = UITextField(frame: CGRect(x: 0, y: 59 + 64, width: UIScreen.main.bounds.width, height: 44))
        newpassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        newpassword.font = UIFont.boldSystemFont(ofSize: 16)
        newpassword.leftViewMode = .always
        newpassword.isSecureTextEntry = true
        newpassword.backgroundColor = UIColor.white
        newpassword.placeholder = "请输入新密码"
        view.addSubview(newpassword)
        
        let againpassword = UITextField(frame: CGRect(x: 0, y: 103 + 64, width: UIScreen.main.bounds.width, height: 44))
        againpassword.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        againpassword.font = UIFont.boldSystemFont(ofSize: 16)
        againpassword.leftViewMode = .always
        againpassword.isSecureTextEntry = true
        againpassword.backgroundColor = UIColor.white
        againpassword.placeholder = "请确认密码"
        view.addSubview(againpassword)
        
        let saveBtn = UIButton(frame: CGRect(x: 20, y: 260, width: UIScreen.main.bounds.width - 40, height: 44))
        saveBtn.addTarget(nil, action: #selector(changePassword), for: .touchUpInside)
        saveBtn.setTitle("完成", for: .normal)
        saveBtn.backgroundColor = UIColor.init(red: 234/255, green: 85/255, blue: 4/255, alpha: 1)
        view.addSubview(saveBtn)
        
        
    }
    
    @objc private func changePassword(){
        
    }
}
