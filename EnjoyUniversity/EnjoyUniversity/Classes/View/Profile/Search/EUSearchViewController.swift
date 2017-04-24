//
//  EUSearchViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/2/28.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUSearchViewController: EUBaseViewController {
    

    let searchbar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 60, height: 30))
    
    /// 显示搜索到的活动数量
    let avLabel = UILabel()
    
    /// 显示搜索到的社团数量
    let cmLabel = UILabel()
    
    /// 显示搜索到的用户数量
    let userLabel = UILabel()
    
    var keyword:String?

    override func viewDidLoad() {
        super.viewDidLoad()


        tableview.removeFromSuperview()
        view.backgroundColor = BACKGROUNDCOLOR
        setupSearchBar()
        setButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}


// MARK: - UI 相关方法
extension EUSearchViewController{
    
    /// 设置导航栏
    override func setupNavBar() {
        
        super.setupNavBar()
        let v = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30))
        v.addSubview(searchbar)
        navitem.titleView = v
        
    }
    
    /// 设置搜索栏
    fileprivate func setupSearchBar(){
        
        //FIXME: - 自定义 UISearchBar ，修改字体颜色
        searchbar.placeholder = "搜索                                                              "
        searchbar.searchBarStyle = .minimal
        searchbar.barTintColor = UIColor.white
        searchbar.delegate = self
        
    }
    
    fileprivate func setButtons(){
        
        let buttonWidth:CGFloat = 67
        
        let leftMargin = (UIScreen.main.bounds.width - buttonWidth*3)/4
        
        let activityBtn = UIButton(frame: CGRect(x: leftMargin, y: 100, width: buttonWidth, height: buttonWidth))
        
        let communityBtn = UIButton(frame: CGRect(x: leftMargin * 2 + buttonWidth, y: 100, width: buttonWidth, height: buttonWidth))
        
        let userBtn = UIButton(frame: CGRect(x: leftMargin * 3 + buttonWidth * 2, y: 100, width: buttonWidth, height: buttonWidth))
        
        activityBtn.setImage(UIImage(named: "search_activity"), for: .normal)
        communityBtn.setImage(UIImage(named: "search_community"), for: .normal)
        userBtn.setImage(UIImage(named: "search_user"), for: .normal)
        
        activityBtn.addTarget(nil, action: #selector(searchActivity), for: .touchUpInside)
        communityBtn.addTarget(nil, action: #selector(searchCommunity), for: .touchUpInside)
        userBtn.addTarget(nil, action: #selector(searchUser), for: .touchUpInside)
        
        view.addSubview(activityBtn)
        view.addSubview(communityBtn)
        view.addSubview(userBtn)
        
        avLabel.text = "活动"
        avLabel.font = UIFont.boldSystemFont(ofSize: 13)
        avLabel.frame.size = CGSize(width: 100, height: 13)
        avLabel.textAlignment = .center
        avLabel.textColor = TEXTVIEWCOLOR
        avLabel.center.x = activityBtn.center.x
        avLabel.frame.origin.y = activityBtn.frame.maxY + 20
        
        cmLabel.text = "社团"
        cmLabel.font = UIFont.boldSystemFont(ofSize: 13)
        cmLabel.frame.size = CGSize(width: 100, height: 13)
        cmLabel.textAlignment = .center
        cmLabel.textColor = TEXTVIEWCOLOR
        cmLabel.center.x = communityBtn.center.x
        cmLabel.frame.origin.y = communityBtn.frame.maxY + 20

        userLabel.text = "小伙伴"
        userLabel.font = UIFont.boldSystemFont(ofSize: 13)
        userLabel.frame.size = CGSize(width: 100, height: 13)
        userLabel.textAlignment = .center
        userLabel.textColor = TEXTVIEWCOLOR
        userLabel.center.x = userBtn.center.x
        userLabel.frame.origin.y = userBtn.frame.maxY + 20
        
        view.addSubview(avLabel)
        view.addSubview(cmLabel)
        view.addSubview(userLabel)
        
    }
}

// MARK: - 代理方法
extension EUSearchViewController:UISearchBarDelegate{
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let keyword = searchbar.text else {
            SwiftyProgressHUD.showBigFaildHUD(text: "请输入收藏内容", duration: 1)
            return
        }
        self.keyword = keyword
        SwiftyProgressHUD.showLoadingHUD()
        EUNetworkManager.shared.getSearchNum(keyword: keyword) { (isSuccess, dict) in
            SwiftyProgressHUD.hide()
            if !isSuccess{
                SwiftyProgressHUD.showWarnHUD(text: "网络异常", duration: 1)
                return
            }
            guard let dict = dict,let avnum = dict["activityNum"],let cmnum = dict["communityNum"],let usernum = dict["userNum"] else{
                SwiftyProgressHUD.showFaildHUD(text: "加载失败", duration: 1)
                return
            }
            self.avLabel.text = "\(avnum) 个活动"
            self.cmLabel.text = "\(cmnum) 个社团"
            self.userLabel.text = "\(usernum) 位小伙伴"
            
        }
        
    }
}

// MARK: - 监听方法
extension EUSearchViewController{
    
    @objc fileprivate func searchActivity(){
        let vc = EUSearchActivityController()
        vc.keyword = keyword
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc fileprivate func searchCommunity(){
        
    }
    
    @objc fileprivate func searchUser(){
        
    }
    
}

