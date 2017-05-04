//
//  EUAddPopView.swift
//  EnjoyUniversity
//
//  Created by lip on 17/5/4.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

protocol EUAddPopViewDelegate {
    func euAddPopView(didSelectRowAt:Int)
}

class EUAddPopView: UIView,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate {
    
    let functionArray = ["二维码","发活动","发通知"]
    
    let functionImageArray = ["home_scan","home_startactivity","home_notiify"]
    
    var delegate:EUAddPopViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        
        let tableView = UITableView(frame: CGRect(x: UIScreen.main.bounds.width - 140, y: 68, width: 128, height: 132))
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.layer.masksToBounds = true
        tableView.layer.cornerRadius = 10
        tableView.separatorStyle = .none
        tableView.bounces = false
        addSubview(tableView)
        
        // 点击背景返回
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(didClickBackGround))
        tapgesture.delegate = self
        addGestureRecognizer(tapgesture)
    }
    
    @objc private func didClickBackGround(){
        self.removeFromSuperview()
    }
    
    func showAddPopView(){
        
        // 取得根视图控制器（否则无法遮住 tabbar）
        guard let rootvc = UIApplication.shared.keyWindow?.rootViewController as? EUMainViewController else{
            return
        }
        rootvc.view.addSubview(self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return functionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = EUAddPopCell()
        cell.functionLabel.text = functionArray[indexPath.row]
        cell.functionImageView.image = UIImage(named: functionImageArray[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.euAddPopView(didSelectRowAt: indexPath.row)
        self.removeFromSuperview()
    }
    
    // 解决手势和 tableview 响应冲突
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if NSStringFromClass((touch.view?.classForCoder)!) == "UITableViewCellContentView"{
            return false
        }
        return true
        
    }
}

/// 自定义 cell
class EUAddPopCell:UITableViewCell{
    
    let functionImageView = UIImageView()
    
    let functionLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        selectionStyle = .none
        
        functionImageView.frame = CGRect(x: 23, y: 14, width: 20, height: 20)
        addSubview(functionImageView)
        
        functionLabel.frame = CGRect(x: 55, y: 16, width: 44, height: 14)
        functionLabel.font = UIFont.boldSystemFont(ofSize: 14)
        functionLabel.textColor = UIColor.init(red: 62/255, green: 62/255, blue: 62/255, alpha: 1)
        addSubview(functionLabel)
        
        let lineview = UIView(frame: CGRect(x: 8, y: 43, width: 112, height: 1))
        lineview.backgroundColor = BACKGROUNDCOLOR
        addSubview(lineview)
        
    }
    
}
