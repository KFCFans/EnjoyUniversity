//
//  SwiftySpinner.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/15.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit


protocol SwiftySpinnerDelegate {
    /// 选中
    func swiftySpinnerDidSelectRowAt(cell:SwiftySpinnerCell,row:Int)
    /// 显示状态变化
    func swiftySpinnerDidChangeStatus(isOnView:Bool)
}
class SwiftySpinner: UIView {
    
    /// 下拉选择列表
    lazy var spinnertableview = UITableView()
    
    /// 下拉选择数组
    var datalist = [String]()
    
    /// 是否显示
    var isOnView: Bool = false{
        didSet{
            delegate?.swiftySpinnerDidChangeStatus(isOnView: isOnView)
        }
    }
    
    /// 代理
    var delegate:SwiftySpinnerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
        spinnertableview.layer.masksToBounds = true
        spinnertableview.layer.cornerRadius = 10
        let uef = UIBlurEffect(style: .light)
        let vs = UIVisualEffectView(effect: uef)
        vs.alpha = 0.5
        vs.frame = spinnertableview.bounds
        spinnertableview.backgroundView = vs
        spinnertableview.separatorStyle = .none
        spinnertableview.delegate = self
        spinnertableview.dataSource = self
        addSubview(spinnertableview)
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeSpinner))
        tapgesture.delegate = self
        addGestureRecognizer(tapgesture)

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadData(){
        
        let tbheight:CGFloat = CGFloat(datalist.count > 3 ? 4 : datalist.count)*44.0
        spinnertableview.frame = CGRect(x: 10, y: -tbheight , width: UIScreen.main.bounds.width - 20, height: tbheight)
        spinnertableview.reloadData()
        
    }

}

// MARK: - 动画方法
extension SwiftySpinner{
    
    
    func showSpinner(){
        isOnView = true
        self.alpha = 1
        UIView.animate(withDuration: 0.5) {
            self.spinnertableview.frame.origin = CGPoint(x: 10, y: 64 + 10)
        }
        
    }
    
    func removeSpinner(){
        isOnView = false
        UIView.animate(withDuration: 0.5, animations: {
            
            self.alpha = 0
            self.spinnertableview.frame.origin = CGPoint(x: 5, y: -self.spinnertableview.frame.height)
            
        }) { (_) in
            
            self.removeFromSuperview()
        }
        
    }
    
}
// MARK: - 代理方法
extension SwiftySpinner:UIGestureRecognizerDelegate,UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datalist.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = SwiftySpinnerCell(title: datalist[indexPath.row], font: 15, textcolor: UIColor.darkText)
        if indexPath.row == 0{
            cell.textlabel.textColor = UIColor.init(red: 18/255, green: 150/255, blue: 219/255, alpha: 1)
            cell.indicatorview.isHidden = false
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        for cell in tableView.visibleCells{
            let cell = cell as? SwiftySpinnerCell
            cell?.textlabel.textColor = UIColor.darkText
            cell?.indicatorview.isHidden = true
        }
        
        guard let cell = tableView.cellForRow(at: indexPath) as? SwiftySpinnerCell else{
            return
        }
        cell.textlabel.textColor = UIColor.init(red: 18/255, green: 150/255, blue: 219/255, alpha: 1)
        cell.indicatorview.isHidden = false
        removeSpinner()
        delegate?.swiftySpinnerDidSelectRowAt(cell: cell, row: indexPath.row)
        
    }
    
    // 解决手势和 tableview 响应冲突
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        
        if NSStringFromClass((touch.view?.classForCoder)!) == "UITableViewCellContentView"{
            return false
        }
        return true
        
    }
    
}

/// 自定义 Cell
class SwiftySpinnerCell:UITableViewCell{
    
    let textlabel = UILabel()
    let indicatorview = UIImageView(image: UIImage(named: "community_select"))
    
    init(title:String,font:CGFloat = 15,textcolor:UIColor = UIColor.darkText) {
        super.init(style: .default, reuseIdentifier: nil)
        
        selectionStyle = .none
        
        textlabel.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 20, height: self.frame.height)
        textlabel.text = title
        textlabel.textAlignment = .center
        textlabel.font = UIFont.boldSystemFont(ofSize: font)
        textlabel.textColor = textcolor
        textlabel.backgroundColor = UIColor.clear
        addSubview(textlabel)
        
        indicatorview.frame = CGRect(x: 5, y: 5, width: 5, height: frame.height - 10)
        indicatorview.isHidden = true
        addSubview(indicatorview)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}





