//
//  EZRefreshView.swift
//  EZRefreshControl
//
//  Created by lip on 16/11/21.
//  Copyright © 2016年 lip. All rights reserved.
//

import UIKit

// 刷新视图 － 负责显示刷新控件 UI
class EZRefreshView: UIView {
    
    //MARK: -  刷新控件状态
    ///
    /// - Normal: 正常状态，无法刷新
    /// - CanRefresh: 下拉超过最低值，松手即可刷新
    /// - IsRefreshing: 正在刷新
    enum EZRefreshState {
        case Normal
        case CanRefresh
        case IsRefreshing
    }

    /// 刷新状态
    var refreshState:EZRefreshState = .Normal{
        
        didSet{
            switch refreshState {
            case .Normal:
                tipLabel.text = "下拉刷新"
                // 恢复隐藏的箭头&停止旋转
                tipIndicator.stopAnimating()
                tipicon.isHidden = false
                UIView.animate(withDuration: 0.25, animations: {
                    
                    // 从变化中恢复到原来的状态
                    self.tipicon.transform = CGAffineTransform.identity

                })
            case .CanRefresh:
                tipLabel.text = "释放刷新"
                UIView.animate(withDuration: 0.25, animations: {
                    
                    // 旋转方法
                    self.tipicon.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI - 0.001))
                })
            case .IsRefreshing:
                tipLabel.text = "正在刷新"
                tipicon.isHidden = true
                tipIndicator.startAnimating()

            }
        }
        
    }
    
    @IBOutlet weak var tipicon: UIImageView!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var tipIndicator: UIActivityIndicatorView!
    
    
    // 类方法加载 XIB
    class func ezRefreshView()->EZRefreshView{
        
        let nib = UINib(nibName: "EZRefreshView", bundle: nil)
        
        let view = nib.instantiate(withOwner: nil, options: nil)[0] as! EZRefreshView
        
        return view
        
        
    }
    

}
