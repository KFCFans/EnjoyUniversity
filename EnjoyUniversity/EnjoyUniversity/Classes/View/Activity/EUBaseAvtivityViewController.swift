//
//  EUBaseAvtivityViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/1.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUBaseAvtivityViewController: UIViewController {
    
    // 隐藏状态栏
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    // 背景图片
    var backgroudImage = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 180))
    
    // 返回按钮
    var backBtn = UIButton()
    
        
    // 活动标题文本
    var titleLabel = UILabel()
    
    // 是否需要签到
    var warnLabel = UILabel()
    
    // 地点
    var placeLabel = UILabel()
    
    // 时间
    var timeLabel = UILabel()
    
    // 价格
    var priceLabel = UILabel()
    
    // 人数
    var participatornumLabel = UILabel()
    
    // 活动详情
    let detailLabel = UILabel()
    
    // 活动详情文本高度
    var detailHeight:CGFloat = 0

    
    // 滑动视图
    var scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 60))

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCommonUI()
        setupActivityInfoUI()
        setupActivityDetailUI()
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
        backgroudImage.clipsToBounds = true
        
        // 返回按钮
        let rightshadow = UIImageView(frame: CGRect(x: 20, y: 30, width: 30, height: 30))
        rightshadow.alpha = 0.7
        rightshadow.image = UIImage(named: "nav_background")
        view.addSubview(rightshadow)
        
        backBtn.setImage(UIImage(named: "nav_back"), for: .normal)
        backBtn.frame = CGRect(x: 3, y: 3, width: 24, height: 24)
        backBtn.isUserInteractionEnabled = true
        rightshadow.isUserInteractionEnabled = true
        backBtn.addTarget(nil, action: #selector(backButtonIsClicked), for: .touchUpInside)
        rightshadow.addSubview(backBtn)
        

        
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
        
        warnLabel.textColor = UIColor.white
        warnLabel.font = UIFont.boldSystemFont(ofSize: 12)
        warnLabel.frame = CGRect(x: 22, y: 1.5, width: 60, height: 15)
        noticeview.addSubview(warnLabel)
        
        
        scrollView.addSubview(backgroudImage)
        backgroudImage.addSubview(titleLabel)
        backgroudImage.addSubview(noticeview)
        
    }
    
    fileprivate func setupActivityInfoUI(){
        
        /// 设置滚动空间
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 510 + detailHeight)
        
        /// 活动信息视图
        let activityinfoview = UIView(frame: CGRect(x: 5, y: 270, width: UIScreen.main.bounds.width - 10, height: 176))
        activityinfoview.backgroundColor = UIColor.white
        scrollView.addSubview(activityinfoview)
        
        // 价格
        let avpriceimg = UIImageView(frame: CGRect(x: 12, y: 14, width: 16, height: 16))
        avpriceimg.image = UIImage(named: "av_price")
        activityinfoview.addSubview(avpriceimg)
        
        priceLabel.textColor = UIColor.darkGray
        priceLabel.frame = CGRect(x: 40, y: 15, width: 100, height: 14)
        priceLabel.font = UIFont.boldSystemFont(ofSize: 14)
        activityinfoview.addSubview(priceLabel)
        
        // 地点
        let avplaceimg = UIImageView(frame: CGRect(x: 12, y: 58, width: 16, height: 16))
        avplaceimg.image = UIImage(named: "av_place")
        activityinfoview.addSubview(avplaceimg)
        
        placeLabel.textColor = UIColor.darkGray
        placeLabel.frame = CGRect(x: 40, y: 59, width: 200, height: 14)
        placeLabel.font = UIFont.boldSystemFont(ofSize: 14)
        activityinfoview.addSubview(placeLabel)
        
        // 时间
        let avtimeimg = UIImageView(frame: CGRect(x: 12, y: 102, width: 16, height: 16))
        avtimeimg.image = UIImage(named: "av_time")
        activityinfoview.addSubview(avtimeimg)
        
        timeLabel.textColor = UIColor.darkGray
        timeLabel.frame = CGRect(x: 40, y: 103, width: UIScreen.main.bounds.width, height: 14)
        timeLabel.font = UIFont.boldSystemFont(ofSize: 14)
        activityinfoview.addSubview(timeLabel)
        
        
        // 人数
        let participatornumview = UIImageView(frame: CGRect(x: 0, y: 132, width: activityinfoview.frame.width, height: 44))
        activityinfoview.addSubview(participatornumview)
        
        let avenrollimg = UIImageView(frame: CGRect(x: 12, y: 14, width: 16, height: 16))
        avenrollimg.image = UIImage(named: "av_enroll")
        participatornumview.addSubview(avenrollimg)
        
        participatornumLabel.text = "已报名30人/限100人"
        participatornumLabel.textColor = UIColor.darkGray
        participatornumLabel.frame = CGRect(x: 40, y: 15, width: 200, height: 14)
        participatornumLabel.font = UIFont.boldSystemFont(ofSize: 14)
        participatornumview.addSubview(participatornumLabel)
        
        let moreimg = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width - 28, y: 14, width: 16, height: 16))
        moreimg.image = UIImage(named: "nav_more")
        participatornumview.addSubview(moreimg)
        
        // 添加点击响应事件
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(showParticipators))
        participatornumview.isUserInteractionEnabled = true
        participatornumview.addGestureRecognizer(tapgesture)
        
    }
    
    fileprivate func setupActivityDetailUI(){
        
        
        
        // 活动详情视图
        let detailview = UIView(frame: CGRect(x: 5, y: 456, width: UIScreen.main.bounds.width - 10, height: 44 + detailHeight + 10))
        detailview.backgroundColor = UIColor.white
        scrollView.addSubview(detailview)
        
        let dtitle = UILabel(frame: CGRect(x: 15, y: 15, width: 100, height: 15))
        dtitle.textColor = UIColor.black
        dtitle.text = "活动详情"
        dtitle.font = UIFont.boldSystemFont(ofSize: 15)
        detailview.addSubview(dtitle)
        
        // 详情
        detailLabel.frame = CGRect(x: 15, y: 44, width: UIScreen.main.bounds.width - 30, height: detailHeight)
        detailLabel.numberOfLines = 0
        detailLabel.backgroundColor = UIColor.white
        detailLabel.textColor = UIColor.darkGray
        detailLabel.font = UIFont.boldSystemFont(ofSize: 14)
        detailview.addSubview(detailLabel)
        
    }

}

// MARK: - 监听方法集合
extension EUBaseAvtivityViewController{
    
    /// 返回按钮
    @objc fileprivate func backButtonIsClicked(){
        
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    //／ 获取参与者列表
    @objc fileprivate func showParticipators(){
        print("showDetail")
        
    }
    
}
