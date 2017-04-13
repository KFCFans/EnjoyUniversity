//
//  EURegisterViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/13.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EURegisterViewController: UIViewController {
    
    /// 隐藏状态栏
    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    /// 提示用户验证码不正确
    let correctcodelabel = UILabel()
    
    /// 没什么作用，代码写炸了
    let scal:CGFloat = 2
    
    /// 签到码
    var registerCode = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCodeUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// MARK: - UI 相关方法
extension EURegisterViewController{
    
    fileprivate func setupCodeUI(){
        
        let codeview = UIView(frame: CGRect(origin: CGPoint.zero, size: view.frame.size))
        codeview.backgroundColor = UIColor.white
        view.backgroundColor = UIColor.white
        view.addSubview(codeview)
        
        let phoneimg = UIImageView(image: UIImage(named: "av_useregister"))
        codeview.addSubview(phoneimg)
        
        let firstlabel = UILabel()
        firstlabel.text = "输入签到码"
        firstlabel.textColor = UIColor.init(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        firstlabel.font = UIFont.boldSystemFont(ofSize: 24)
        firstlabel.sizeToFit()
        codeview.addSubview(firstlabel)

        correctcodelabel.text = "签到码错误"
        correctcodelabel.textColor = UIColor.init(red: 1, green: 82/255, blue: 93/255, alpha: 1)
        correctcodelabel.font = UIFont.boldSystemFont(ofSize: 10)
        correctcodelabel.sizeToFit()
        correctcodelabel.isHidden = true
        codeview.addSubview(correctcodelabel)
        
        let verifycode = SwiftyVerificationCodeView(frame: CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 50))
        verifycode.delegate = self
        codeview.addSubview(verifycode)
        
        let backBtn = UIButton(frame: CGRect(x: 10, y: 18, width: 18, height: 18))
        backBtn.setImage(UIImage(named: "login_back"), for: .normal)
        backBtn.addTarget(nil, action: #selector(didClickBackBtn), for: .touchUpInside)
        codeview.addSubview(backBtn)
        
        let scanBtn = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 28, y: 18, width: 18, height: 18))
        scanBtn.setImage(UIImage(named: "av_useregisterscan"), for: .normal)
        scanBtn.addTarget(nil, action: #selector(startQRCodeScanner), for: .touchUpInside)
        codeview.addSubview(scanBtn)
        
        // 自动布局
        phoneimg.translatesAutoresizingMaskIntoConstraints = false
        firstlabel.translatesAutoresizingMaskIntoConstraints = false
        correctcodelabel.translatesAutoresizingMaskIntoConstraints = false
        verifycode.translatesAutoresizingMaskIntoConstraints = false
        
        codeview.addConstraint(NSLayoutConstraint(item: phoneimg,
                                                  attribute: .top,
                                                  relatedBy: .equal,
                                                  toItem: codeview,
                                                  attribute: .top,
                                                  multiplier: 1.0,
                                                  constant: 53))
        codeview.addConstraint(NSLayoutConstraint(item: phoneimg,
                                                  attribute: .centerX,
                                                  relatedBy: .equal,
                                                  toItem: codeview,
                                                  attribute: .centerX,
                                                  multiplier: 1.0,
                                                  constant: 0))
        // 输入验证码
        codeview.addConstraint(NSLayoutConstraint(item: firstlabel,
                                                  attribute: .top,
                                                  relatedBy: .equal,
                                                  toItem: phoneimg,
                                                  attribute: .bottom,
                                                  multiplier: 1.0,
                                                  constant: 12 * scal))
        codeview.addConstraint(NSLayoutConstraint(item: firstlabel,
                                                  attribute: .centerX,
                                                  relatedBy: .equal,
                                                  toItem: codeview,
                                                  attribute: .centerX,
                                                  multiplier: 1.0,
                                                  constant: 0))
        // 验证码错误
        codeview.addConstraint(NSLayoutConstraint(item: correctcodelabel,
                                                  attribute: .top,
                                                  relatedBy: .equal,
                                                  toItem: firstlabel,
                                                  attribute: .bottom,
                                                  multiplier: 1.0,
                                                  constant: 6 * scal))
        codeview.addConstraint(NSLayoutConstraint(item: correctcodelabel,
                                                  attribute: .centerX,
                                                  relatedBy: .equal,
                                                  toItem: codeview,
                                                  attribute: .centerX,
                                                  multiplier: 1.0,
                                                  constant: 0))
        // 验证码输入框
        codeview.addConstraints([NSLayoutConstraint(item: verifycode,
                                                    attribute: .top,
                                                    relatedBy: .equal,
                                                    toItem: correctcodelabel,
                                                    attribute: .bottom,
                                                    multiplier: 1.0,
                                                    constant: 15 * scal),
                                 NSLayoutConstraint(item: verifycode,
                                                    attribute: .centerX,
                                                    relatedBy: .equal,
                                                    toItem: codeview,
                                                    attribute: .centerX,
                                                    multiplier: 1.0,
                                                    constant: 0)])
        verifycode.addConstraints([NSLayoutConstraint(item: verifycode,
                                                      attribute: .width,
                                                      relatedBy: .equal,
                                                      toItem: nil,
                                                      attribute: .notAnAttribute,
                                                      multiplier: 1.0,
                                                      constant: UIScreen.main.bounds.width),
                                   NSLayoutConstraint(item:  verifycode,
                                                      attribute: .height,
                                                      relatedBy: .equal,
                                                      toItem: nil,
                                                      attribute: .notAnAttribute,
                                                      multiplier: 1.0,
                                                      constant: 50)])
    }
}

// MARK: - 监听方法
extension EURegisterViewController{
    
    @objc fileprivate func didClickBackBtn(){
        _ = navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func startQRCodeScanner(){
        navigationController?.pushViewController(EUQRScanViewController(), animated: true)
    }
    
}

extension EURegisterViewController:SwiftyVerificationCodeViewDelegate{
        
    func verificationCodeDidFinishedInput(verificationCodeView: SwiftyVerificationCodeView, code: String) {
        
    }
}
