//
//  EUChangeUserInfoController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/17.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUChangeUserInfoController: EUBaseViewController {
    
    
    let userinfotitle = ["头像","昵称","性别","姓名","学号","专业","入学年份"]
    let securitytitle = ["校友认证","修改密码"]
    
    /// 头像视图
    let logoimgview = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width - 95, y: 10, width: 50, height: 50))
    
    /// 视图模型数据源
    var viewmodel:UserinfoViewModel?
    
    /// 头像
    var logoimg:UIImage?
    
    /// 是否修改了头像
    var logoIsChanged:Bool = false
    
    /// 入学年份选择器是否打开
    var gradePickerIsOpen:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navitem.title = "个人信息"
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        
        let rightbtn = UIBarButtonItem(title: "保存", style: .done, target: nil, action: #selector(changeUserInfo))
        navitem.rightBarButtonItem = rightbtn
        
        let buttonview = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 84))
        buttonview.backgroundColor = UIColor.init(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        tableview.tableFooterView = buttonview
        let outbtn = UIButton(frame: CGRect(x: 10, y: 20, width: buttonview.frame.width - 20, height: 44))
        outbtn.backgroundColor = UIColor.init(red: 1, green: 119/255, blue: 0, alpha: 1)
        outbtn.setTitle("退出登陆", for: .normal)
        outbtn.addTarget(nil, action: #selector(outLogin), for: .touchUpInside)
        buttonview.addSubview(outbtn)
    }
    
    // 判断是否可以修改用户信息
    func canChangeUserInfo()->Bool{
        guard let verifyState = viewmodel?.model?.verified else{
            return true
        }
        if verifyState == 0{
            return true
        }
        SwiftyProgressHUD.showWarnHUD(text: "您已认证", duration: 1)
        return false
    }
    
}

// MARK: - 代理方法
extension EUChangeUserInfoController:UIImagePickerControllerDelegate,UINavigationControllerDelegate,SwiftyGradePickerDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? userinfotitle.count : securitytitle.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        indexPath.section == 0 ? (cell.textLabel?.text = userinfotitle[indexPath.row]) : (cell.textLabel?.text = securitytitle[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        
        if indexPath.section == 0 {
            switch indexPath.row {
            case 0:
                
                logoimgview.image = self.logoimg
                logoimgview.layer.masksToBounds = true
                logoimgview.layer.cornerRadius = 25
                cell.addSubview(logoimgview)
                break
            case 1:
                cell.detailTextLabel?.text = viewmodel?.model?.nickname
                break
            case 2:
                cell.detailTextLabel?.text = viewmodel?.sex
                break
            case 3:
                cell.detailTextLabel?.text = viewmodel?.model?.name
                break
            case 4:
                cell.detailTextLabel?.text = "\(viewmodel?.model?.studentid ?? 0)"
                break
            case 5:
                cell.detailTextLabel?.text = viewmodel?.model?.professionclass
                break
            case 6:
                cell.detailTextLabel?.text = "\(viewmodel?.model?.grade ?? 0)"
            default:
                break
            }
        }else{
            switch  indexPath.row {
            case 0:
                cell.detailTextLabel?.text = viewmodel?.verifyString
                break
            case 1:
                cell.detailTextLabel?.text = "点击更改"
                break
            case 2:
                cell.detailTextLabel?.text = "\(viewmodel?.model?.uid ?? 0)"
            default:
                break
            }
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
            
            if !canChangeUserInfo(){
                return
            }
            
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
            
            if indexPath.row != 1{
                if !canChangeUserInfo(){
                    return
                }
            }
            
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
            
            if !canChangeUserInfo(){
                return
            }
            
            if !gradePickerIsOpen{
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
        
        if indexPath.section == 1{
            switch indexPath.row {
            case 0:
                if viewmodel?.model?.verified == 0{
                    navigationController?.pushViewController(EUVerifyViewController(), animated: true)
                }else{
                    SwiftyProgressHUD.showWarnHUD(text: "您已认证", duration: 1)
                }
                break
            case 1:
                navigationController?.pushViewController(EUChangePasswordController(), animated: true)
                break
            case 2:
                break
            default:
                break
            }
        }

        
    }
    
    //选择图片成功后代理
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let resultimg = info[UIImagePickerControllerEditedImage] as? UIImage else{
            return
        }
        
        logoimgview.image = resultimg
        logoIsChanged = true
        logoimg = resultimg
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

// MARK: - 监听方法
extension EUChangeUserInfoController{
    
    @objc fileprivate func outLogin(){
        
        let alert = UIAlertController(title: "您确定要退出登陆吗?", message: nil, preferredStyle: .alert)
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let confirm = UIAlertAction(title: "退出", style: .destructive) { (_) in
            EUNetworkManager.shared.userAccount.outLogin()
            SwiftyProgressHUD.showSuccessHUD(duration: 1)
            self.present(EULoginViewController(), animated: true, completion: nil)
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        present(alert, animated: true, completion: nil)
    }
    
    @objc fileprivate func changeUserInfo(){
        
        guard let nickname = tableview.cellForRow(at: IndexPath(row: 1, section: 0))?.detailTextLabel?.text,let user = viewmodel?.model,
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
        
        let userinfo = user
        userinfo.nickname = nickname
        userinfo.gender = sex
        userinfo.name = name
        userinfo.studentid = Int64(schoolnum) ?? 0
        userinfo.professionclass = professclass
        userinfo.grade = grade
        
        if logoIsChanged && logoimg != nil{
            // 上传头像
            SwiftyProgressHUD.showLoadingHUD()
            EUNetworkManager.shared.uploadPicture(choice: .UserLogo, uploadimg: logoimg!, completion: { (isSuccess, address) in
                
                if !isSuccess{
                    SwiftyProgressHUD.hide()
                    SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                    return
                }
                // 取图片名，不需要后缀
                let picname = address?.components(separatedBy: ".").first ?? ""
                userinfo.avatar = picname
                EUNetworkManager.shared.updateUserInfo(user: userinfo, completion: { (isSuccess) in
                    SwiftyProgressHUD.hide()
                    if !isSuccess{
                        SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                        return
                    }
                    SwiftyProgressHUD.showSuccessHUD(duration: 1)
                    self.viewmodel?.model = userinfo
                    self.viewmodel?.reloadData()
                    _ = self.navigationController?.popViewController(animated: true)
                })
                
            })
            
        }else{
            SwiftyProgressHUD.showLoadingHUD()
            EUNetworkManager.shared.updateUserInfo(user: userinfo, completion: { (isSuccess) in
                SwiftyProgressHUD.hide()
                if !isSuccess{
                    SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                    return
                }
                SwiftyProgressHUD.showSuccessHUD(duration: 1)
                self.viewmodel?.model = userinfo
                self.viewmodel?.reloadData()
                _ = self.navigationController?.popViewController(animated: true)
            })
        }
        
    }
    

    
}
