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
        guard let plusBtn = plusBtn else {
            return
        }
        plusBtn.setImage(#imageLiteral(resourceName: "tabbar_plus"), for: .normal)
        plusBtn.addTarget(nil, action: #selector(removeCurrentView), for: .touchUpInside)
        
        let ef = UIBlurEffect(style: .dark)
        let efv = UIVisualEffectView(effect: ef)
        efv.frame = frame
        addSubview(efv)
        
        self.addSubview(plusBtn)
        
        UIView.animate(withDuration: 0.25) { 
            plusBtn.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 4))
        }
   
        rootvc.view.addSubview(self)
    }

    
}

// MARK: - 监听相关方法
extension EUPlusButtonView{
    
    
    /// 删除当前视图
    @objc fileprivate func removeCurrentView(){

        // 动画隐藏当前视图
        UIView.animate(withDuration: 0.25) {
            self.plusBtn?.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI / 2) )
            self.alpha = 0
        }

        // 移除当前视图
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
            self.removeFromSuperview()
        }
        
        
    }
    
}
