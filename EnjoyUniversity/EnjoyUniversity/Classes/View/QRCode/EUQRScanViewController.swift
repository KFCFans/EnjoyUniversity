//
//  EUQRCodeScanViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/3/7.
//  Copyright © 2017年 lip. All rights reserved.
//


import UIKit
import AVFoundation

class EUQRScanViewController: EUBaseViewController,AVCaptureMetadataOutputObjectsDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    //相机显示视图
    let cameraView = EUScannerBackgroundView(frame: UIScreen.main.bounds)
    
    
    let captureSession = AVCaptureSession()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black
        self.tableview.removeFromSuperview()
        //设置导航栏
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(EUQRScanViewController.selectPhotoFormPhotoLibrary(_:)))
        navitem.rightBarButtonItem = barButtonItem
        navitem.title = "扫一扫"
        
        if navitem.leftBarButtonItem == nil {
            let leftBtn = UIBarButtonItem(image: UIImage(named: "nav_back"), style: .plain, target: nil, action: #selector(dismissController))
            navitem.leftBarButtonItem = leftBtn
        }
        
        view.insertSubview(cameraView, belowSubview: navbar)
        
        //初始化捕捉设备（AVCaptureDevice），类型AVMdeiaTypeVideo
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
        
        let input :AVCaptureDeviceInput
        
        //创建媒体数据输出流
        let output = AVCaptureMetadataOutput()
        
        //捕捉异常
        do{
            //创建输入流
            input = try AVCaptureDeviceInput(device: captureDevice)
            
            //把输入流添加到会话
            captureSession.addInput(input)
            
            //把输出流添加到会话
            captureSession.addOutput(output)
        }catch {
            print("异常")
        }
        
        //创建串行队列
        let dispatchQueue = DispatchQueue(label: "queue", attributes: [])
        
        //设置输出流的代理
        output.setMetadataObjectsDelegate(self, queue: dispatchQueue)
        
        //设置输出媒体的数据类型
        output.metadataObjectTypes = NSArray(array: [AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]) as [AnyObject]
        
        //创建预览图层
        let videoPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        //设置预览图层的填充方式
        videoPreviewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        //设置预览图层的frame
        videoPreviewLayer?.frame = cameraView.bounds
        
        //将预览图层添加到预览视图上
        cameraView.layer.insertSublayer(videoPreviewLayer!, at: 0)
        
        //设置扫描范围
        output.rectOfInterest = CGRect(x: 0.2, y: 0.2, width: 0.6, height: 0.6)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.tabBarController?.tabBar.isHidden = true
        self.scannerStart()
    }
    
    func scannerStart(){
        captureSession.startRunning()
        cameraView.scanning = "start"
    }
    
    func scannerStop() {
        captureSession.stopRunning()
        cameraView.scanning = "stop"
    }
    
    
    //扫描代理方法
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        if metadataObjects != nil && metadataObjects.count > 0 {
            let metaData : AVMetadataMachineReadableCodeObject = metadataObjects.first as! AVMetadataMachineReadableCodeObject
            
            DispatchQueue.main.async(execute: {
                // 结果处理
                SwiftyProgressHUD.showLoadingHUD()
            })
            
            let result = metaData.stringValue
            let infosegment = result?.components(separatedBy: "?").last
            let info = infosegment?.components(separatedBy: "&") ?? []
            
            if info.count == 1{
                let resultinfo = info.first ?? ""
                    
                if resultinfo.hasPrefix("avid="){
                     captureSession.stopRunning()
                    guard let avid = Int(resultinfo.substring(from: "avid=".endIndex)) else{
                        SwiftyProgressHUD.showFaildHUD(text: "二维码错误", duration: 1)
                        return
                    }
                    let vc = EUActivityViewController()
                    SwiftyProgressHUD.showLoadingHUD()
                    EUNetworkManager.shared.getActivityInfoByID(avid: avid, completion: { (isSuccess, viewmodel) in
                        SwiftyProgressHUD.hide()
                        if !isSuccess{
                            SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                            return
                        }
                        guard let viewmodel = viewmodel else{
                            SwiftyProgressHUD.showFaildHUD(text: "加载失败", duration: 1)
                            return
                        }
                        vc.viewmodel = viewmodel
                        self.navigationController?.pushViewController(vc, animated: true)
                    })
                    
                        
                    }else if resultinfo.hasPrefix("cmid="){
                    
                    captureSession.stopRunning()
                    guard let cmid = Int(resultinfo.substring(from: "cmid=".endIndex)) else{
                        SwiftyProgressHUD.showFaildHUD(text: "二维码错误", duration: 1)
                        return
                    }
                    let vc = EUCommunityInfoViewController()
                    SwiftyProgressHUD.showLoadingHUD()
                    EUNetworkManager.shared.getCommunityInfoByID(cmid: cmid, completion: { (isSuccess, viewmodel) in
                        SwiftyProgressHUD.hide()
                        if !isSuccess{
                            SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                            return
                        }
                        guard let viewmodel = viewmodel else{
                            SwiftyProgressHUD.showFaildHUD(text: "加载失败", duration: 1)
                            return
                        }
                        vc.viewmodel = viewmodel
                        self.navigationController?.pushViewController(vc, animated: true)
                        
                    })

                    
                }
            }else if info.count == 2{
                
                let resultinfo1 = info.first ?? ""
                let resultinfo2 = info.last ?? ""
                
                var avid = ""
                var code = ""
                if resultinfo1.hasPrefix("avid="){
                    captureSession.stopRunning()
                    avid = resultinfo1.substring(from: "avid=".endIndex)
                    code = resultinfo2.substring(from: "code=".endIndex)
                    print("avid\(avid)code\(code)")
                }else if resultinfo2.hasPrefix("avid="){
                    captureSession.stopRunning()
                    code = resultinfo1.substring(from: "avid=".endIndex)
                    avid = resultinfo2.substring(from: "code=".endIndex)
                    print("avid\(avid)code\(code)")
                    }
                
                EUNetworkManager.shared.participateActivityRegist(avid: Int(avid) ?? 0, completion: { (netIsSuccess, registIsSuccess) in
                    SwiftyProgressHUD.hide()
                    if !netIsSuccess{
                        SwiftyProgressHUD.showFaildHUD(text: "网络异常", duration: 1)
                        return
                    }
                    if !registIsSuccess{
                        SwiftyProgressHUD.showWarnHUD(text: "您已签到", duration: 1)
                        return
                    }
                    SwiftyProgressHUD.showSuccessHUD(duration: 1)
                    _ =  self.navigationController?.popViewController(animated: true)
                    
                })
                
                }
            
            
//            captureSession.stopRunning()
        }
        
    }
    
    //从相册中选择图片
    func selectPhotoFormPhotoLibrary(_ sender : AnyObject){
        let picture = UIImagePickerController()
        picture.sourceType = UIImagePickerControllerSourceType.photoLibrary
        picture.delegate = self
        self.present(picture, animated: true, completion: nil)
        
    }
    
    //选择相册中的图片完成，进行获取二维码信息
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage]
        
        let imageData = UIImagePNGRepresentation(image as! UIImage)
        
        let ciImage = CIImage(data: imageData!)
        
        let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyLow])
        
        let array = detector?.features(in: ciImage!)
        
        let result : CIQRCodeFeature = array!.first as! CIQRCodeFeature
        

        // 结果处理
        
       
        picker.dismiss(animated: true, completion: nil)
        print(result.messageString ?? String())
        
    }
}

// MARK: - 监听方法
extension EUQRScanViewController{
    
    @objc fileprivate func dismissController(){
        dismiss(animated: true, completion: nil)
    }
    
}
