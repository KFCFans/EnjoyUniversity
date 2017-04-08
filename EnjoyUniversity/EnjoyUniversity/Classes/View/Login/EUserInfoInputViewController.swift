//
//  EUserInfoInputView.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/7.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUserInfoInputViewController: EUBaseViewController {
    
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
        
    }
    
    func createInputCell(title:String,tag:Int)->UITableViewCell{
        
        let cell = UITableViewCell()
        
        let  titlelabel = UILabel(frame: CGRect(x: 17, y: 17.5, width: 100, height: 15))
        titlelabel.text = title
        titlelabel.font = UIFont.boldSystemFont(ofSize: 15)
        titlelabel.sizeToFit()
        cell.addSubview(titlelabel)
        
        let textfield = UITextField(frame: CGRect(x: 80, y: 0, width: UIScreen.main.bounds.width - 97, height: 50))
        textfield.tag = tag
        cell.addSubview(textfield)
        cell.selectionStyle = .none
        
        return cell
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
            
            let logoimg = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width - 66, y: 10, width:30, height: 30))
            logoimg.image = UIImage(named: "login_logo")
            cell.addSubview(logoimg)
            
            let backimg = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width - 22, y: 17, width: 16, height: 16))
            backimg.image = UIImage(named: "login_more")
            cell.selectionStyle = .none
            cell.addSubview(backimg)
            
            cell.addSubview(titlelabel)
            return cell
        case 1:
            return createInputCell(title: "姓名", tag: 1)
        case 2:
            return createInputCell(title: "昵称", tag: 2)
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
            return createInputCell(title: "专业", tag: 4)
        case 5:
            return createInputCell(title: "学号", tag: 5)
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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
                    //设置代理
                    picker.delegate = self
                    //指定图片控制器类型
                    picker.sourceType = UIImagePickerControllerSourceType.camera
                    //弹出控制器，显示界面
                    
                    self.present(picker, animated: true, completion: {
                        () -> Void in
                    })
                }else{
                    print("读取相册错误")
                }
                
            })
            let photoaction = UIAlertAction(title: "手机相册选取", style: .default, handler: { (_) in
                //判断设置是否支持图片库
                if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                    //初始化图片控制器
                    let picker = UIImagePickerController()
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
    
    
}

// MARK: - 监听方法
extension EUserInfoInputViewController{
    
    @objc fileprivate func commitUserInfo(){
        
    }
    
    @objc fileprivate func back(){
        
    }
    
}


