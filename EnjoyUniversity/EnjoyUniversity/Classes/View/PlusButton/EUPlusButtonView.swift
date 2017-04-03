//
//  EUPlusButtonView.swift
//  EnjoyUniversity
//
//  Created by lip on 17/3/9.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUPlusButtonView: UIView {
    
    var plusBtn:UIButton?
    
    // 扫一扫按钮
    var qrcodeBtn:EUActivityButton?
    // 发布活动按钮
    var activityBtn:EUActivityButton?
    // 发布通知按钮
    var notifyBtn:EUActivityButton?

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showPlusButtonView(){
        
        // 取得根视图控制器（否则无法遮住 tabbar）
        guard let rootvc = UIApplication.shared.keyWindow?.rootViewController as? EUMainViewController else{
            return
        }
        
        let width = rootvc.tabBar.frame.width / 5
        let height = rootvc.tabBar.frame.height
        
        // 点击识别
        let taprecognizer = UITapGestureRecognizer(target: self, action: #selector(removeCurrentView))
        self.addGestureRecognizer(taprecognizer)
        
        plusBtn = UIButton(frame: CGRect(x: 2 * width, y: rootvc.tabBar.frame.minY, width: width, height: height))
        qrcodeBtn = EUActivityButton(frame: CGRect(x: 2 * width, y: rootvc.tabBar.frame.minY, width: width, height: height),
                                     image: UIImage(named: "plus_qrcode")!,
                                     text: "扫描二维码",
                                     shadowimage: UIImage(named: "av_shadow_blue")!,
                                     font: 12,
                                     textcolor: UIColor.white,
                                     imgwidth: 30,
                                     shadowimgwidth: 50)
        activityBtn = EUActivityButton(frame: CGRect(x: 2 * width, y: rootvc.tabBar.frame.minY, width: width, height: height),
                                     image: UIImage(named: "plus_activity")!,
                                     text: "发布活动",
                                     shadowimage: UIImage(named: "av_shadow_red")!,
                                     font: 12,
                                     textcolor: UIColor.white,
                                     imgwidth: 30,
                                     shadowimgwidth: 50)
        notifyBtn = EUActivityButton(frame: CGRect(x: 2 * width, y: rootvc.tabBar.frame.minY, width: width, height: height),
                                     image: UIImage(named: "plus_qrcode")!,
                                     text: "扫描二维码",
                                     shadowimage: UIImage(named: "av_shadow_blue")!,
                                     font: 12,
                                     textcolor: UIColor.white,
                                     imgwidth: 30,
                                     shadowimgwidth: 50)
        
        guard let plusBtn = plusBtn,let qrcodeBtn = qrcodeBtn,let activityBtn = activityBtn,let notifyBtn = notifyBtn else {
            return
        }
        
        // 先隐藏所有 Button
        qrcodeBtn.alpha = 0
        activityBtn.alpha = 0
        notifyBtn.alpha = 0
        
        plusBtn.setImage(#imageLiteral(resourceName: "tabbar_plus"), for: .normal)
        plusBtn.addTarget(nil, action: #selector(removeCurrentView), for: .touchUpInside)
        
        let ef = UIBlurEffect(style: .dark)
        let efv = UIVisualEffectView(effect: ef)
        efv.frame = frame
        addSubview(efv)
        
        self.addSubview(plusBtn)
        self.addSubview(qrcodeBtn)
        self.addSubview(activityBtn)
        self.addSubview(notifyBtn)
        
        UIView.animate(withDuration: 0.25) { 
            plusBtn.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 4))
            
            activityBtn.frame.origin = CGPoint(x: 50, y: UIScreen.main.bounds.height - 150)
            activityBtn.alpha = 1
            
            notifyBtn.frame.origin = CGPoint(x: UIScreen.main.bounds.width / 2 - width / 2, y: UIScreen.main.bounds.height - 150)
            notifyBtn.alpha = 1
            
            qrcodeBtn.frame.origin = CGPoint(x: UIScreen.main.bounds.width - 50 - width, y: UIScreen.main.bounds.height - 150)
            qrcodeBtn.alpha = 1
        }
        

   
        rootvc.view.addSubview(self)
    }

    
}

// MARK: - 监听相关方法
extension EUPlusButtonView{
    
    
    /// 删除当前视图
    @objc fileprivate func removeCurrentView(){

        UIView.animate(withDuration: 0.25, animations: { 
            self.plusBtn?.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 2) )
            self.alpha = 0
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
}
