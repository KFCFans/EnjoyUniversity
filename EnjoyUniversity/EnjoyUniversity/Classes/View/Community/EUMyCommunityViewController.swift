//
//  EUMyCommunityViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/15.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUMyCommunityViewController: EUBaseViewController {
    
    /// 下拉选择框相关
    lazy var spinnertableview = UITableView()
    lazy var shadowview = UIView(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64))
    let titleButtonView = UIButton()
    var shouldShowSpinner:Bool = true{
        didSet{
            titleButtonView.isSelected = !shouldShowSpinner
        }
    }
    
    lazy var communityauthorutylist = CommunityAuthorityListViewModel()
    
    var loadDataFinished:Bool = false{
        
        didSet{
            
            if loadDataFinished && communityauthorutylist.communityauthoritylist.count > 0{
                spinnertableview.reloadData()
                titleButtonView.setTitle(communityauthorutylist.communityauthoritylist.first?.cmname, for: .normal)
                titleButtonView.isEnabled = true
                let tbheight:CGFloat = CGFloat(communityauthorutylist.communityauthoritylist.count > 3 ? 4 : communityauthorutylist.communityauthoritylist.count)*44.0
                spinnertableview.frame = CGRect(x: 10, y: -tbheight , width: UIScreen.main.bounds.width - 20, height: tbheight)
            }
            
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        titleButtonView.setTitleColor(UIColor.white, for: .normal)
        titleButtonView.frame.size = CGSize(width: UIScreen.main.bounds.width - 100, height: 20)
        titleButtonView.addTarget(nil, action: #selector(didClickTitleBtn), for: .touchUpInside)
        titleButtonView.setTitle("加载中", for: .normal)
        titleButtonView.setImage(UIImage(named: "community_down"), for: .normal)
        titleButtonView.setImage(UIImage(named: "community_up"), for: .selected)
        titleButtonView.isEnabled = false
        navitem.titleView = titleButtonView
        initSpinner()
    }

    
    override func loadData() {
        
        communityauthorutylist.loadCommunityNameList { (isSuccess, hasData) in
            
            if !isSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            if !hasData{
                // 提示用户赶快加入社团
                return
            }
            self.loadDataFinished = true
        }
        
    }
    

}



// MARK: - 监听方法
extension EUMyCommunityViewController{
    
    /// 点击标题按钮
    @objc fileprivate func didClickTitleBtn(){
        
        shouldShowSpinner ? showSpinner() : removeSpinner()
    }
    
}

// MARK: - UI 相关方法
extension EUMyCommunityViewController{
    
    fileprivate func initSpinner(){
        
        shadowview.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.6)
        spinnertableview.layer.masksToBounds = true
        spinnertableview.layer.cornerRadius = 10
        let uef = UIBlurEffect(style: .light)
        let vs = UIVisualEffectView(effect: uef)
        vs.alpha = 0.5
        vs.frame = spinnertableview.bounds
        spinnertableview.backgroundView = vs
        spinnertableview.separatorStyle = .singleLine
        spinnertableview.delegate = self
        spinnertableview.dataSource = self
        automaticallyAdjustsScrollViewInsets = false
        
        let tapgesture = UITapGestureRecognizer(target: self, action: #selector(removeSpinner))
        tapgesture.delegate = self
        shadowview.addGestureRecognizer(tapgesture)
        
    }
    
    fileprivate func showSpinner(){
        shouldShowSpinner = false
        shadowview.alpha = 1
        view.insertSubview(shadowview, belowSubview: navbar)
        shadowview.addSubview(spinnertableview)
        UIView.animate(withDuration: 0.5) {
            self.spinnertableview.frame.origin = CGPoint(x: 10, y: 10)
        }
        
    }
    
    @objc fileprivate func removeSpinner(){
        shouldShowSpinner = true
        UIView.animate(withDuration: 0.5, animations: {
            
            self.shadowview.alpha = 0
            self.spinnertableview.frame.origin = CGPoint(x: 5, y: -self.spinnertableview.frame.height)
            
        }) { (_) in
            
            self.spinnertableview.removeFromSuperview()
            self.shadowview.removeFromSuperview()
        }
        
    }
    
}

// MARK: - 代理方法
extension EUMyCommunityViewController:UIGestureRecognizerDelegate{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communityauthorutylist.communityauthoritylist.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = SpinnerCell(title: communityauthorutylist.communityauthoritylist[indexPath.row].cmname ?? "", font: 15, textcolor: UIColor.darkText)
        if indexPath.row == 0{
            cell.textlabel.textColor = UIColor.init(red: 18/255, green: 150/255, blue: 219/255, alpha: 1)
            cell.indicatorview.isHidden = false
        }
        return cell
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        for cell in tableView.visibleCells{
            let cell = cell as? SpinnerCell
            cell?.textlabel.textColor = UIColor.darkText
            cell?.indicatorview.isHidden = true
        }
        
        let cell = tableView.cellForRow(at: indexPath) as? SpinnerCell
        cell?.textlabel.textColor = UIColor.init(red: 18/255, green: 150/255, blue: 219/255, alpha: 1)
        cell?.indicatorview.isHidden = false
        titleButtonView.setTitle(communityauthorutylist.communityauthoritylist[indexPath.row].cmname ?? "", for: .normal)
        shouldShowSpinner = true
        removeSpinner()
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
class SpinnerCell:UITableViewCell{
    
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

