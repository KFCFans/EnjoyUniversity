//
//  EUMyCommunityViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/15.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUMyCommunityViewController: EUBaseViewController {
    
    let function = ["通讯录","社团通知","社团管理","社团招新"]
    let functionimg = ["cm_contacts","cm_notify","cm_manage","cm_newmember"]
    
    /// 下拉选择框相关
    lazy var spinnerview = SwiftySpinner(frame: UIScreen.main.bounds)
    let titleButtonView = UIButton()
    
    /// 公告栏相关
    // 公告栏视图
    var headview = UIView()
    var announceview = UIView()
    // 公告
    let announcedetail = UILabel()
    // 社团 LOGO
    let communitylogo = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width - 97, y: 0, width: 50, height: 50))
    // 公告栏高度
    var announceHeight:CGFloat = 15
    
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
            announceHeight = viewmodel?.myannouncementHeight ?? 0
            reloadHeadView()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        tableview.frame = CGRect(x: 16, y: 0, width: UIScreen.main.bounds.width - 32, height: UIScreen.main.bounds.height)
        tableview.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        tableview.separatorStyle = .none
        tableview.backgroundColor = UIColor.init(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
        tableview.separatorStyle = .none
        view.backgroundColor = UIColor.init(red: 237/255, green: 237/255, blue: 237/255, alpha: 1)
        refreshControl?.backgroundColor = UIColor.white
        initSpinner()
        initTableHeadView()
        
    }

    
    override func loadData() {
        
        if loadDataFinished{
            loadCommunityData(cmid: cmid)
            return
        }
        
        communityauthorutylist.loadCommunityNameList { (isSuccess, hasData) in
            self.refreshControl?.endRefreshing()
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
            self.refreshControl?.endRefreshing()
            
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
    
    /// 初始化公告视图
    fileprivate func initTableHeadView(){
        
        headview.frame = CGRect(x: 0, y: 0, width: tableview.frame.width, height: 150 + announceHeight )
        announceview.frame = CGRect(x: 0, y: 15, width: tableview.frame.width, height: 100 + announceHeight + 20)
        announceview.backgroundColor = UIColor.white
        headview.addSubview(announceview)
        
        let announcelabel = UILabel(frame: CGRect(x: 20, y: 30, width: 100, height: 25))
        announcelabel.text = "公告"
        announcelabel.textColor = UIColor.black
        announcelabel.font = UIFont.boldSystemFont(ofSize: 25)
        announceview.addSubview(announcelabel)
        
        communitylogo.center.y = announcelabel.center.y
        announceview.layer.masksToBounds = true
        announceview.layer.cornerRadius = 5
        announceview.addSubview(communitylogo)
        
        announcedetail.frame = CGRect(x: 20, y: 100, width: announceview.frame.width - 40, height: announceHeight)
        announcedetail.text = "公告正在加载中..."
        announcedetail.numberOfLines = 0
        announcedetail.font = UIFont.boldSystemFont(ofSize: 15)
        announcedetail.textColor = UIColor.black
        announceview.addSubview(announcedetail)
        
        tableview.tableHeaderView = headview
        
    }
    
    /// 获取数据后对公告视图重新布局
    fileprivate func reloadHeadView(){
        
        headview.frame = CGRect(x: 0, y: 0, width: tableview.frame.width, height: 150 + announceHeight )
        announceview.frame = CGRect(x: 0, y: 15, width: tableview.frame.width, height: 100 + announceHeight + 20)
        announcedetail.frame = CGRect(x: 20, y: 100, width: announceview.frame.width - 40, height: announceHeight)
        announcedetail.text = viewmodel?.communitymodel?.cmAnnouncement ?? "暂无公告"
        communitylogo.kf.setImage(with: URL(string: viewmodel?.communityLogoUrl ?? ""),
                                  placeholder: UIImage(named: "eu_placeholder"),
                                  options: [.transition(.fade(1))],
                                  progressBlock: nil,
                                  completionHandler: nil)
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
        
        // 选择了其它社团才需要重新加载数据
        if self.communityauthorutylist.communityauthoritylist[row].cmid == cmid{
            return
        }
        refreshControl?.beginRefreshing()
        titleButtonView.setTitle(communityauthorutylist.communityauthoritylist[row].cmname ?? "", for: .normal)
        self.cmid = self.communityauthorutylist.communityauthoritylist[row].cmid

    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return function.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.imageView?.image = UIImage(named: functionimg[indexPath.row])
        cell.textLabel?.text = function[indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.accessoryType = .disclosureIndicator
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        cell.imageView?.frame.size = CGSize(width: 50, height: 50)
        if indexPath.row != (function.count - 1){
            let lineview = UIView(frame: CGRect(x: 10, y: 94.5, width: tableview.frame.width - 20, height: 0.5))
            lineview.backgroundColor = UIColor.lightGray
            cell.addSubview(lineview)
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95
    }
}

