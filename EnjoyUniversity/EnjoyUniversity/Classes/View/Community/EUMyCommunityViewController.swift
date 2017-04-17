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
    
    /// 公告
    let announcedetail = UILabel()
    
    /// 社团 LOGO
    let communitylogo = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width - 97, y: 0, width: 50, height: 50))
    
    /// 公告栏高度
    var announceHeight:CGFloat = 0
    
    lazy var communityauthorutylist = CommunityAuthorityListViewModel()
    
    /// 下拉选择框
    var loadDataFinished:Bool = false{
        didSet{
            
            if loadDataFinished && communityauthorutylist.communityauthoritylist.count > 0{
                titleButtonView.setTitle(communityauthorutylist.communityauthoritylist.first?.cmname, for: .normal)
                titleButtonView.isEnabled = true
                spinnerview.reloadData()
            }
            
        }
    }
    
    /// 记录当前社团 ID
    var cmid = 0{
        didSet{
            loadCommunityData(cmid: cmid)
        }
    }
    
    /// 社团信息的视图模型
    var viewmodel:CommunityViewModel?{
        didSet{
            announcedetail.text = viewmodel?.communitymodel?.cmAnnouncement
            announceHeight = viewmodel?.myannouncementHeight ?? 0
            setupTableHeadView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        initSpinner()
        setupTableHeadView()
    }

    
    override func loadData() {
        
        communityauthorutylist.loadCommunityNameList { (isSuccess, hasData) in
            
            if !isSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            if !hasData{
                self.titleButtonView.setTitle("抓紧时间加入社团哦～", for: .normal)
                // FIXME: -  显示空空如也
                self.tableview.removeFromSuperview()
                return
            }
            
            var datalist = [String]()
            for model in self.communityauthorutylist.communityauthoritylist {
                datalist.append(model.cmname ?? "")
            }
            self.spinnerview.datalist = datalist
            self.loadDataFinished = true
            self.cmid = self.communityauthorutylist.communityauthoritylist.first?.cmid ?? 0
        }
    }
    
    fileprivate func loadCommunityData(cmid:Int){
        
        EUNetworkManager.shared.getCommunityInfoByID(cmid: cmid) { (isSuccess, viewmodel) in
            
            if !isSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            guard let viewmodel = viewmodel else{
                SwiftyProgressHUD.showFaildHUD(text: "社团不存在", duration: 1)
                return
            }
            self.viewmodel = viewmodel
        }
        
    }
}

// MARK: - UI 相关方法
extension EUMyCommunityViewController{
    
    fileprivate func initSpinner(){
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
    
    fileprivate func setupTableHeadView(){
        
        let headview = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width , height: 100 + announceHeight + 40))
        headview.backgroundColor = UIColor.init(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
        
        let announceview = UIView(frame: CGRect(x: 16, y: 15, width: headview.frame.width - 32, height: headview.frame.height - 30))
        announceview.backgroundColor = UIColor.white
        headview.addSubview(announceview)
        
        let announcelabel = UILabel(frame: CGRect(x: 20, y: 30, width: 100, height: 17))
        announcelabel.text = "公告"
        announcelabel.textColor = UIColor.black
        announcelabel.font = UIFont.boldSystemFont(ofSize: 17)
        announceview.addSubview(announcelabel)
        
        communitylogo.center.y = announcelabel.center.y
        announceview.layer.masksToBounds = true
        announceview.layer.cornerRadius = 5
        announceview.addSubview(communitylogo)
        
        announcedetail.frame = CGRect(x: 20, y: 100, width: announceview.frame.width - 40, height: announceHeight)
        announcedetail.numberOfLines = 0
        announcedetail.font = UIFont.boldSystemFont(ofSize: 15)
        announcedetail.textColor = UIColor.black
        announceview.addSubview(announcedetail)
        
        tableview.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        tableview.tableHeaderView = headview
        
        
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
    
    func swiftySpinnerDidSelectRowAt(cell: SwiftySpinnerCell, row: Int) {
        titleButtonView.setTitle(communityauthorutylist.communityauthoritylist[row].cmname ?? "", for: .normal)
        self.cmid = self.communityauthorutylist.communityauthoritylist[row].cmid

    }
    
}
