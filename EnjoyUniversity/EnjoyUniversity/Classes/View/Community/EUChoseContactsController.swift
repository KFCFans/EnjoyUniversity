//
//  EUChoseContactsController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/23.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUChoseContactsController: EUBaseViewController {
    
    /// 是否需要发送短信，上层传入
    var shouleSendSms:Bool = false
    
    /// 发送通知内容，上层传入
    var notifycationText:String = ""
    
    /// 社团 ID，上层传入
    var cmid:Int = 0
    
    /// 头部视图数组
    lazy var sectionarray = [FoldSectionView]()
    
    /// 保存选中的 index
    var selectIndexArray = [[Int]]()
    
    /// 可重用cell ID
    var EUCHOSECONTACTSCELL = "EUCHOSECONTACTSCELL"

    override func viewDidLoad() {
        super.viewDidLoad()

        navitem.title = "选择联系人"
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        
        let rightBtn = UIBarButtonItem(title: "fas", style: .plain, target: nil, action: #selector(sendNotification))
        navitem.rightBarButtonItem = rightBtn
        
        // 开启多选
        tableview.allowsMultipleSelection = true
        tableview.register(EUCommunityContactCell.self, forCellReuseIdentifier: EUCHOSECONTACTSCELL)
    }
    
    override func loadData() {
        
    }
    
}

// MARK: - 代理相关方法
extension EUChoseContactsController{
    
}

// MARK: - 监听相关方法
extension EUChoseContactsController{
    
    @objc fileprivate func sendNotification(){
        
    }
    
}








// MARK : -头部视图类
protocol FoldSectionViewDelegate {
    
    func foldSectionViewdidClicked(sectionView:FoldSectionView,isExpand:Bool)
    
    func foldSectionViewSelectButtondidClicked(sectionView:FoldSectionView,isSelected:Bool)
    
}
class FoldSectionView: UIView {
    
    var titleLabel = UILabel()
    
    let circleBtn = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 36, y: 0, width: 24, height: 24))
    
    var section:Int = 0
    
    var isExpand:Bool = false
    
    var indicatorview = UIImageView()
    
    lazy var datasource = [String]()
    
    var delegate:FoldSectionViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        indicatorview.image = UIImage(named: "cm_contactsindicator")
        indicatorview.frame.size = CGSize(width: 12, height: 12)
        indicatorview.frame.origin.x = 18
        indicatorview.center.y = center.y
        addSubview(indicatorview)
        
        titleLabel.frame.origin = CGPoint(x: 50, y: 15)
        titleLabel.text = "2014 级"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 14)
        titleLabel.sizeToFit()
        titleLabel.textColor = UIColor.black
        addSubview(titleLabel)
        
        circleBtn.setImage(UIImage(named: "cm_circle"), for: .normal)
        circleBtn.setImage(UIImage(named: "cm_circleselect"), for: .selected)
        circleBtn.addTarget(nil, action: #selector(didClickSelectAllButton(btn:)), for: .touchUpInside)
        addSubview(circleBtn)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(didClickSectionView))
        addGestureRecognizer(tap)
        
        
        
    }
    
    @objc private func didClickSectionView(){
        
        isExpand = !isExpand
        if isExpand{
            UIView.animate(withDuration: 0.25, animations: {
                self.indicatorview.transform = CGAffineTransform(rotationAngle: CGFloat(M_PI/2.0))
            })
        }else{
            UIView.animate(withDuration: 0.25, animations: {
                self.indicatorview.transform = CGAffineTransform.identity
            })
        }
        delegate?.foldSectionViewdidClicked(sectionView: self, isExpand: isExpand)
        
    }
    
    @objc private func didClickSelectAllButton(btn:UIButton){
        
        btn.isSelected = !btn.isSelected
        delegate?.foldSectionViewSelectButtondidClicked(sectionView: self, isSelected: btn.isSelected)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")

}
