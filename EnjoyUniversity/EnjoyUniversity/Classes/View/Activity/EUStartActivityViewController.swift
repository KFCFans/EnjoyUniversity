//
//  EUStartActivityViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/3.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUStartActivityViewController: EUBaseViewController {
    
    let startimelabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width - 154, y: 21, width: 240, height: 14))
    let endtimelabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width - 154, y: 21, width: 240, height: 14))
    let stoptimelabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width - 154, y: 21, width: 240, height: 14))
    
    let addPicBtn = UIButton(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200))
    
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
        addPicBtn.setImage(UIImage(named: "sav_start"), for: .normal)
        addPicBtn.addTarget(nil, action: #selector(selectActivityPicture), for: .touchUpInside)
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
        case 3:
            return 3
        case 1:
            return 1
        case 2:
            return 1
        case 4:
            return 1
        default:
            return 1
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // 得到 Cell
        let cell = tableview.dequeueReusableCell(withIdentifier: INPUTCELL) ?? UITableViewCell()
        
        if indexPath.section == 0 {
            if indexPath.row == 0{
                
                let imgview = UIImageView(frame: CGRect(x: 12, y: 18, width: 20, height: 20))
                imgview.image = UIImage(named: "sav_activity")
                cell.addSubview(imgview)
                
                let textfield = UITextField(frame: CGRect(x: 42, y: 18, width: UIScreen.main.bounds.width - 52, height: 20))
                textfield.placeholder = "输入活动名称"
                cell.addSubview(textfield)
                
            }
            if indexPath.row == 1 {
                
                let textview = SwiftyTextView(frame: CGRect(x: 16, y: 15, width: UIScreen.main.bounds.width - 32, height: 145), textContainer: nil, placeholder: "填写活动描述，让更多的人参与活动...")
                textview.textColor = UIColor.darkText
                textview.font = UIFont.boldSystemFont(ofSize: 15)
                cell.addSubview(textview)
            }
        }else if indexPath.section == 1 {
            let imgview = UIImageView(frame: CGRect(x: 12, y: 18, width: 20, height: 20))
            imgview.image = UIImage(named: "sav_place")
            cell.addSubview(imgview)
            
            let textfield = UITextField(frame: CGRect(x: 42, y: 18, width: UIScreen.main.bounds.width - 52, height: 20))
            textfield.placeholder = "活动地点"
            cell.addSubview(textfield)
        }else if indexPath.section == 2{
            
            let imgview = UIImageView(frame: CGRect(x: 12, y: 18, width: 20, height: 20))
            imgview.image = UIImage(named: "sav_num")
            cell.addSubview(imgview)
            
            let textfield = UITextField(frame: CGRect(x: 42, y: 18, width: UIScreen.main.bounds.width - 52, height: 20))
            textfield.placeholder = "活动人数(人数不限填0哦)"
            textfield.keyboardType = .numberPad
            cell.addSubview(textfield)
            
        }else if indexPath.section == 3{
            
            let moreimgview = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width - 22, y: 23, width: 10, height: 10))
            
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
            
            //FIXME: - 初始化时使用当前时间
            if indexPath.row == 0 {
                imgview.image = UIImage(named: "sav_startime")
                titlelabel.text = "开始时间"
                startimelabel.text = "2017-04-03 10:00"
                cell.addSubview(startimelabel)
            }else if indexPath.row == 1{
                imgview.image = UIImage(named: "sav_endtime")
                titlelabel.text = "结束时间"
                endtimelabel.text = "2017-04-04 10:00"
                cell.addSubview(endtimelabel)
            }else{
                imgview.image = UIImage(named: "sav_stopenroll")
                titlelabel.text = "报名截止时间"
                stoptimelabel.text = "2017-04-04 10:00"
                cell.addSubview(stoptimelabel)
            }
            
            
        }else if indexPath.section == 4{
            
            let imgview = UIImageView(frame: CGRect(x: 12, y: 18, width: 20, height: 20))
            imgview.image = UIImage(named: "sav_register")
            cell.addSubview(imgview)
            
            let titlelabel = UILabel(frame: CGRect(x: 42, y: 21, width: 100, height: 14))
            titlelabel.font = UIFont.boldSystemFont(ofSize: 14)
            titlelabel.text = "是否开启签到"
            titlelabel.font = UIFont.boldSystemFont(ofSize: 14)
            cell.addSubview(titlelabel)
            
            let switchBtn = UISwitch()
            switchBtn.frame.origin = CGPoint(x: UIScreen.main.bounds.width - switchBtn.frame.size.width - 22, y: (56.0 - switchBtn.frame.size.height)/2)
            switchBtn.isOn = false
            cell.addSubview(switchBtn)
            
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
        if indexPath.section == 3  {
            let timepicker = SwiftyTimePicker(height: 260)
            view.addSubview(timepicker)
            switch indexPath.row {
            case 0:
                timepicker.getDate(completion: { (date) in
                    self.startimelabel.text = date
                })
            case 1:
                timepicker.getDate(completion: { (date) in
                    self.endtimelabel.text = date
                })
            case 2:
                timepicker.getDate(completion: { (date) in
                    self.stoptimelabel.text = date
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
    }


}

// MARK: - 监听方法
extension EUStartActivityViewController{
    
    /// 取消按钮
    @objc fileprivate func dissmissController(){
        dismiss(animated: true, completion: nil)
    }
    
    /// 发布按钮
    @objc fileprivate func commitActivityToServer(){
        
    }
    
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
}


