//
//  EUChangeUserInfoController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/17.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUChangeUserInfoController: EUBaseViewController {
    
    
    let userinfotitle = ["头像","昵称","性别","姓名","学号","专业","个人简介"]
    let securitytitle = ["校友认证","修改密码","更改手机号"]
    
    /// 头像视图
    let logoimgview = UIImageView(frame: CGRect(x: 280, y: 10, width: 50, height: 50))
    
    /// 视图模型数据源
    var viewmodel:UserinfoViewModel?
    
    /// 头像
    var logoimg:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navitem.title = "个人信息"
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        
        let buttonview = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 84))
        buttonview.backgroundColor = UIColor.init(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        tableview.tableFooterView = buttonview
        let outbtn = UIButton(frame: CGRect(x: 10, y: 20, width: buttonview.frame.width - 20, height: 44))
        outbtn.backgroundColor = UIColor.init(red: 1, green: 119/255, blue: 0, alpha: 1)
        outbtn.setTitle("退出登陆", for: .normal)
        outbtn.addTarget(nil, action: #selector(outLogin), for: .touchUpInside)
        buttonview.addSubview(outbtn)
    }
    
}

// MARK: - 代理方法
extension EUChangeUserInfoController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
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
                cell.detailTextLabel?.text = "点击修改"
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
        guard let resultimg = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            return
        }
        
        logoimgview.image = resultimg
        picker.dismiss(animated: true, completion: nil)
        
        
    }
}

// MARK: - 监听方法
extension EUChangeUserInfoController{
    
    @objc fileprivate func outLogin(){
        
        EUNetworkManager.shared.userAccount.outLogin()
        SwiftyProgressHUD.showSuccessHUD(duration: 1)
        present(EULoginViewController(), animated: true, completion: nil)
        
        
    }
    
}
