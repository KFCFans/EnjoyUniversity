//
//  EUVerifyViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/12.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUVerifyViewController: EUBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        tableview.removeFromSuperview()
        navitem.title = "身份认证"
        setupUI()
        
    }
    
    
    private func setupUI(){
        
        let warnlabel = UILabel(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: 24))
        warnlabel.text = "请您如实准确填写本人信息，否则驳回认证"
        warnlabel.textAlignment = .center
        warnlabel.textColor = UIColor.init(red: 1, green: 119/255, blue: 0, alpha: 1)
        view.addSubview(warnlabel)
        
        let nametextfield = UITextField(frame: CGRect(x: 0, y: 88, width: UIScreen.main.bounds.width, height: 54))
        nametextfield.backgroundColor = UIColor.white
        nametextfield.leftViewMode = .always
        nametextfield.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 10))
        nametextfield.placeholder = "姓名"
        nametextfield.font = UIFont.boldSystemFont(ofSize: 15)
        nametextfield.textColor = UIColor.init(red: 157/255, green: 157/255, blue: 157/255, alpha: 1)
        view.addSubview(nametextfield)
        
        let schoolnumber = UITextField(frame: CGRect(x: 0, y: 142 ,width: UIScreen.main.bounds.width, height: 54))
        schoolnumber.backgroundColor = UIColor.white
        schoolnumber.leftViewMode = .always
        schoolnumber.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 10))
        schoolnumber.placeholder = "学号"
        schoolnumber.keyboardType = .numberPad
        schoolnumber.font = UIFont.boldSystemFont(ofSize: 15)
        schoolnumber.textColor = UIColor.init(red: 157/255, green: 157/255, blue: 157/255, alpha: 1)
        view.addSubview(schoolnumber)
        
        let addphotoBtn = UIButton(frame: CGRect(x: 0, y: 196, width: UIScreen.main.bounds.width, height: 200))
        addphotoBtn.setImage(UIImage(named: "profile_addphoto"), for: .normal)
        view.addSubview(addphotoBtn)
        
    }

}
