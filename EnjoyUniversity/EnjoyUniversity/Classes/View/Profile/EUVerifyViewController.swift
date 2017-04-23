//
//  EUVerifyViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/12.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUVerifyViewController: EUBaseViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var verifyImg:UIImage?
    
    let addphotoBtn = UIButton(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 200))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.init(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        tableview.removeFromSuperview()
        navitem.title = "身份认证"
        
        let commmitBtn = UIBarButtonItem(title: "提交", style: .plain, target: nil, action: #selector(commitVerifyInfo))
        navitem.rightBarButtonItem = commmitBtn
        setupUI()
        
    }
    
    
    private func setupUI(){
        
        let warnlabel = UILabel(frame: CGRect(x: 0, y: 64, width: UIScreen.main.bounds.width, height: 24))
        warnlabel.text = "上传校园卡或学生证正面照片"
        warnlabel.textAlignment = .center
        warnlabel.textColor = UIColor.init(red: 1, green: 119/255, blue: 0, alpha: 1)
        view.addSubview(warnlabel)
        
        addphotoBtn.setImage(UIImage(named: "profile_addphoto"), for: .normal)
        addphotoBtn.addTarget(nil, action: #selector(selectVerifyPhoto), for: .touchUpInside)
        addphotoBtn.imageView?.contentMode = .scaleAspectFit
        view.addSubview(addphotoBtn)
        
    }
    
    /// 上传图片
    @objc private func commitVerifyInfo(){
        
        guard let verifyImg = verifyImg else {
            SwiftyProgressHUD.showFaildHUD(text: "请选取图片", duration: 1)
            return
        }
        
        let picname = "\(EUNetworkManager.shared.userAccount.uid)"
        EUNetworkManager.shared.uploadVerifyPicture(name: picname, uploadimg: verifyImg) { (isSuccess) in
            if !isSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                return
            }
            SwiftyProgressHUD.showSuccessHUD(duration: 1)
            _ = self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    /// 选取图片
    @objc private func selectVerifyPhoto(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let pictureaction = UIAlertAction(title: "照片图库", style: .default) { (_) in
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
        let cameraaction = UIAlertAction(title: "拍照", style: .default) { (_) in
            
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
        alert.addAction(cancel)
        alert.addAction(cameraaction)
        alert.addAction(pictureaction)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    //选择图片成功后代理
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let resultimg = info[UIImagePickerControllerOriginalImage] as? UIImage else{
            return
        }
        
        addphotoBtn.setImage(resultimg, for: .normal)
        verifyImg = resultimg
        picker.dismiss(animated: true, completion: nil)
        
        
    }


}
