//
//  EUChangeCommunityInfoController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/23.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUChangeCommunityInfoController: EUBaseViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    /// 视图模型，上层传入
    var viewmodel:CommunityViewModel?
    
    /// 社团头像，上层传入
    var communityLogo:UIImage?
    
    /// 头像视图
    let logoimgview = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width - 95, y: 10, width: 50, height: 50))
    
    /// 社团详情
    let detailTextView = UITextView(frame: CGRect(x: 12, y: 0, width: UIScreen.main.bounds.width - 24, height: 150))
    
    /// 社团公告
    let announceTextView = UITextView(frame: CGRect(x: 12, y: 0, width: UIScreen.main.bounds.width - 24, height: 150))
    
    /// 是否修改社团 LOGO
    var logoIsChanged:Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        navitem.title = "修改社团信息"
        
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        
        let rightBtn = UIBarButtonItem(title: "提交", style: .plain, target: nil, action: #selector(commitCommunityInfo))
        navitem.rightBarButtonItem = rightBtn
        
    }
    
    @objc private func commitCommunityInfo(){
        
        guard let announcement = announceTextView.text,let cmdetail = detailTextView.text,let cmid = viewmodel?.communitymodel?.cmid else {
            SwiftyProgressHUD.showBigFaildHUD(text: "请输入完整信息", duration: 1)
            return
        }
        if announcement.characters.count < 1 || cmdetail.characters.count < 1{
            SwiftyProgressHUD.showBigFaildHUD(text: "请输入完整信息", duration: 1)
            return
        }
        
        // 如果有图片
        if logoIsChanged{
            
            SwiftyProgressHUD.showLoadingHUD()
            EUNetworkManager.shared.uploadPicture(choice: .CommunityLogo, uploadimg: logoimgview.image!, completion: { (isSuccess, address) in
                if !isSuccess{
                    SwiftyProgressHUD.hide()
                    SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                    return
                }
                // 取图片名，不需要后缀
                let picname = address?.components(separatedBy: ".").first
                EUNetworkManager.shared.changeCommunityInfo(cmid: cmid, logoname: picname, announcement: announcement, detail: cmdetail, completion: { (isSuccess) in
                    SwiftyProgressHUD.hide()
                    if !isSuccess{
                        SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                        return
                    }
                    SwiftyProgressHUD.showSuccessHUD(duration: 1)
                    _ = self.navigationController?.popViewController(animated: true)
                })
            })
            
        }else{
            EUNetworkManager.shared.changeCommunityInfo(cmid: cmid, logoname: nil, announcement: announcement, detail: cmdetail, completion: { (isSuccess) in
                SwiftyProgressHUD.hide()
                if !isSuccess{
                    SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                    return
                }
                SwiftyProgressHUD.showSuccessHUD(duration: 1)
                _ = self.navigationController?.popViewController(animated: true)
            })
        }
        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 70
        case 1:
            return 200
        case 2:
            return 200
        default:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        if indexPath.section == 0{
            cell.textLabel?.text = "头像"
            logoimgview.layer.masksToBounds = true
            logoimgview.layer.cornerRadius = 25
            logoimgview.image = communityLogo
            cell.addSubview(logoimgview)
        }else if indexPath.section == 1{
            announceTextView.text = viewmodel?.communitymodel?.cmAnnouncement
            announceTextView.font = UIFont.boldSystemFont(ofSize: 15)
            cell.addSubview(announceTextView)
        }else{
            detailTextView.text = viewmodel?.communitymodel?.cmDetail
            detailTextView.font = UIFont.boldSystemFont(ofSize: 15)
            cell.addSubview(detailTextView)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 1:
            return "社团公告"
        case 2:
            return "社团简介"
        default:
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
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
        logoimgview.image = resultimg
        logoIsChanged = true
        picker.dismiss(animated: true, completion: nil)
    }
    
}
