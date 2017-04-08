//
//  EUserInfoInputView.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/7.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUserInfoInputViewController: EUBaseViewController {

    /// 头像视图
    let logoimg = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width - 66, y: 10, width:30, height: 30))

    
    fileprivate let LOGININPUTCELL = "LOGININPUTCELL"
    override func viewDidLoad(){
        super.viewDidLoad()
        setupInputUI()
    }
    

}

// MARK: - UI 相关方法
extension EUserInfoInputViewController{
    
    fileprivate func setupInputUI(){

        navitem.title = "填写个人资料"
        let rightBtn = UIBarButtonItem(title: "提交", style: .plain, target: nil, action: #selector(commitUserInfo))
        
        let backBtn = UIBarButtonItem(image: UIImage(named: "nav_back"), style: .plain, target: nil, action: nil)

        navitem.rightBarButtonItem = rightBtn
        navitem.leftBarButtonItem = backBtn
        tableview.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        
        // 去除底部多余分割线
        tableview.tableFooterView = UIView()
        
    }
    
}

// MARK: - 实现代理方法
extension EUserInfoInputViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let cell = UITableViewCell()
            let  titlelabel = UILabel(frame: CGRect(x: 17, y: 17.5, width: 100, height: 15))
            titlelabel.text = "头像"
            titlelabel.font = UIFont.boldSystemFont(ofSize: 15)
            titlelabel.sizeToFit()
            
            logoimg.image = UIImage(named: "login_logo")
            cell.addSubview(logoimg)
            
            let backimg = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width - 22, y: 17, width: 16, height: 16))
            backimg.image = UIImage(named: "login_more")
            backimg.layer.masksToBounds = true
            cell.addSubview(backimg)
            
            cell.addSubview(titlelabel)
            return cell
        case 1:
            return EUserInfoInputCell(title: "姓名", reuseIdentifier: nil, tag: 1,placeholder: "无法更改，请慎重填写！")
        case 2:
            return EUserInfoInputCell(title: "昵称", reuseIdentifier: nil, tag: 2,placeholder: nil)
        case 3:
            let cell = UITableViewCell()
            let  titlelabel = UILabel(frame: CGRect(x: 17, y: 17.5, width: 100, height: 15))
            titlelabel.text = "性别"
            titlelabel.font = UIFont.boldSystemFont(ofSize: 15)
            titlelabel.sizeToFit()
            cell.selectionStyle = .none
            cell.addSubview(titlelabel)
            let array = ["男","女","保密"]
            let segment = UISegmentedControl(items: array)
            segment.selectedSegmentIndex = 0
            
            segment.frame.origin = CGPoint(x: UIScreen.main.bounds.width - 12 - segment.frame.width, y: (50 - segment.frame.height)/2)
            cell.addSubview(segment)
            return cell
            
        case 4:
            return EUserInfoInputCell(title: "专业", reuseIdentifier: nil, tag: 4,placeholder: nil)
        case 5:
            return EUserInfoInputCell(title: "学号", reuseIdentifier: nil, tag: 6,placeholder: "务必填写真实信息！")
        case 6:
            let cell = UITableViewCell()
            let personaldetail = SwiftyTextView(frame: CGRect(x: 16, y: 15, width: UIScreen.main.bounds.width - 32, height: 145), textContainer: nil, placeholder: "描述你自己...")
            personaldetail.textColor = UIColor.black
            personaldetail.font = UIFont.boldSystemFont(ofSize: 15)
            cell.addSubview(personaldetail)
            cell.addSubview(personaldetail)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 6 {
            return 145
        }
        return 50
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            
            let alter = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let cameraaction = UIAlertAction(title: "拍照", style: .default, handler: { (_) in
                //判断设置是否支持图片库
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    //初始化图片控制器
                    let picker = UIImagePickerController()
                    picker.allowsEditing = true
                    //设置代理
                    picker.delegate = self
                    //指定图片控制器类型
                    picker.sourceType = UIImagePickerControllerSourceType.camera
                    //弹出控制器，显示界面
                    
                    self.present(picker, animated: true, completion: nil)
                }else{
                    print("读取相册错误")
                }
                
            })
            let photoaction = UIAlertAction(title: "手机相册选取", style: .default, handler: { (_) in
                //判断设置是否支持图片库
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                    //初始化图片控制器
                    let picker = UIImagePickerController()
                    picker.allowsEditing = true
                    //设置代理
                    picker.delegate = self
                    //指定图片控制器类型
                    picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                    //弹出控制器，显示界面
                    self.present(picker, animated: true, completion: {
                        () -> Void in
                    })
                }else{
                    print("读取相册错误")
                }
            })
            let cancelaction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            
            alter.addAction(cameraaction)
            alter.addAction(photoaction)
            alter.addAction(cancelaction)
            
            self.present(alter, animated: true, completion: nil)
            
        }
        
    }
    
    //选择图片成功后代理
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let resultimg = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            return
        }
        
        logoimg.image = resultimg
        logoimg.layer.cornerRadius = 15.0
        logoimg.layer.masksToBounds = true
        picker.dismiss(animated: true, completion: nil)
        
        
    }
}


    


// MARK: - 监听方法
extension EUserInfoInputViewController{
    
    @objc fileprivate func commitUserInfo(){
        
        let name = (tableview.cellForRow(at: IndexPath(row: 1, section: 0)) as? EUserInfoInputCell)
        
    }
    
    @objc fileprivate func back(){
        
    }
    
}

/// 自定义 Cell

class EUserInfoInputCell:UITableViewCell{
    
    init(title:String,reuseIdentifier:String?,tag:Int,placeholder:String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        
        
            let  titlelabel = UILabel(frame: CGRect(x: 17, y: 17.5, width: 100, height: 15))
            titlelabel.text = title
            titlelabel.font = UIFont.boldSystemFont(ofSize: 15)
            titlelabel.sizeToFit()
            addSubview(titlelabel)
            
            let textfield = UITextField(frame: CGRect(x: 80, y: 0, width: UIScreen.main.bounds.width - 97, height: 50))
            textfield.tag = tag
            textfield.placeholder = placeholder
            addSubview(textfield)
            selectionStyle = .none
            
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


