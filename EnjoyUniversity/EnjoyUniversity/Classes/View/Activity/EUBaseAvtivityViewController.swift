//
//  EUBaseAvtivityViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/1.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUBaseAvtivityViewController: UIViewController {
    
    // 背景图片
    var backgroudImage = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 180))
    
    // 返回按钮
    var backBtn = UIButton()
    
        
    // 活动标题文本
    var titleLabel = UILabel()
    
    // 是否需要签到
    var warnLabel = UILabel()
    
    // 滑动视图
    var scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 60))

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCommonUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

// MARK: - UI 相关方法
extension EUBaseAvtivityViewController{
    
    fileprivate func setupCommonUI(){
        
        // 设置滚动视图
        view.addSubview(scrollView)
        // 使用 F2F2F2 配色
        scrollView.backgroundColor = UIColor.init(colorLiteralRed: 242.0/255.0, green: 242.0/255.0, blue: 242/255.0, alpha: 1)
        view.backgroundColor = UIColor.init(colorLiteralRed: 242.0/255.0, green: 242.0/255.0, blue: 242/255.0, alpha: 1)
        
        // 背景图(后面用 Kingfisher 加载)
        backgroudImage.image = UIImage(named: "tempbackground")
        backgroudImage.clipsToBounds = true
        
        // 返回按钮
        backBtn.setImage(UIImage(named: "nav_back"), for: .normal)
        backBtn.frame = CGRect(x: 20, y: 30, width: 24, height: 24)
        backBtn.addTarget(nil, action: #selector(backButtonIsClicked), for: .touchUpInside)
        

        
        // 标题
        titleLabel.frame = CGRect(x: 12, y: 125, width: 200, height: 17)
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.textColor = UIColor.white
        
        // 提醒
        let noticeview = UIView(frame: CGRect(x: 12, y: 152, width: 80, height: 18))
        noticeview.backgroundColor = UIColor.darkGray
        noticeview.alpha = 0.4
        
        let warn = UIImageView(image: UIImage(named: "av_notice"))
        warn.frame = CGRect(x: 3, y: 1.5, width: 15, height: 15)
        noticeview.addSubview(warn)
        
        warnLabel.text = "需要签到"
        warnLabel.textColor = UIColor.white
        warnLabel.font = UIFont.boldSystemFont(ofSize: 12)
        warnLabel.frame = CGRect(x: 22, y: 1.5, width: 60, height: 15)
        noticeview.addSubview(warnLabel)
        
        
        scrollView.addSubview(backgroudImage)
        view.addSubview(backBtn)

        backgroudImage.addSubview(titleLabel)
        backgroudImage.addSubview(noticeview)
        
    }

}

// MARK: - 监听方法集合
extension EUBaseAvtivityViewController{
    
    @objc fileprivate func backButtonIsClicked(){
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    
}
