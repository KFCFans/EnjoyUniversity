//
//  EUStartActivityViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/3.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUStartActivityViewController: EUBaseViewController {
    
    /// 解决快速点击时间选择框弹出多个时间选择器
    var isSelectiongTime:Bool = false
    
    /// 是否为修改活动内容
    var isUpdateActivityInfo = false
    
    /// 活动 ID
    var avid:Int?
    
    /// 三个时间
    let startimelabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width - 154, y: 21, width: 240, height: 14))
    let endtimelabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width - 154, y: 21, width: 240, height: 14))
    let stoptimelabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width - 154, y: 21, width: 240, height: 14))
    
    /// 添加图片按钮
    let addPicBtn = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
    
    /// 活动名称
    let activityName = UITextField(frame: CGRect(x: 42, y: 18, width: UIScreen.main.bounds.width - 52, height: 20))
    
    /// 活动详情
    let activityDetail = SwiftyTextView(frame: CGRect(x: 16, y: 15, width: UIScreen.main.bounds.width - 32, height: 145), textContainer: nil, placeholder: "填写活动描述，让更多的人参与活动...")
    
    /// 活动地点
    let activityPlace = UITextField(frame: CGRect(x: 42, y: 18, width: UIScreen.main.bounds.width - 52, height: 20))

    /// 活动人数
    let activityNum = UITextField(frame: CGRect(x: 42, y: 18, width: UIScreen.main.bounds.width - 52, height: 20))
    
    /// 活动价格
    let activityPrice = UITextField(frame: CGRect(x: 42, y: 18, width: UIScreen.main.bounds.width - 52, height: 20))

    /// 是否开始招新
    let needResisterSwitch = UISwitch()
    
    /// 需要上传的图片
    var uploadImg:UIImage?
    
    /// 当前时间
    let currenttime = Int(Date().timeIntervalSince1970 * 1000).description
    
    /// 缓存时间，解决滚动后失去时间
    var startime = timeStampToString(timeStamp: Int(Date().timeIntervalSince1970 * 1000).description, formate: "YYYY-MM-dd HH:mm")
    var endtime = timeStampToString(timeStamp: Int(Date().timeIntervalSince1970 * 1000).description, formate: "YYYY-MM-dd HH:mm")
    var stoptime = timeStampToString(timeStamp: Int(Date().timeIntervalSince1970 * 1000).description, formate: "YYYY-MM-dd HH:mm")

    /// 是否自动设置报名截止时间
    var autoSetStopTime:Bool = true
    
    let INPUTCELL = "EUINPUTCELL"


    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    


}

// MARK: - UI 相关方法
extension EUStartActivityViewController{
    
    // 父类方法设置为了 fileprivate ，子类无法继承
    fileprivate func setupUI(){
        
        tableview.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: INPUTCELL)
        
        tableview.keyboardDismissMode = .onDrag
        
        //添加一个UITableViewController
        let tableVC = UITableViewController.init(style: .plain)
        tableVC.tableView = self.tableview
        self.addChildViewController(tableVC)
        
        
        // 点击添加图片
        addPicBtn.backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        addPicBtn.addTarget(nil, action: #selector(selectActivityPicture), for: .touchUpInside)
        if addPicBtn.imageView?.image == nil{
            addPicBtn.setImage(UIImage(named: "sav_start"), for: .normal)
        }
        
        tableview.tableHeaderView = addPicBtn

    }
    
    // 重写父类方法
    override func setupNavBar() {
        
        super.setupNavBar()
        
        navitem.title = "发布活动"
        
        let leftBtn = UIBarButtonItem(title: "取消", style: .plain, target: nil, action: #selector(dissmissController))
        navitem.leftBarButtonItem = leftBtn
        
        let rightBtn = UIBarButtonItem(title: "发布", style: .plain, target: nil, action: #selector(commitActivityToServer))
        navitem.rightBarButtonItem = rightBtn
    }
    
}

// MARK: - 代理相关方法
extension EUStartActivityViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate,SwiftyPhotoClipperDelegate{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 2
        case 4:
            return 3
        default:
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: INPUTCELL) ?? UITableViewCell()
        
        if indexPath.section == 0 {
            if indexPath.row == 0{
                
                let imgview = UIImageView(frame: CGRect(x: 12, y: 18, width: 20, height: 20))
                imgview.image = UIImage(named: "sav_activity")
                cell.addSubview(imgview)
                
                activityName.placeholder = "输入活动名称"
                cell.addSubview(activityName)
                
            }
            if indexPath.row == 1 {
                
                
                activityDetail.textColor = UIColor.black
                activityDetail.font = UIFont.boldSystemFont(ofSize: 15)
                cell.addSubview(activityDetail)
            }
        }else if indexPath.section == 1{
            let imgview = UIImageView(frame: CGRect(x: 12, y: 18, width: 20, height: 20))
            imgview.image = UIImage(named: "sav_price")
            cell.addSubview(imgview)
            
            activityPrice.placeholder = "活动价格"
            activityPrice.keyboardType = .decimalPad
            cell.addSubview(activityPrice)
        }else if indexPath.section == 2{
            let imgview = UIImageView(frame: CGRect(x: 12, y: 18, width: 20, height: 20))
            imgview.image = UIImage(named: "sav_place")
            cell.addSubview(imgview)
            
            activityPlace.placeholder = "活动地点"
            cell.addSubview(activityPlace)
        }else if indexPath.section == 3{
            
            let imgview = UIImageView(frame: CGRect(x: 12, y: 18, width: 20, height: 20))
            imgview.image = UIImage(named: "sav_num")
            cell.addSubview(imgview)
            
            activityNum.placeholder = "活动人数(人数不限填0哦)"
            activityNum.keyboardType = .numberPad
            cell.addSubview(activityNum)
            
        }else if indexPath.section == 4{
            
            let moreimgview = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width - 26, y: 21, width: 14, height: 14))
            
            moreimgview.image = UIImage(named: "sav_more")
            cell.addSubview(moreimgview)
            
            let imgview = UIImageView(frame: CGRect(x: 12, y: 18, width: 20, height: 20))
            cell.addSubview(imgview)
            
            let titlelabel = UILabel(frame: CGRect(x: 42, y: 21, width: 100, height: 14))
            titlelabel.font = UIFont.boldSystemFont(ofSize: 14)
            cell.addSubview(titlelabel)
            
            startimelabel.font = UIFont.boldSystemFont(ofSize: 14)
            endtimelabel.font = UIFont.boldSystemFont(ofSize: 14)
            stoptimelabel.font = UIFont.boldSystemFont(ofSize: 14)
            
            // 初始化时使用当前时间
            if indexPath.row == 0 {
                imgview.image = UIImage(named: "sav_startime")
                titlelabel.text = "开始时间"
                startimelabel.text = startime
                cell.addSubview(startimelabel)
            }else if indexPath.row == 1{
                imgview.image = UIImage(named: "sav_endtime")
                titlelabel.text = "结束时间"
                endtimelabel.text = endtime
                cell.addSubview(endtimelabel)
            }else{
                imgview.image = UIImage(named: "sav_stopenroll")
                titlelabel.text = "报名截止时间"
                stoptimelabel.text = stoptime
                cell.addSubview(stoptimelabel)
                
            }
            
            
        }else if indexPath.section == 5{
            
            let imgview = UIImageView(frame: CGRect(x: 12, y: 18, width: 20, height: 20))
            imgview.image = UIImage(named: "sav_register")
            cell.addSubview(imgview)
            
            let titlelabel = UILabel(frame: CGRect(x: 42, y: 21, width: 100, height: 14))
            titlelabel.font = UIFont.boldSystemFont(ofSize: 14)
            titlelabel.text = "是否开启签到"
            titlelabel.font = UIFont.boldSystemFont(ofSize: 14)
            cell.addSubview(titlelabel)
            
            needResisterSwitch.frame.origin = CGPoint(x: UIScreen.main.bounds.width - needResisterSwitch.frame.size.width - 22, y: (56.0 - needResisterSwitch.frame.size.height)/2)
            
            cell.addSubview(needResisterSwitch)
            
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section==0 && indexPath.row == 1 {
            return 145
        }
        return 56
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        super.tableView(tableView, didSelectRowAt: indexPath)
        
        if indexPath.section == 4  {
            // 如果已经处于选择状态，直接返回即可
            if isSelectiongTime {
                return
            }
            isSelectiongTime = true
            let timepicker = SwiftyTimePicker(height: 260)
            view.addSubview(timepicker)
            switch indexPath.row {
            case 0:
                timepicker.getDate(completion: { (ok,date) in
                    self.isSelectiongTime = false
                    if ok {
                        self.startime = date
                        self.startimelabel.text = date
                        
                        self.autoSetStopTime ? self.stoptimelabel.text = date : ()
                    }
                    
                })
            case 1:
                timepicker.getDate(completion: { (ok,date) in

                    self.isSelectiongTime = false
                    if ok {
                        self.endtime = date
                        self.endtimelabel.text = date
                    }

                })
            case 2:
                timepicker.getDate(completion: { (ok,date) in
                    
                    self.isSelectiongTime = false
                    if ok {
                        self.autoSetStopTime = false
                        self.stoptime = date
                        self.stoptimelabel.text = date
                    }

                })
            default:
                return
            }
        }
    }
    
    //／ 相机 和 图片
    //选择图片成功后代理
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let resultimg = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            return
        }
        picker.dismiss(animated: false) {
            let clipper = SwiftyPhotoClipper()
            clipper.img = resultimg
            clipper.delegate = self
            self.present(clipper, animated: true, completion: nil)
        }
    }
    
    func didFinishClippingPhoto(image: UIImage) {
        addPicBtn.setImage(image, for: .normal)
        uploadImg = image
    }


}

// MARK: - 监听方法
extension EUStartActivityViewController{
    
    /// 取消按钮
    @objc fileprivate func dissmissController(){
        _ = navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
    
    /// 选择照片
    @objc fileprivate func selectActivityPicture(){
        
        let alterview = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        
        let carmeraction = UIAlertAction(title: "拍照", style: .default) { (_) in
            
            //判断设置是否支持图片库
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                //初始化图片控制器
                let picker = UIImagePickerController()
                //设置代理
                picker.delegate = self
                //指定图片控制器类型
                picker.sourceType = UIImagePickerControllerSourceType.camera
                //设置是否允许编辑
                picker.allowsEditing = false
                //弹出控制器，显示界面
                self.present(picker, animated: true, completion: nil)
            }
            
        }
        
        let photoaction = UIAlertAction(title: "从相册中选择", style: .default) { (_) in
            //判断设置是否支持图片库
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                //初始化图片控制器
                let picker = UIImagePickerController()
                //设置代理
                picker.delegate = self
                //指定图片控制器类型
                picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                //设置是否允许编辑
                picker.allowsEditing = false
                //弹出控制器，显示界面
                self.present(picker, animated: true, completion: nil)
            }
        }
        
        let cancelaction = UIAlertAction(title: "取消", style: .cancel) { (_) in
            
        }
        
        alterview.addAction(carmeraction)
        alterview.addAction(photoaction)
        alterview.addAction(cancelaction)
        
        self.present(alterview, animated: true, completion: nil)
    }
    
    /// 发布按钮
    @objc fileprivate func commitActivityToServer(){
        
        // 判断
        if !activityName.hasText {
            SwiftyProgressHUD.showFaildHUD(text: "活动标题", duration: 1)
            return
            

        }
        if !activityPlace.hasText {
            SwiftyProgressHUD.showFaildHUD(text: "活动地点", duration: 1)
            return
        }
        
        // 准备上传
        // 非必填信息
        let avNum = Int(activityNum.text ?? "") ?? 0
        let avPrice = Float(activityPrice.text ?? "") ?? Float(0)
        let register = needResisterSwitch.isOn ? 0 : -1
        let avDetail = activityDetail.text
        
        // 一定有值但是要判断逻辑
        let avStartime = stringToTimeStamp(stringTime: startimelabel.text ?? (startime ?? ""))
        let avEndtime = stringToTimeStamp(stringTime: endtimelabel.text ?? (endtime ?? ""))
        let avstoptime = stringToTimeStamp(stringTime: stoptimelabel.text ?? (stoptime ?? ""))
        
        // 必填信息
        let avPlace = activityPlace.text
        let avName = activityName.text
        
        // 时间判断
        if avEndtime <= avStartime || avStartime < currenttime || avstoptime > avStartime{
            
            SwiftyProgressHUD.showFaildHUD(text: "时间错误", duration: 1)
            return
        }
        
        let activity = Activity()
        activity.avTitle = avName
        activity.avDetail = avDetail
        activity.avPrice = avPrice
        activity.avPlace = avPlace
        activity.avExpectnum = avNum
        activity.avStarttime = avStartime
        activity.avEndtime = avEndtime
        activity.avEnrolldeadline = avstoptime
        activity.avRegister = register
        
        SwiftyProgressHUD.showLoadingHUD()
        if let uploadImg = uploadImg{
            EUNetworkManager.shared.uploadPicture(choice: .ActivityLogo,uploadimg: uploadImg, completion: { (isSuccess, address) in
              
                if !isSuccess{
                    SwiftyProgressHUD.hide()
                    SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                    return
                }
                // 取图片名，不需要后缀
                let picname = address?.components(separatedBy: ".").first ?? ""
                activity.avLogo = picname
                
                // 不是修改则直接发布活动
                if !self.isUpdateActivityInfo {
                    EUNetworkManager.shared.releaseActivity(activity: activity) { (isSuccess) in
                        SwiftyProgressHUD.hide()
                        if isSuccess{
                            SwiftyProgressHUD.showSuccessHUD(duration: 1)
                            self.dismiss(animated: true, completion: nil)
                            return
                        }
                        SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                    }
                }else{
                    EUNetworkManager.shared.changeActivity(activity: activity, completion: { (isSuccess, hasPermission) in
                        SwiftyProgressHUD.hide()
                        if !isSuccess{
                            SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                            return
                        }
                        if !hasPermission {
                            SwiftyProgressHUD.showFaildHUD(text: "无权限", duration: 1)
                            return
                        }
                        SwiftyProgressHUD.showSuccessHUD(duration: 1)
                        _ = self.navigationController?.popViewController(animated: true)
                    })
                }
                
            })
        }else{
            activity.avid = avid ?? 0
            if !isUpdateActivityInfo{
                EUNetworkManager.shared.releaseActivity(activity: activity) { (isSuccess) in
                    SwiftyProgressHUD.hide()
                    
                    if isSuccess{
                        SwiftyProgressHUD.showSuccessHUD(duration: 1)
                        self.dismiss(animated: true, completion: nil)
                        return
                    }
                    SwiftyProgressHUD.showFaildHUD(text: "网络错误", duration: 1)
                    
                }
            }else{
                EUNetworkManager.shared.changeActivity(activity: activity, completion: { (isSuccess, hasPermission) in
                    SwiftyProgressHUD.hide()
                    if !isSuccess{
                        SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                        return
                    }
                    if !hasPermission {
                        SwiftyProgressHUD.showFaildHUD(text: "无权限", duration: 1)
                        return
                    }
                    SwiftyProgressHUD.showSuccessHUD(duration: 1)
                    _ = self.navigationController?.popViewController(animated: true)
                })
            }
            
        }
    }
}


