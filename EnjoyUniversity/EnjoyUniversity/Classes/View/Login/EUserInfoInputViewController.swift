//
//  EUserInfoInputView.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/7.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUserInfoInputViewController: EUBaseViewController {
    
    let userinfotitle = ["头像","昵称","性别","姓名","学号","专业","入学年份"]

    /// 头像视图
    let logoimgview = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width - 95, y: 10, width: 50, height: 50))
    
    /// 头像
    var userlogo:UIImage?
    
    /// 用户手机号
    var phone:String?
    
    /// 用户密码
    var password:String?
    
    /// 入学年份选择器是否打开
    var gradePickerIsOpen:Bool = false
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
        navitem.title = "个人信息"
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        
        let rightbtn = UIBarButtonItem(title: "提交", style: .done, target: nil, action: #selector(commitUserInfo))
        navitem.rightBarButtonItem = rightbtn

        setupInputUI()
    }
    

}

// MARK: - UI 相关方法
extension EUserInfoInputViewController{
    
    fileprivate func setupInputUI(){

        navitem.title = "填写个人资料"
        let rightBtn = UIBarButtonItem(title: "提交", style: .plain, target: nil, action: #selector(commitUserInfo))
        
        let backBtn = UIBarButtonItem(image: UIImage(named: "nav_back"), style: .plain, target: nil, action: #selector(back))

        navitem.rightBarButtonItem = rightBtn
        navitem.leftBarButtonItem = backBtn
        tableview.contentInset = UIEdgeInsets(top: 64, left: 0, bottom: 0, right: 0)
        
        // 去除底部多余分割线
        tableview.tableFooterView = UIView()
        
    }
    
}

// MARK: - 实现代理方法
extension EUserInfoInputViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate,SwiftyGradePickerDelegate{
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userinfotitle.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.textLabel?.text = userinfotitle[indexPath.row]
        cell.accessoryType = .disclosureIndicator
        
            switch indexPath.row {
            case 0:
                
                logoimgview.image = UIImage(named: "profile_templogo")
                logoimgview.layer.masksToBounds = true
                logoimgview.layer.cornerRadius = 25
                cell.addSubview(logoimgview)
                break
            default:
                break
            }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 && indexPath.section == 0{
            return 70
        }
        return 44
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 && indexPath.row == 0{
            
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
        }else if indexPath.row == 2 && indexPath.section == 0{
            
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            let manaction = UIAlertAction(title: "男", style: .default, handler: { (_) in
                tableView.cellForRow(at: indexPath)?.detailTextLabel?.text = "男"
            })
            let womanaction = UIAlertAction(title: "女", style: .default, handler: { (_) in
                tableView.cellForRow(at: indexPath)?.detailTextLabel?.text = "女"
                
            })
            let nosayaction = UIAlertAction(title: "保密", style: .default, handler: { (_) in
                tableView.cellForRow(at: indexPath)?.detailTextLabel?.text = "保密"
                
            })
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alert.addAction(manaction)
            alert.addAction(womanaction)
            alert.addAction(nosayaction)
            alert.addAction(cancel)
            present(alert, animated: true, completion: nil)
            
        }else if indexPath.section == 0 && indexPath.row != 6{
            
            let alert = UIAlertController(title: "修改" + userinfotitle[indexPath.row], message: nil, preferredStyle: .alert)
            alert.addTextField(configurationHandler: { (tv) in
                // 设置textview
                if indexPath.row == 4{
                    tv.keyboardType = .numberPad
                }
            })
            let confirm = UIAlertAction(title: "确定", style: .default, handler: { (_) in
                
                let text = alert.textFields?.first?.text
                if text == nil || text?.characters.count == 0{
                    SwiftyProgressHUD.showFaildHUD(text: "无效输入", duration: 1)
                    return
                }
                tableView.cellForRow(at: indexPath)?.detailTextLabel?.text = text
                
            })
            
            let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alert.addAction(cancel)
            alert.addAction(confirm)
            present(alert, animated: true, completion: nil)
        }else if indexPath.section == 0 && indexPath.row == 6{
            
            if !gradePickerIsOpen {
                gradePickerIsOpen = true
                // 获取当前年份
                let currentdate = Date().timeIntervalSince1970 * 1000
                let currentyear = Int(timeStampToString(timeStamp: "\(currentdate)", formate: "YYYY") ?? "") ?? 0
                var gradeData = [Int]()
                for i in 0...4{
                    gradeData.append(currentyear - i)
                }
                let gradePicker = SwiftyGradePicker(height: 100, gradeData: gradeData)
                gradePicker.delegate = self
                view.addSubview(gradePicker)
            }
        }
        
    }
    
    //选择图片成功后代理
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let resultimg = info[UIImagePickerControllerEditedImage] as? UIImage else{
            return
        }
        
        logoimgview.image = resultimg
        userlogo = resultimg
        picker.dismiss(animated: true, completion: nil)
    }
    
    // 年级选择器
    func swiftyGradePickerdidSelected(swiftyGradePicker: SwiftyGradePicker, grade: Int) {
        gradePickerIsOpen = false
        tableview.cellForRow(at: IndexPath(row: 6, section: 0))?.detailTextLabel?.text = "\(grade)"
    }
    
    func swiftyGradePickerdidCancel(swiftyGradePicker: SwiftyGradePicker) {
        gradePickerIsOpen = false
    }

}


    


//// MARK: - 监听方法
extension EUserInfoInputViewController{
    
    @objc fileprivate func commitUserInfo(){

        guard let nickname = tableview.cellForRow(at: IndexPath(row: 1, section: 0))?.detailTextLabel?.text,
            let sexstirng  = tableview.cellForRow(at: IndexPath(row: 2, section: 0))?.detailTextLabel?.text,
            let name = tableview.cellForRow(at: IndexPath(row: 3, section: 0))?.detailTextLabel?.text,
            let schoolnum = tableview.cellForRow(at: IndexPath(row: 4, section: 0))?.detailTextLabel?.text,
            let grade = Int(tableview.cellForRow(at: IndexPath(row: 6, section: 0))?.detailTextLabel?.text ?? ""),
            let professclass = tableview.cellForRow(at: IndexPath(row: 5, section: 0))?.detailTextLabel?.text else{
                return
        }
        var sex = 0
        switch sexstirng {
        case "男":
            sex = 0
            break
        case "女":
            sex = 1
            break
        default:
            sex = 2
        }
        
        if name.characters.count == 0 || Int(schoolnum) == 0{
            SwiftyProgressHUD.showFaildHUD(text: "信息不全", duration: 1)
            return
        }
        
        let user = UserInfo(uid: Int64(phone!)!, avatar: nil, nickname: nickname, gender: sex, professionclass: professclass, studentid: Int64(schoolnum)!, name: name, grade: grade)
        
        
        
        SwiftyProgressHUD.showLoadingHUD()
        if let userlogo = userlogo {
            EUNetworkManager.shared.uploadPicture(choice: .UserLogo, uploadimg: userlogo, completion: { (isSuccess, address) in
                
                if !isSuccess || address == nil {
                    SwiftyProgressHUD.hide()
                    SwiftyProgressHUD.showFaildHUD(text: "网络错误", duration: 1)
                    return
                }
                // 取图片名，不需要后缀
                let picname = address?.components(separatedBy: ".").first ?? ""
                user.avatar = picname
                EUNetworkManager.shared.createUser(user: user, password: self.password!, completion: { (isSuccess) in
                
                    SwiftyProgressHUD.hide()
                    if !isSuccess {
                        SwiftyProgressHUD.showFaildHUD(text: "网络错误", duration: 1)
                        return
                    }
                    SwiftyProgressHUD.showSuccessHUD(duration: 1)
                    
                    let vc = EUMainViewController()
                    self.present(vc, animated: true, completion: nil)
                    UIApplication.shared.keyWindow?.rootViewController = vc

                })
                
            })
        }else{
            
            EUNetworkManager.shared.createUser(user: user, password: password!, completion: { (isSuccess) in
                
                SwiftyProgressHUD.hide()
                if !isSuccess {
                    SwiftyProgressHUD.showFaildHUD(text: "网络错误", duration: 1)
                    return
                }
                SwiftyProgressHUD.showSuccessHUD(duration: 1)
                
                let vc = EUMainViewController()
                self.present(vc, animated: true, completion: nil)
                UIApplication.shared.keyWindow?.rootViewController = vc
                
            })

        }
        
    }
    
    @objc fileprivate func back(){
        _ = self.navigationController?.popViewController(animated: true)
    }

}




