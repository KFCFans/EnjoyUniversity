//
//  EZRefreshControl.swift
//  EZRefreshControl
//
//  Created by lip on 16/11/20.
//  Copyright © 2016年 lip. All rights reserved.
//

import UIKit


// 刷新控件 － 负责'逻辑'控制
class EZRefreshControl: UIControl {
    
    // MARK: - contentSize，contentOffset和contentInset的学习
    
    /**
     contentSize:是scrollview可以滚动的区域，比如frame = (0 ,0 ,320 ,480) contentSize = (320 ,960)，代表你的scrollview可以上下滚动，滚动区域为frame大小的两倍。
     contentOffset:是scrollview当前显示区域顶点相对于frame顶点的偏移量，比如上个例子你拉到最下面，contentoffset就是(0 ,480)，也就是y偏移了480
     contentInset:是scrollview的contentview的顶点相对于scrollview的位置，例如你的contentInset = (0 ,100)，那么你的contentview就是从scrollview的(0 ,100)开始显示
    */
    
    // MARK: - 属性
    
    /// 刷新控件的父视图，下拉刷新控件应该适用于 UITableView／UICollectionView
    private weak var scrollView:UIScrollView?
    
    /// 下拉刷新刷新视图
    let refreshView = EZRefreshView.ezRefreshView()
    
    /// 最少下拉量
    let MINPullToRefreshHeight:CGFloat = 60
    
    
    // MARK: - 构造函数
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    // MARK: - 允许 XIB 开发
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    // MARK: - 即将添加到父视图
    /**
     willMove(toSuperview newSuperview: UIView?)
        1.当添加到父视图的时候，newSuperview 是父视图
        2.当父视图被移除，newSuperview 是 nil
    */
    override func willMove(toSuperview newSuperview: UIView?) {
        guard let sv = newSuperview as? UIScrollView else {
            return
        }
        
        //记录父视图
        scrollView = sv
        
        // MARK: - KVO
        // KVO 监听父视图的 contentoffSet
        // 在程序中，通常只监听某个对象的几个属性。如果属性太多，方法会很乱！
        // ⚠️ 观察者模式，在不需要的时候，都需要释放
        //    - 通知中心:如果不释放，什么也不会发生，但是会有内存泄漏，会有多次注册的可能
        //    - KVO:如果不释放，会崩溃！！
        sv.addObserver(self, forKeyPath: "contentOffset", options: [], context: nil)
        

    }
    
    // MARK: - 本视图从父视图上移除
    // 所有的框架 KVO 监听实现思路都是这个（下拉框架都是监听父视图的 contentOffset）
    override func removeFromSuperview() {
        // superView 还存在
        superview?.removeObserver(self, forKeyPath: "contentOffset")
        
        super.removeFromSuperview()
        // superview 不存在
    }
    
    // MARK: - KVO 监听方法，所有 KVO 方法会统一调用
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        
        guard let scrollView = scrollView else {
            return
        }
        
        // contentOffset 的 y值和 contentInset 的 top 有关
        
        // 初始高度应该是 0
        let height = -(scrollView.contentInset.top + scrollView.contentOffset.y)
  
//        print("height\(height)")
        
        // 如果向上滚动表格，无需考虑下拉刷新问题，直接返回即可
        if height < 0 {
            return
        }
        
        // 根据高度设置刷新控件的 frame
        frame = CGRect(x: 0, y: -height, width: UIScreen.main.bounds.width, height: height)
        
        if scrollView.isDragging {
            if (height > MINPullToRefreshHeight) && refreshView.refreshState == .Normal {

                // 释放刷新
                refreshView.refreshState = .CanRefresh
               
            }
            else if (height <= MINPullToRefreshHeight) && refreshView.refreshState == .CanRefresh  {
                // 下拉刷新
                refreshView.refreshState = .Normal
                
            }
        }
            //不在拖拽状态下
        else if refreshView.refreshState == .CanRefresh{
            
            // 开始刷新
            beginRefreshing()
            
            sendActions(for: .valueChanged)
            
        }
    }

    func endRefreshing(){
     
        // 防止开发者瞎用，开发框架时要按乱用的角度去排除 bug ，比如此处麻瓜开发者连续吊用 endRefreshing ，若没有判断，每调用一次表格就缩进，问题严重！
        if refreshView.refreshState != .IsRefreshing {
            return
        }
        
        guard let scrollView = scrollView else{
            return
        }
        
        refreshView.refreshState = .Normal
        
        scrollView.contentInset.top -= MINPullToRefreshHeight
        
        
        
    }

    func beginRefreshing(){
        
        
        // 同上！ 框架思想！
        if refreshView.refreshState == .IsRefreshing{
            return
        }
        
        guard let scrollView = scrollView else {
            return
        }
        
        refreshView.refreshState = .IsRefreshing
        
        scrollView.contentInset.top += MINPullToRefreshHeight
        
        
    }

}

extension EZRefreshControl{
    
    fileprivate func setupUI(){
        
        // 使用苹果原生自动布局前，必须关闭 translatesAutoresizingMaskIntoConstraints
        refreshView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .centerX,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .centerX,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .bottom,
                                         relatedBy: .equal,
                                         toItem: self,
                                         attribute: .bottom,
                                         multiplier: 1.0,
                                         constant: 0))
        addConstraint(NSLayoutConstraint(item: refreshView,
                                         attribute: .height,
                                         relatedBy: .equal,
                                         toItem: nil,
                                         attribute: .notAnAttribute,
                                         multiplier: 1.0,
                                         constant: refreshView.bounds.height))

    
        addSubview(refreshView)

    }
    

    
    
}
