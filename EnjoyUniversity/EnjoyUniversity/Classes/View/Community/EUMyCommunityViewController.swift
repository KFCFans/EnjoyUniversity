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
    lazy var spinnerview = SwiftySpinner(frame: UIScreen.main.bounds)
    let titleButtonView = UIButton()
    
    
    lazy var communityauthorutylist = CommunityAuthorityListViewModel()
    
    var loadDataFinished:Bool = false{
        
        didSet{
            
            if loadDataFinished && communityauthorutylist.communityauthoritylist.count > 0{
                titleButtonView.setTitle(communityauthorutylist.communityauthoritylist.first?.cmname, for: .normal)
                titleButtonView.isEnabled = true
                spinnerview.reloadData()
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
        spinnerview.delegate = self
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
            
            var datalist = [String]()
            for model in self.communityauthorutylist.communityauthoritylist {
                datalist.append(model.cmname ?? "")
            }
            self.spinnerview.datalist = datalist
            self.loadDataFinished = true
        }
        
    }
    

}



// MARK: - 监听方法
extension EUMyCommunityViewController{
    
    /// 点击标题按钮
    @objc fileprivate func didClickTitleBtn(){
        
        if !spinnerview.isOnView{
            view.insertSubview(spinnerview, belowSubview: navbar)
            spinnerview.showSpinner()
        }else{
            spinnerview.removeSpinner()
        }
    }
}

// MARK: - 代理方法
extension EUMyCommunityViewController:SwiftySpinnerDelegate{
    
    func swiftySpinnerDidChangeStatus(isOnView: Bool) {
        titleButtonView.isSelected = isOnView
    }
    
    func swiftySpinnerDidSelectRowAt(cell: SpinnerCell, row: Int) {
        print(row)
    }
    
}
