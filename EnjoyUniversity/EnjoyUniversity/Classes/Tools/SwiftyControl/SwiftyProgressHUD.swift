//
//  SwiftyProgressHUD.swift
//  SwiftyProgressHUD
//
//  Created by lip on 17/4/8.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class SwiftyProgressHUD: UIView {
    
    enum SwiftyProgressHUDType {
        case success
        case error
        case warn
        case loading
        case bigwarn
    }
    
    /// 自动消失的 HUD 持续时间
    private var duration:TimeInterval?
    
    /// 提醒文字
    private var hudtext:String?
    
    /// 类型
    private var hudetype:SwiftyProgressHUDType?
    
    /// 圆角
    private let cornerRadius : CGFloat = 13.0
    
    /// HUD 视图
    lazy var hudview = UIView()
    
    /// keyWindow
    private let keywindow = UIApplication.shared.keyWindow ?? UIWindow()
    
    init(text:String?,type:SwiftyProgressHUDType,duration:TimeInterval = 1.0,hudwidth:CGFloat = 60) {
        
        super.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        self.isUserInteractionEnabled = true
        self.hudtext = text
        self.hudetype = type
        self.duration = duration
        self.backgroundColor = UIColor.clear
        keywindow.addSubview(self)
        
        hudview.frame = CGRect(x: (UIScreen.main.bounds.width - hudwidth) / 2,
                               y: (UIScreen.main.bounds.height - hudwidth) / 2,
                               width: hudwidth,
                               height: hudwidth)
        hudview.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.8)
        hudview.layer.cornerRadius = cornerRadius
        addSubview(hudview)
        initByType()
    }
    
    fileprivate func initByType(){
        
        guard let hudetype = hudetype else {
            return
        }
        
        switch hudetype {
        case .success:
            let imgview = UIImageView(frame: CGRect(x: 10, y: 10, width: 40, height: 40))
            imgview.image = UIImage(named: "hud_success")
            hudview.addSubview(imgview)
            break
        case .error:
            initHUDViewWithLabel(imgname: "hud_error", text: hudtext ?? "错误")
            break
        case .warn:
            initHUDViewWithLabel(imgname: "hud_notice", text: hudtext ?? "警告")
        case .bigwarn:
            initBigHUDViewWithLabel(imgname: "hud_error", text: hudtext ?? "错误")
        case .loading:
            let indicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
            indicator.frame = CGRect(x: 10, y: 10, width: 40, height: 40)
            indicator.startAnimating()
            hudview.addSubview(indicator)
        }
        
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 成功的 HUD
    static func showSuccessHUD(duration:TimeInterval){
    
        SwiftyProgressHUD(text: nil, type: .success, duration: duration).show()
        
    }
    
    /// 失败的 HUD
    static func showFaildHUD(text:String,duration:TimeInterval){
        SwiftyProgressHUD(text: text, type: .error, duration: duration, hudwidth: 80).show()
        
    }
    
    /// 警告的 HUD
    static func showWarnHUD(text:String,duration:TimeInterval){
        SwiftyProgressHUD(text: text, type: .warn, duration: duration, hudwidth: 80).show()
    }
    
    /// 加载的 HUD
    static func showLoadingHUD(){
        SwiftyProgressHUD(text: nil, type: .loading).show()
    }
    
    /// 比较大的 HUD
    static func showBigFaildHUD(text:String,duration:TimeInterval){
        SwiftyProgressHUD(text: text, type: .bigwarn, duration: duration, hudwidth: 100).show()
    }
    
    func show(){
        
        UIView.animate(withDuration: 0.25, animations: { 
            self.hudview.alpha = 1
        }) { (_) in
            if let duration = self.duration{
                self.autoRemove(duration: duration)
            }
            
        }
    }
    
    func hide(){
        UIView.animate(withDuration: 0.25, animations: { 
            self.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
    func autoRemove(duration:TimeInterval){
        
        if let type = hudetype{
            if type == .loading {
                return
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) { 
            self.hide()
        }
        
    }
    
    private func initHUDViewWithLabel(imgname:String,text:String){
        
        
        let imageview = UIImageView(frame: CGRect(x: 20, y: 10, width: 40, height: 40))
        imageview.image = UIImage(named: imgname)
        hudview.addSubview(imageview)
        
        let label = UILabel(frame: CGRect(x: 0, y: 55, width: 80, height: 20))
        label.text = text
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        hudview.addSubview(label)
        
    }
    
    private func initBigHUDViewWithLabel(imgname:String,text:String){
        
        
        let imageview = UIImageView(frame: CGRect(x: 20, y: 10, width: 60, height: 60))
        imageview.image = UIImage(named: imgname)
        hudview.addSubview(imageview)
        
        let label = UILabel(frame: CGRect(x: 0, y: 75, width: 100, height: 20))
        label.text = text
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        hudview.addSubview(label)
        
    }
    
    static func hide(){
        
        guard let subviews = UIApplication.shared.keyWindow?.subviews else {
            return
        }
        
        for v in subviews{
            if v.isKind(of: self) {
                UIView.animate(withDuration: 0.25, animations: { 
                    v.removeFromSuperview()
                })
            }
        }
    }
    
    
}
