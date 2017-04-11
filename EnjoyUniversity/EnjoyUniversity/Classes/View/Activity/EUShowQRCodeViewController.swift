//
//  EUShowQRCodeViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/11.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUShowQRCodeViewController: EUBaseViewController {
    
    var qrString:String? = "www.euswag.com"
    
    var qrImageName:String?
    
    var activityName:String? = "活动标题"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.removeFromSuperview()
        navitem.title = "活动二维码"
        view.backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        setupQRCodeUI()
    }

}

// MARK: - UI 相关方法
extension EUShowQRCodeViewController{
    
    fileprivate func setupQRCodeUI(){
        
        let backgroundview = UIView(frame: CGRect(x: 20, y: 100, width: UIScreen.main.bounds.width - 40, height: 450))
        backgroundview.backgroundColor = UIColor.white
        view.addSubview(backgroundview)
        
        let imgview = UIImageView(frame: CGRect(x: 20, y: 10, width: 30, height: 30))
        imgview.image = UIImage(named: "qr_activity")
        backgroundview.addSubview(imgview)
        
        let avnamelabel = UILabel(frame: CGRect(x: 62, y: 18, width: backgroundview.frame.width - 62, height: 15))
        avnamelabel.text = activityName
        avnamelabel.font = UIFont.boldSystemFont(ofSize: 15)
        avnamelabel.textColor = UIColor.init(red: 64/255, green: 64/255, blue: 64/255, alpha: 1)
        backgroundview.addSubview(avnamelabel)
        
        let lineview = UIView(frame: CGRect(x: 0, y: 55, width: backgroundview.frame.width, height: 0.5))
        lineview.backgroundColor = UIColor.init(red: 199/255, green: 199/255, blue: 205/255, alpha: 1)
        backgroundview.addSubview(lineview)
        
        let qrimgview = UIImageView(frame: CGRect(x: 60, y: 90, width: (backgroundview.frame.width - 120), height: (backgroundview.frame.width - 120)))
        qrimgview.image = createQRForString(qrString: qrString, qrImageName: qrImageName)
        backgroundview.addSubview(qrimgview)
        
        let qrlabel = UILabel(frame: CGRect(x: 0, y: 350, width: backgroundview.frame.width, height: 15))
        qrlabel.text = "扫一扫二维码，快速加入活动"
        qrlabel.textColor = UIColor.init(red: 64/255, green: 64/255, blue: 64/255, alpha: 1)
        qrlabel.textAlignment = .center
        backgroundview.addSubview(qrlabel)
        
        let saveBtn = UIButton(frame: CGRect(x: 30, y: 390, width: 275, height: 40))
        saveBtn.setTitle("保存", for: .normal)
        saveBtn.backgroundColor = UIColor.init(red: 241/255, green: 122/255, blue: 93/255, alpha: 1)
        backgroundview.addSubview(saveBtn)
        
    }
    
}
