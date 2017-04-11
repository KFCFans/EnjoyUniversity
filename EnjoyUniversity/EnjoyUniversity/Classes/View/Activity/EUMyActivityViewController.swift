//
//  EUMyActivityViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/3/8.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUMyActivityViewController: UIViewController {
    
    // 活动视图模型
    lazy var activitylistviewmodel = ActivityListViewModel()
    
    
    // 屏幕参数
    let swidth = UIScreen.main.bounds.width
    let sheight = UIScreen.main.bounds.height
    
    // 导航栏
    lazy var navbar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
    lazy var navitem = UINavigationItem()
    
    
    // 我参加的活动按钮
    var joinedBtn:UIButton?
    
    // 我创建的活动按钮
    var createdBtn:UIButton?
    
    // 左右滑动视图
    var scrollView:UIScrollView?
    
    // 指示器视图
    var indicatorView:UIScrollView?
    
    // 我参加的活动列表
    var joinedtableView:UITableView?
    
    // 我创建的活动列表
    var createdtableView:UITableView?
    
    // 表格视图 Cell ID
    let EUMYACTIITYCELLID = "EUMYACTIVITYCELL"
    
    // 下拉刷新指示器
    let joinedIndicator = EURefreshControl()
    let createdIndicator = EURefreshControl()
    
    let indicator = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width / 2, height: 2))
    
    // 是否为第一页判断
    var isFirstPageSelected = true{
        didSet{
            
            joinedBtn?.isSelected = isFirstPageSelected
            createdBtn?.isSelected = !isFirstPageSelected
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        loadParticipatedActivityData()
        loadCreatedActivityData()
        setupNavBar()
        setupUI()
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 勉强解决
    override func viewWillAppear(_ animated: Bool) {
        
        joinedtableView?.reloadData()
        if !isFirstPageSelected {
            indicatorView?.setContentOffset(CGPoint(x: -swidth/2, y: 0), animated: false)
            scrollView?.setContentOffset(CGPoint(x: swidth, y: scrollView?.contentOffset.y ?? 44), animated: false)

        }
    }
    
    /// 从其他控制器跳转过来选择页面
    func shouldSelectFirstPage(bool:Bool){
       
        if !bool {
            
            isFirstPageSelected = false
        }
        
    }
    
    // 加载我参加的活动数据
    func loadParticipatedActivityData(){
        joinedIndicator.beginRefreshing()
        activitylistviewmodel.loadParticipatdActivity { (needRefresh) in
            if needRefresh{
                self.joinedtableView?.reloadData()
                self.joinedIndicator.endRefreshing()
            }
        }
        
    }
    
    // 加载我创建的活动数据
    func loadCreatedActivityData(){
        createdIndicator.beginRefreshing()
        activitylistviewmodel.loadCreatedActivity { (needRefresh) in
            if needRefresh{
                self.createdtableView?.reloadData()
                self.createdIndicator.endRefreshing()
            }
        }
    }
    
    
    

}

// MARK: - UI 相关方法
extension EUMyActivityViewController{
 
    
    /// 设置导航栏
    func setupNavBar(){
        
        // 利用核心绘图创建背景图片
        let img = createImage(size: CGSize(width: swidth, height: 64), color: UIColor.red)  //#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        // 设置导航栏背景图片
        navbar.setBackgroundImage(img, for: .default)
        navbar.shadowImage = UIImage()
        
        view.addSubview(navbar)
        
        // 设置 NavigationBar 标题颜色
        navbar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        
        // 设置 NavigationBar 按钮颜色
        navbar.tintColor = UIColor.white
        
        navbar.items = [navitem]
        
        navitem.title = "我的活动"
        
        if navitem.leftBarButtonItem == nil {
            let btn =  UIBarButtonItem(image: UIImage(named: "nav_back"), style: .plain, target: nil, action: #selector(dismissController))
            navitem.leftBarButtonItem = btn
        }
        
    }

    /// 设置 UI
    func setupUI(){
        
        // 初始化组件
        view.backgroundColor = UIColor.white
        joinedBtn = UIButton(frame: CGRect(x: 0, y: 64, width: swidth / 2, height: 40))
        createdBtn = UIButton(frame: CGRect(x: swidth / 2, y: 64, width: swidth / 2, height: 40))
        indicatorView = UIScrollView(frame: CGRect(x: 0, y: 104, width: swidth, height: 2))
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 106, width: swidth, height: sheight))
        joinedtableView = UITableView(frame: CGRect(x: 0, y: 0, width: swidth, height: sheight))
        createdtableView = UITableView(frame: CGRect(x: swidth, y: 0, width: swidth, height: sheight))
        
        // 解包
        guard let joinedBtn = joinedBtn,let createdBtn = createdBtn,let indicatorView = indicatorView,
              let scrollView = scrollView,let joinedtableView = joinedtableView,let createdtableView = createdtableView else {
            return
        }
        
        // 设置组件
        joinedBtn.setTitle("我参加的", for: .normal)
        createdBtn.setTitle("我创建的", for: .normal)
        joinedBtn.setTitleColor(UIColor.black, for: .normal)
        createdBtn.setTitleColor(UIColor.black, for: .normal)
        joinedBtn.setTitleColor(UIColor.orange, for: .highlighted)
        joinedBtn.setTitleColor(UIColor.orange, for: .selected)
        createdBtn.setTitleColor(UIColor.orange, for: .highlighted)
        createdBtn.setTitleColor(UIColor.orange, for: .selected)
        joinedBtn.addTarget(nil, action: #selector(didClickJoinedBtn), for: .touchUpInside)
        createdBtn.addTarget(nil, action: #selector(didClickCreatedBtn), for: .touchUpInside)
        joinedBtn.isSelected = true
        view.addSubview(joinedBtn)
        view.addSubview(createdBtn)
        
        scrollView.contentSize = CGSize(width: swidth * 2, height: sheight)
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        let nib = UINib(nibName: "EUActivityCell", bundle: nil)
        joinedtableView.register(nib, forCellReuseIdentifier: EUMYACTIITYCELLID)
        createdtableView.register(nib, forCellReuseIdentifier: EUMYACTIITYCELLID)
        joinedtableView.estimatedRowHeight = 80.0
        joinedtableView.rowHeight = UITableViewAutomaticDimension
        createdtableView.estimatedRowHeight = 80.0
        createdtableView.rowHeight = UITableViewAutomaticDimension
        joinedtableView.separatorStyle = .none
        createdtableView.separatorStyle = .none
        joinedtableView.delegate = self
        joinedtableView.dataSource = self
        createdtableView.delegate = self
        createdtableView.dataSource = self

        joinedtableView.tag = 0
        createdtableView.tag = 1
        scrollView.addSubview(joinedtableView)
        scrollView.addSubview(createdtableView)
        
        
        indicator.backgroundColor = UIColor.green
        indicatorView.contentSize = CGSize(width: swidth , height: 2)
        indicatorView.addSubview(indicator)
        view.addSubview(indicatorView)
       
        // 添加指示器
        joinedtableView.addSubview(joinedIndicator)
        createdtableView.addSubview(createdIndicator)
        
        // 指示器绑定方法
        joinedIndicator.addTarget(nil, action: #selector(loadParticipatedActivityData), for: .valueChanged)
        createdIndicator.addTarget(nil, action: #selector(loadCreatedActivityData), for: .valueChanged)
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        
    }
    
}



// MARK: - 代理方法
extension EUMyActivityViewController:UITableViewDataSource,UITableViewDelegate{
    
    /// 用 tableview 的 Tag 来区分是哪一块的数据 0代表参加的活动 1代表创建的活动
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tableView.tag == 0 ? activitylistviewmodel.participatedlist.count : activitylistviewmodel.createdlist.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: EUMYACTIITYCELLID) as! EUActivityCell
        
        if tableView.tag == 0 {
            cell.activityVM = activitylistviewmodel.participatedlist[indexPath.row]
        }else{
            cell.activityVM = activitylistviewmodel.createdlist[indexPath.row]
        }
        
        return cell
        
    }
    
   
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetX = scrollView.contentOffset.x
        if offsetX > 0 {
            indicatorView?.setContentOffset(CGPoint(x: -offsetX/2, y: indicatorView?.contentOffset.y ?? 44), animated: true)

        }
        if offsetX > swidth / 2 {
            isFirstPageSelected = false
            
        }else if offsetX > 0{
            
            isFirstPageSelected = true
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView.tag == 1 {
            let vc = EUCreatedActivityViewController()
            vc.viewmodel = activitylistviewmodel.createdlist[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            
        }else if tableView.tag == 0{
            
            let vc = EUActivityViewController()
            vc.activityStatus = 1
            vc.row = indexPath.row
            vc.activitylistviewmodel = activitylistviewmodel
            vc.viewmodel = activitylistviewmodel.participatedlist[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
            
            
        }
        
    }
    
    
    
}

// MARK: - 监听方法
extension EUMyActivityViewController{
    
    @objc fileprivate func didClickJoinedBtn(){
        
        if isFirstPageSelected {
            return
        }
        scrollView?.setContentOffset(CGPoint(x: 0, y: scrollView?.contentOffset.y ?? 44), animated: true)
        indicatorView?.setContentOffset(CGPoint(x: 0, y: indicatorView?.contentOffset.y ?? 44), animated: true)
        
        isFirstPageSelected = true
        
        
    }
    
    @objc fileprivate func didClickCreatedBtn(){
        
        if !isFirstPageSelected {
            return
        }
        
        scrollView?.setContentOffset(CGPoint(x: swidth, y: scrollView?.contentOffset.y ?? 44), animated: true)
        indicatorView?.setContentOffset(CGPoint(x: -swidth / 2, y: indicatorView?.contentOffset.y ?? 44), animated: true)
        
        
        isFirstPageSelected = false
        
    }
    
    @objc fileprivate func dismissController(){
        dismiss(animated: true, completion: nil)
    }
    

}
