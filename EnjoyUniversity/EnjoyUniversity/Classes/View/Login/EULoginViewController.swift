//
//  EULoginViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/6.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EULoginViewController: UIViewController {
    
    /// 输入手机号视图
    var phoneview:UIView?
    
    /// 输入验证码视图
    var codeview:UIView?
    
    /// 输入密码视图
    var enterpasswordview:UIView?
    
    /// 设置密码视图
    var setpasswordview:UIView?

    /// 登陆界面，输入手机号
    let phonetextfield = UITextField()
    
    /// 登陆密码，用于登陆
    let passwordtextfield = UITextField()
    
    /// 提示用户验证码不正确
    let correctcodelabel = UILabel()
    
    /// 重发按钮
    let resendBtn = UIButton()
    
    /// 设置的新密码
    let newpasswordtextfield = UITextField()
    
    let scal = UIScreen.main.scale
    
    /// 记录手机号
    var phonenumber:String?
    
    /// 记录手机验证码
    var verifycode:String?
    
    /// 记录新用户还是老用户
    var isOldUser:Bool = true
    
    /// 重发短信计时器
    private var resendtimer:Timer?
    
    /// 重发默认
    var resendtime:Int = 60{
        
        didSet{
            if resendtime <= 0 {
                resendBtn.setTitle("点击重新发送", for: .normal)
                resendBtn.isEnabled = true
                return
            }
            resendBtn.setTitle("\(resendtime)秒后重发", for: .normal)
            
        }
        
    }
    
    /// 隐藏状态栏
    override var prefersStatusBarHidden: Bool{
        return true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        resendtimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateResendTime), userInfo: nil, repeats: true)
        
        phoneview = setupPhoneView(orgin: CGPoint(x: 0, y: 0))
        view.addSubview(phoneview!)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 销毁时钟
    deinit {
        resendtimer?.invalidate()
    }


}

// MARK: - UI 相关方法
extension EULoginViewController{
    
    fileprivate func setupPhoneView(orgin:CGPoint)->UIView{
        
        let phoneview = UIView(frame: CGRect(origin: orgin, size: view.frame.size))
        phoneview.backgroundColor = UIColor.white
        view.backgroundColor = UIColor.white
        
        let phoneimg = UIImageView(image: UIImage(named: "login_phone"))
        phoneview.addSubview(phoneimg)
        
        let firstlabel = UILabel()
        firstlabel.text = "输入手机号"
        firstlabel.textColor = UIColor.init(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        firstlabel.font = UIFont.boldSystemFont(ofSize: 24)
        firstlabel.sizeToFit()
        phoneview.addSubview(firstlabel)
        
        let secondlabel = UILabel()
        secondlabel.text = "为方便通讯，请输入手机号"
        secondlabel.textColor = UIColor.init(red: 132/255, green: 132/255, blue: 132/255, alpha: 1)
        secondlabel.font = UIFont.boldSystemFont(ofSize: 14)
        secondlabel.sizeToFit()
        phoneview.addSubview(secondlabel)
        
        let lineview = UIView()
        lineview.backgroundColor = UIColor.init(red: 200/255, green: 199/255, blue: 204/255, alpha: 1)
        phoneview.addSubview(lineview)
        
        let china = UIImageView(image: UIImage(named: "login_china"))
        phoneview.addSubview(china)
        
        let moreimg = UIImageView(image: UIImage(named: "login_more"))
        phoneview.addSubview(moreimg)
        
        let placelabel = UILabel()
        placelabel.text = "+86"
        placelabel.font = UIFont.boldSystemFont(ofSize: 12)
        placelabel.textColor = UIColor.init(red: 102/255, green: 102/255, blue: 102/255, alpha: 1)
        placelabel.sizeToFit()
        phoneview.addSubview(placelabel)
        
        phonetextfield.keyboardType = .phonePad
        phonetextfield.textColor = UIColor.init(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        phonetextfield.font = UIFont.boldSystemFont(ofSize: 18)
        phonetextfield.borderStyle = .none
        phonetextfield.becomeFirstResponder()
        phoneview.addSubview(phonetextfield)
        
        let nextBtn = UIButton()
        nextBtn.setTitle("下一步", for: .normal)
        nextBtn.setTitleColor(UIColor.init(red: 132/255, green: 132/255, blue: 132/255, alpha: 1), for: .normal)
        nextBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        nextBtn.sizeToFit()
        nextBtn.addTarget(nil, action: #selector(didClickNexTBtn), for: .touchUpInside)
        phoneview.addSubview(nextBtn)
        
        // 自动布局
        phoneimg.translatesAutoresizingMaskIntoConstraints = false
        firstlabel.translatesAutoresizingMaskIntoConstraints = false
        secondlabel.translatesAutoresizingMaskIntoConstraints = false
        lineview.translatesAutoresizingMaskIntoConstraints = false
        china.translatesAutoresizingMaskIntoConstraints = false
        moreimg.translatesAutoresizingMaskIntoConstraints = false
        placelabel.translatesAutoresizingMaskIntoConstraints = false
        phonetextfield.translatesAutoresizingMaskIntoConstraints = false
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        
        
        phoneview.addConstraint(NSLayoutConstraint(item: phoneimg,
                                                   attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: phoneview,
                                                   attribute: .top,
                                                   multiplier: 1.0,
                                                   constant: 53))
        phoneview.addConstraint(NSLayoutConstraint(item: phoneimg,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: phoneview,
                                                   attribute: .centerX,
                                                   multiplier: 1.0,
                                                   constant: 0))
        // 输入手机号
        phoneview.addConstraint(NSLayoutConstraint(item: firstlabel,
                                                  attribute: .top,
                                                  relatedBy: .equal,
                                                  toItem: phoneimg,
                                                  attribute: .bottom,
                                                  multiplier: 1.0,
                                                  constant: 12 * scal))
        phoneview.addConstraint(NSLayoutConstraint(item: firstlabel,
                                                  attribute: .centerX,
                                                  relatedBy: .equal,
                                                  toItem: phoneview,
                                                  attribute: .centerX,
                                                  multiplier: 1.0,
                                                  constant: 0))
        // 为什么要输入手机号
        phoneview.addConstraint(NSLayoutConstraint(item: secondlabel,
                                                   attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: firstlabel,
                                                   attribute: .bottom,
                                                   multiplier: 1.0,
                                                   constant: 6 * scal))
        phoneview.addConstraint(NSLayoutConstraint(item: secondlabel,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: phoneview,
                                                   attribute: .centerX,
                                                   multiplier: 1.0,
                                                   constant: 0))
        // 线
        phoneview.addConstraints([NSLayoutConstraint(item: lineview,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: secondlabel,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: scal * 38),
                                  NSLayoutConstraint(item: lineview,
                                                     attribute: .centerX,
                                                     relatedBy: .equal,
                                                     toItem: phoneview,
                                                     attribute: .centerX,
                                                     multiplier: 1.0,
                                                     constant: 0)])
        lineview.addConstraints([NSLayoutConstraint(item: lineview,
                                                          attribute: .width,
                                                          relatedBy: .equal,
                                                          toItem: nil,
                                                          attribute: .notAnAttribute,
                                                          multiplier: 1.0,
                                                          constant: scal * 130.0),
                                       NSLayoutConstraint(item: lineview,
                                                          attribute: .height,
                                                          relatedBy: .equal,
                                                          toItem: nil,
                                                          attribute: .notAnAttribute,
                                                          multiplier: 1.0,
                                                          constant: 0.5)])
        // 中国 
        phoneview.addConstraints([NSLayoutConstraint(item: china,
                                                     attribute: .left,
                                                     relatedBy: .equal,
                                                     toItem: lineview,
                                                     attribute: .left,
                                                     multiplier: 1.0,
                                                     constant: 0),
                                  NSLayoutConstraint(item: china,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: lineview,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: -scal * 5)])
        china.addConstraints([NSLayoutConstraint(item: china,
                                                    attribute: .width,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1.0,
                                                    constant: scal * 13),
                                 NSLayoutConstraint(item: china,
                                                    attribute: .height,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1.0,
                                                    constant: scal * 9)])
        // 小箭头
        phoneview.addConstraints([NSLayoutConstraint(item: moreimg,
                                                     attribute: .left,
                                                     relatedBy: .equal,
                                                     toItem: china,
                                                     attribute: .right,
                                                     multiplier: 1.0,
                                                     constant: scal * 2),
                                  NSLayoutConstraint(item: moreimg,
                                                     attribute: .centerY,
                                                     relatedBy: .equal,
                                                     toItem: china,
                                                     attribute: .centerY,
                                                     multiplier: 1.0,
                                                     constant: 0)])
        moreimg.addConstraints([NSLayoutConstraint(item: moreimg,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .notAnAttribute,
                                                 multiplier: 1.0,
                                                 constant: scal * 3),
                              NSLayoutConstraint(item: moreimg,
                                                 attribute: .height,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .notAnAttribute,
                                                 multiplier: 1.0,
                                                 constant: scal * 5)])
        // +86
        phoneview.addConstraints([NSLayoutConstraint(item: placelabel,
                                                     attribute: .left,
                                                     relatedBy: .equal,
                                                     toItem: moreimg,
                                                     attribute: .right,
                                                     multiplier: 1.0,
                                                     constant: scal * 4),
                                  NSLayoutConstraint(item: placelabel,
                                                     attribute: .centerY,
                                                     relatedBy: .equal,
                                                     toItem: china,
                                                     attribute: .centerY,
                                                     multiplier: 1.0,
                                                     constant: 0)])

        // 手机号输入框
        phoneview.addConstraints([NSLayoutConstraint(item: phonetextfield,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: lineview,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: -scal * 5),
                                  NSLayoutConstraint(item: phonetextfield,
                                                     attribute: .left,
                                                     relatedBy: .equal,
                                                     toItem: placelabel,
                                                     attribute: .right,
                                                     multiplier: 1.0,
                                                     constant: scal * 5)])
        phonetextfield.addConstraints([NSLayoutConstraint(item: phonetextfield,
                                                   attribute: .width,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: 1.0,
                                                   constant: scal * 80),
                                NSLayoutConstraint(item: phonetextfield,
                                                   attribute: .height,
                                                   relatedBy: .equal,
                                                   toItem: nil,
                                                   attribute: .notAnAttribute,
                                                   multiplier: 1.0,
                                                   constant: scal * 10)])
        // 下一步按钮
        phoneview.addConstraints([NSLayoutConstraint(item: nextBtn,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: lineview,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: scal * 32),
                                  NSLayoutConstraint(item: nextBtn,
                                                     attribute: .centerX,
                                                     relatedBy: .equal,
                                                     toItem: phoneview,
                                                     attribute: .centerX,
                                                     multiplier: 1.0,
                                                     constant: 0)])

        return phoneview
        
    }
    
    fileprivate func setupPasswordView(orgin:CGPoint)->UIView{
        
        let passwordview =  UIView(frame: CGRect(origin: orgin, size: view.frame.size))
        passwordview.backgroundColor = UIColor.white
        view.backgroundColor = UIColor.white
        
        let phoneimg = UIImageView(image: UIImage(named: "login_phone"))
        passwordview.addSubview(phoneimg)
        
        let firstlabel = UILabel()
        firstlabel.text = "输入登录密码"
        firstlabel.textColor = UIColor.init(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        firstlabel.font = UIFont.boldSystemFont(ofSize: 24)
        firstlabel.sizeToFit()
        passwordview.addSubview(firstlabel)
        
        let secondlabel = UILabel()
        secondlabel.text = "请输入6-16位密码"
        secondlabel.textColor = UIColor.init(red: 132/255, green: 132/255, blue: 132/255, alpha: 1)
        secondlabel.font = UIFont.boldSystemFont(ofSize: 14)
        secondlabel.sizeToFit()
        passwordview.addSubview(secondlabel)
        
        let lineview = UIView()
        lineview.backgroundColor = UIColor.init(red: 200/255, green: 199/255, blue: 204/255, alpha: 1)
        passwordview.addSubview(lineview)
        
        passwordtextfield.keyboardType = .default
        passwordtextfield.isSecureTextEntry = true
        passwordtextfield.textColor = UIColor.init(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        passwordtextfield.font = UIFont.boldSystemFont(ofSize: 20)
        passwordtextfield.borderStyle = .none
        passwordtextfield.contentHorizontalAlignment = .center
        passwordtextfield.textAlignment = .center
        passwordtextfield.becomeFirstResponder()
        passwordview.addSubview(passwordtextfield)
        
        let forgetpwdBtn = UIButton()
        forgetpwdBtn.setTitle("忘记密码 >", for: .normal)
        forgetpwdBtn.setTitleColor(UIColor.init(red: 120/255, green: 120/255, blue: 120/255, alpha: 1), for: .normal)
        forgetpwdBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        forgetpwdBtn.addTarget(nil, action: #selector(didClickForgetBtn), for: .touchUpInside)
        forgetpwdBtn.sizeToFit()
        passwordview.addSubview(forgetpwdBtn)
        
        let nextBtn = UIButton()
        nextBtn.setTitle("登陆", for: .normal)
        nextBtn.setTitleColor(UIColor.init(red: 132/255, green: 132/255, blue: 132/255, alpha: 1), for: .normal)
        nextBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        nextBtn.addTarget(nil, action: #selector(didClickLoginBtn), for: .touchUpInside)
        nextBtn.sizeToFit()
        passwordview.addSubview(nextBtn)
        
        let backBtn = UIButton(frame: CGRect(x: 10, y: 18, width: 18, height: 18))
        backBtn.setImage(UIImage(named: "login_back"), for: .normal)
        backBtn.addTarget(nil, action: #selector(didClickBackBtn), for: .touchUpInside)
        passwordview.addSubview(backBtn)
        
        // 自动布局
        phoneimg.translatesAutoresizingMaskIntoConstraints = false
        firstlabel.translatesAutoresizingMaskIntoConstraints = false
        secondlabel.translatesAutoresizingMaskIntoConstraints = false
        lineview.translatesAutoresizingMaskIntoConstraints = false
        passwordtextfield.translatesAutoresizingMaskIntoConstraints = false
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        forgetpwdBtn.translatesAutoresizingMaskIntoConstraints = false
        
        
        passwordview.addConstraint(NSLayoutConstraint(item: phoneimg,
                                                   attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: passwordview,
                                                   attribute: .top,
                                                   multiplier: 1.0,
                                                   constant: 53))
        passwordview.addConstraint(NSLayoutConstraint(item: phoneimg,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: passwordview,
                                                   attribute: .centerX,
                                                   multiplier: 1.0,
                                                   constant: 0))
        // 输入密码
        passwordview.addConstraint(NSLayoutConstraint(item: firstlabel,
                                                   attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: phoneimg,
                                                   attribute: .bottom,
                                                   multiplier: 1.0,
                                                   constant: 12 * scal))
        passwordview.addConstraint(NSLayoutConstraint(item: firstlabel,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: passwordview,
                                                   attribute: .centerX,
                                                   multiplier: 1.0,
                                                   constant: 0))
        // 输入强度优秀的密码
        passwordview.addConstraint(NSLayoutConstraint(item: secondlabel,
                                                   attribute: .top,
                                                   relatedBy: .equal,
                                                   toItem: firstlabel,
                                                   attribute: .bottom,
                                                   multiplier: 1.0,
                                                   constant: 6 * scal))
        passwordview.addConstraint(NSLayoutConstraint(item: secondlabel,
                                                   attribute: .centerX,
                                                   relatedBy: .equal,
                                                   toItem: passwordview,
                                                   attribute: .centerX,
                                                   multiplier: 1.0,
                                                   constant: 0))
        // 线
        passwordview.addConstraints([NSLayoutConstraint(item: lineview,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: secondlabel,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: scal * 38),
                                  NSLayoutConstraint(item: lineview,
                                                     attribute: .centerX,
                                                     relatedBy: .equal,
                                                     toItem: passwordview,
                                                     attribute: .centerX,
                                                     multiplier: 1.0,
                                                     constant: 0)])
        lineview.addConstraints([NSLayoutConstraint(item: lineview,
                                                    attribute: .width,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1.0,
                                                    constant: scal * 130.0),
                                 NSLayoutConstraint(item: lineview,
                                                    attribute: .height,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1.0,
                                                    constant: 0.5)])
        
        // 密码输入区
        passwordview.addConstraints([NSLayoutConstraint(item: passwordtextfield,
                                                     attribute: .bottom,
                                                     relatedBy: .equal,
                                                     toItem: lineview,
                                                     attribute: .top,
                                                     multiplier: 1.0,
                                                     constant: -scal * 5),
                                  NSLayoutConstraint(item: passwordtextfield,
                                                     attribute: .centerX,
                                                     relatedBy: .equal,
                                                     toItem: passwordview,
                                                     attribute: .centerX,
                                                     multiplier: 1.0,
                                                     constant: 0)])
        passwordtextfield.addConstraints([NSLayoutConstraint(item: passwordtextfield,
                                                          attribute: .width,
                                                          relatedBy: .equal,
                                                          toItem: nil,
                                                          attribute: .notAnAttribute,
                                                          multiplier: 1.0,
                                                          constant: scal * 100),
                                       NSLayoutConstraint(item: passwordtextfield,
                                                          attribute: .height,
                                                          relatedBy: .equal,
                                                          toItem: nil,
                                                          attribute: .notAnAttribute,
                                                          multiplier: 1.0,
                                                          constant: scal * 15)])
        // 忘记密码按钮
        passwordview.addConstraints([NSLayoutConstraint(item: forgetpwdBtn,
                                                        attribute: .top,
                                                        relatedBy: .equal,
                                                        toItem: lineview,
                                                        attribute: .bottom,
                                                        multiplier: 1.0,
                                                        constant: scal * 7),
                                     NSLayoutConstraint(item: forgetpwdBtn,
                                                        attribute: .centerX,
                                                        relatedBy: .equal,
                                                        toItem: passwordview,
                                                        attribute: .centerX,
                                                        multiplier: 1.0,
                                                        constant: 0)])
        // 下一步按钮
        passwordview.addConstraints([NSLayoutConstraint(item: nextBtn,
                                                     attribute: .top,
                                                     relatedBy: .equal,
                                                     toItem: lineview,
                                                     attribute: .bottom,
                                                     multiplier: 1.0,
                                                     constant: scal * 32),
                                  NSLayoutConstraint(item: nextBtn,
                                                     attribute: .centerX,
                                                     relatedBy: .equal,
                                                     toItem: passwordview,
                                                     attribute: .centerX,
                                                     multiplier: 1.0,
                                                     constant: 0)])

        return passwordview
    }
    
    fileprivate func setupCodeUI(orgin:CGPoint)->UIView{
        
        let codeview = UIView(frame: CGRect(origin: orgin, size: view.frame.size))
        codeview.backgroundColor = UIColor.white
        view.backgroundColor = UIColor.white
        view.addSubview(codeview)
        
        let phoneimg = UIImageView(image: UIImage(named: "login_phone"))
        codeview.addSubview(phoneimg)
        
        let firstlabel = UILabel()
        firstlabel.text = "输入验证码"
        firstlabel.textColor = UIColor.init(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        firstlabel.font = UIFont.boldSystemFont(ofSize: 24)
        firstlabel.sizeToFit()
        codeview.addSubview(firstlabel)
        
        let secondlabel = UILabel()
        secondlabel.text = "1501883391"
        secondlabel.textColor = UIColor.init(red: 132/255, green: 132/255, blue: 132/255, alpha: 1)
        secondlabel.font = UIFont.boldSystemFont(ofSize: 14)
        secondlabel.sizeToFit()
        codeview.addSubview(secondlabel)
        
        resendBtn.setTitle("60秒后重发", for: .normal)
        resendBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        resendBtn.setTitleColor(UIColor.init(red: 132/255, green: 132/255, blue: 132/255, alpha: 1), for: .normal)
        resendBtn.addTarget(nil, action: #selector(sendVerifyCode), for: .touchUpInside)
        resendBtn.isEnabled = false
        resendBtn.sizeToFit()
        codeview.addSubview(resendBtn)
        
        correctcodelabel.text = "请输入正确的验证码"
        correctcodelabel.textColor = UIColor.init(red: 1, green: 82/255, blue: 93/255, alpha: 1)
        correctcodelabel.font = UIFont.boldSystemFont(ofSize: 10)
        correctcodelabel.sizeToFit()
        correctcodelabel.isHidden = true
        codeview.addSubview(correctcodelabel)
        
        let verifycode = SwiftyVerificationCodeView(frame: CGRect(x: 0, y: 200, width: UIScreen.main.bounds.width, height: 50))
        verifycode.delegate = self
        codeview.addSubview(verifycode)
        
        let warnlabel1 = UILabel()
        warnlabel1.text = "输入即表示同意"
        warnlabel1.font = UIFont.boldSystemFont(ofSize: 11)
        warnlabel1.textColor = UIColor.init(red: 181/255, green: 181/255, blue: 181/255, alpha: 1)
        warnlabel1.sizeToFit()
        codeview.addSubview(warnlabel1)
        
        let warnlabel2 = UILabel()
        warnlabel2.text = "《法律声明及隐私政策》"
        warnlabel2.font = UIFont.boldSystemFont(ofSize: 11)
        warnlabel2.textColor = UIColor.init(red: 252/255, green: 152/255, blue: 94/255, alpha: 1)
        warnlabel2.sizeToFit()
        codeview.addSubview(warnlabel2)
        
        let backBtn = UIButton(frame: CGRect(x: 10, y: 18, width: 18, height: 18))
        backBtn.setImage(UIImage(named: "login_back"), for: .normal)
        backBtn.addTarget(nil, action: #selector(didClickBackBtn), for: .touchUpInside)
        codeview.addSubview(backBtn)
        
        // 自动布局
        phoneimg.translatesAutoresizingMaskIntoConstraints = false
        firstlabel.translatesAutoresizingMaskIntoConstraints = false
        secondlabel.translatesAutoresizingMaskIntoConstraints = false
        correctcodelabel.translatesAutoresizingMaskIntoConstraints = false
        resendBtn.translatesAutoresizingMaskIntoConstraints = false
        verifycode.translatesAutoresizingMaskIntoConstraints = false
        warnlabel1.translatesAutoresizingMaskIntoConstraints = false
        warnlabel2.translatesAutoresizingMaskIntoConstraints = false
        
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
        // 手机号
        codeview.addConstraint(NSLayoutConstraint(item: secondlabel,
                                                      attribute: .top,
                                                      relatedBy: .equal,
                                                      toItem: firstlabel,
                                                      attribute: .bottom,
                                                      multiplier: 1.0,
                                                      constant: 6 * scal))
        codeview.addConstraint(NSLayoutConstraint(item: secondlabel,
                                                      attribute: .right,
                                                      relatedBy: .equal,
                                                      toItem: codeview,
                                                      attribute: .centerX,
                                                      multiplier: 1.0,
                                                      constant: -3*scal))
        // 重发验证码
        codeview.addConstraint(NSLayoutConstraint(item: resendBtn,
                                                  attribute: .centerY,
                                                  relatedBy: .equal,
                                                  toItem: secondlabel,
                                                  attribute: .centerY,
                                                  multiplier: 1.0,
                                                  constant: 0))
        codeview.addConstraint(NSLayoutConstraint(item: resendBtn,
                                                  attribute: .left,
                                                  relatedBy: .equal,
                                                  toItem: codeview,
                                                  attribute: .centerX,
                                                  multiplier: 1.0,
                                                  constant: 3*scal))
        // 验证码错误
        codeview.addConstraint(NSLayoutConstraint(item: correctcodelabel,
                                                  attribute: .top,
                                                  relatedBy: .equal,
                                                  toItem: secondlabel,
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
        // 输入即表示同意
        codeview.addConstraint(NSLayoutConstraint(item: warnlabel1,
                                                  attribute: .top,
                                                  relatedBy: .equal,
                                                  toItem: correctcodelabel,
                                                  attribute: .bottom,
                                                  multiplier: 1.0,
                                                  constant: 63 * scal))
        codeview.addConstraint(NSLayoutConstraint(item: warnlabel1,
                                                  attribute: .left,
                                                  relatedBy: .equal,
                                                  toItem: codeview,
                                                  attribute: .left,
                                                  multiplier: 1.0,
                                                  constant: 44 * scal))
        // 法律政策
        codeview.addConstraint(NSLayoutConstraint(item: warnlabel2,
                                                  attribute: .top,
                                                  relatedBy: .equal,
                                                  toItem: correctcodelabel,
                                                  attribute: .bottom,
                                                  multiplier: 1.0,
                                                  constant: 63 * scal))
        codeview.addConstraint(NSLayoutConstraint(item: warnlabel2,
                                                  attribute: .left,
                                                  relatedBy: .equal,
                                                  toItem: warnlabel1,
                                                  attribute: .right,
                                                  multiplier: 1.0,
                                                  constant: 2 * scal))

       
        return codeview
    }
    
    fileprivate func setupNewPasswordUI(orgin:CGPoint)->UIView{
        let setpasswordview = UIView(frame: CGRect(origin: orgin, size: view.frame.size))
        setpasswordview.backgroundColor = UIColor.white
        view.backgroundColor = UIColor.white
        
        let phoneimg = UIImageView(image: UIImage(named: "login_phone"))
        setpasswordview.addSubview(phoneimg)
        
        let firstlabel = UILabel()
        firstlabel.text = " 设置登陆密码"
        firstlabel.textColor = UIColor.init(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        firstlabel.font = UIFont.boldSystemFont(ofSize: 24)
        firstlabel.sizeToFit()
        setpasswordview.addSubview(firstlabel)
        
        let secondlabel = UILabel()
        secondlabel.text = "请设置一个安全的密码"
        secondlabel.textColor = UIColor.init(red: 132/255, green: 132/255, blue: 132/255, alpha: 1)
        secondlabel.font = UIFont.boldSystemFont(ofSize: 14)
        secondlabel.sizeToFit()
        setpasswordview.addSubview(secondlabel)
        
        let lineview = UIView()
        lineview.backgroundColor = UIColor.init(red: 200/255, green: 199/255, blue: 204/255, alpha: 1)
        setpasswordview.addSubview(lineview)
        
        newpasswordtextfield.keyboardType = .default
        newpasswordtextfield.isSecureTextEntry = true
        newpasswordtextfield.textColor = UIColor.init(red: 51/255, green: 51/255, blue: 51/255, alpha: 1)
        newpasswordtextfield.font = UIFont.boldSystemFont(ofSize: 20)
        newpasswordtextfield.borderStyle = .none
        newpasswordtextfield.contentHorizontalAlignment = .center
        newpasswordtextfield.textAlignment = .center
        newpasswordtextfield.becomeFirstResponder()
        setpasswordview.addSubview(newpasswordtextfield)
        
        
        let nextBtn = UIButton()
        nextBtn.setTitle("下一步", for: .normal)
        nextBtn.setTitleColor(UIColor.init(red: 132/255, green: 132/255, blue: 132/255, alpha: 1), for: .normal)
        nextBtn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        nextBtn.addTarget(nil, action: #selector(didClickChangePasswordBtn), for: .touchUpInside)
        nextBtn.sizeToFit()
        setpasswordview.addSubview(nextBtn)
        

        // 自动布局
        phoneimg.translatesAutoresizingMaskIntoConstraints = false
        firstlabel.translatesAutoresizingMaskIntoConstraints = false
        secondlabel.translatesAutoresizingMaskIntoConstraints = false
        lineview.translatesAutoresizingMaskIntoConstraints = false
        newpasswordtextfield.translatesAutoresizingMaskIntoConstraints = false
        nextBtn.translatesAutoresizingMaskIntoConstraints = false
        
        
        setpasswordview.addConstraint(NSLayoutConstraint(item: phoneimg,
                                                      attribute: .top,
                                                      relatedBy: .equal,
                                                      toItem: setpasswordview,
                                                      attribute: .top,
                                                      multiplier: 1.0,
                                                      constant: 53))
        setpasswordview.addConstraint(NSLayoutConstraint(item: phoneimg,
                                                      attribute: .centerX,
                                                      relatedBy: .equal,
                                                      toItem: setpasswordview,
                                                      attribute: .centerX,
                                                      multiplier: 1.0,
                                                      constant: 0))
        // 输入密码
        setpasswordview.addConstraint(NSLayoutConstraint(item: firstlabel,
                                                      attribute: .top,
                                                      relatedBy: .equal,
                                                      toItem: phoneimg,
                                                      attribute: .bottom,
                                                      multiplier: 1.0,
                                                      constant: 12 * scal))
        setpasswordview.addConstraint(NSLayoutConstraint(item: firstlabel,
                                                      attribute: .centerX,
                                                      relatedBy: .equal,
                                                      toItem: setpasswordview,
                                                      attribute: .centerX,
                                                      multiplier: 1.0,
                                                      constant: 0))
        // 输入强度优秀的密码
        setpasswordview.addConstraint(NSLayoutConstraint(item: secondlabel,
                                                      attribute: .top,
                                                      relatedBy: .equal,
                                                      toItem: firstlabel,
                                                      attribute: .bottom,
                                                      multiplier: 1.0,
                                                      constant: 6 * scal))
        setpasswordview.addConstraint(NSLayoutConstraint(item: secondlabel,
                                                      attribute: .centerX,
                                                      relatedBy: .equal,
                                                      toItem: setpasswordview,
                                                      attribute: .centerX,
                                                      multiplier: 1.0,
                                                      constant: 0))
        // 线
        setpasswordview.addConstraints([NSLayoutConstraint(item: lineview,
                                                        attribute: .top,
                                                        relatedBy: .equal,
                                                        toItem: secondlabel,
                                                        attribute: .bottom,
                                                        multiplier: 1.0,
                                                        constant: scal * 38),
                                     NSLayoutConstraint(item: lineview,
                                                        attribute: .centerX,
                                                        relatedBy: .equal,
                                                        toItem: setpasswordview,
                                                        attribute: .centerX,
                                                        multiplier: 1.0,
                                                        constant: 0)])
        lineview.addConstraints([NSLayoutConstraint(item: lineview,
                                                    attribute: .width,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1.0,
                                                    constant: scal * 130.0),
                                 NSLayoutConstraint(item: lineview,
                                                    attribute: .height,
                                                    relatedBy: .equal,
                                                    toItem: nil,
                                                    attribute: .notAnAttribute,
                                                    multiplier: 1.0,
                                                    constant: 0.5)])
        
        // 密码输入区
        setpasswordview.addConstraints([NSLayoutConstraint(item: newpasswordtextfield,
                                                        attribute: .bottom,
                                                        relatedBy: .equal,
                                                        toItem: lineview,
                                                        attribute: .top,
                                                        multiplier: 1.0,
                                                        constant: -scal * 5),
                                     NSLayoutConstraint(item: newpasswordtextfield,
                                                        attribute: .centerX,
                                                        relatedBy: .equal,
                                                        toItem: setpasswordview,
                                                        attribute: .centerX,
                                                        multiplier: 1.0,
                                                        constant: 0)])
        newpasswordtextfield.addConstraints([NSLayoutConstraint(item: newpasswordtextfield,
                                                             attribute: .width,
                                                             relatedBy: .equal,
                                                             toItem: nil,
                                                             attribute: .notAnAttribute,
                                                             multiplier: 1.0,
                                                             constant: scal * 100),
                                          NSLayoutConstraint(item: newpasswordtextfield,
                                                             attribute: .height,
                                                             relatedBy: .equal,
                                                             toItem: nil,
                                                             attribute: .notAnAttribute,
                                                             multiplier: 1.0,
                                                             constant: scal * 15)])
        // 下一步按钮
        setpasswordview.addConstraints([NSLayoutConstraint(item: nextBtn,
                                                        attribute: .top,
                                                        relatedBy: .equal,
                                                        toItem: lineview,
                                                        attribute: .bottom,
                                                        multiplier: 1.0,
                                                        constant: scal * 32),
                                     NSLayoutConstraint(item: nextBtn,
                                                        attribute: .centerX,
                                                        relatedBy: .equal,
                                                        toItem: setpasswordview,
                                                        attribute: .centerX,
                                                        multiplier: 1.0,
                                                        constant: 0)])
        return setpasswordview
    }
    
}

// MARK: - 代理方法
extension EULoginViewController:SwiftyVerificationCodeViewDelegate{
    
    func verificationCodeDidFinishedInput(verificationCodeView: SwiftyVerificationCodeView, code: String) {
        
        guard let verifycode = verifycode else {
            return
        }
        if verifycode != code {
            correctcodelabel.isHidden = false
            verificationCodeView.cleanVerificationCodeView()
            return
        }
        setpasswordview = setupNewPasswordUI(orgin: CGPoint(x: UIScreen.main.bounds.width, y: 0))
        view.addSubview(setpasswordview!)
        UIView.animate(withDuration: 0.5, animations: {
            self.setpasswordview?.frame.origin = CGPoint.zero
            self.codeview?.frame.origin = CGPoint(x: -UIScreen.main.bounds.width, y: 0)
        }, completion: { (_) in
            self.codeview?.removeFromSuperview()
        })

    }
    
}

// MARK: - 监听方法
extension EULoginViewController{
    
    /// 返回按钮监听 返回到输入手机号层
    @objc fileprivate func didClickBackBtn(){
        
        phoneview = setupPhoneView(orgin: CGPoint(x: -UIScreen.main.bounds.width, y: 0))
        view.addSubview(phoneview!)
        UIView.animate(withDuration: 0.5, animations: { 
            self.phoneview?.frame.origin = CGPoint.zero
            self.codeview?.frame.origin = CGPoint(x: UIScreen.main.bounds.width, y: 0)
            self.enterpasswordview?.frame.origin = CGPoint(x: UIScreen.main.bounds.width, y: 0)
        }) { (_) in
            self.codeview?.removeFromSuperview()
            self.enterpasswordview?.removeFromSuperview()
        }
        
    }

    /// 下一步 输入手机号->下一个页面
    @objc fileprivate func didClickNexTBtn(){
        
        //FIXME: - 后期不到 11 位 Button 不允许被点击
        guard let phone = phonetextfield.text else{
            return
        }
        if phone.characters.count != 11 {
            return
        }
        phonenumber = phone
        SwiftyProgressHUD.showLoadingHUD()
        EUNetworkManager.shared.getVerificationCode(phone: phone, isRegister: true) { (isSuccess, code) in
         
            SwiftyProgressHUD.hide()
            if !isSuccess{
            
                SwiftyProgressHUD.showFaildHUD(text: "网络错误", duration: 0.5)
                return
            }
            // 用户没有注册过的情况，跳转到验证码界面
            if let code = code {
                self.isOldUser = false
                self.verifycode = code
                self.codeview = self.setupCodeUI(orgin: CGPoint(x: UIScreen.main.bounds.width, y: 0))
                self.view.addSubview(self.codeview!)
                UIView.animate(withDuration: 0.5, animations: { 
                    self.codeview?.frame.origin = CGPoint.zero
                    self.phoneview?.frame.origin = CGPoint(x: -UIScreen.main.bounds.width, y: 0)
                }, completion: { (_) in
                    self.phoneview?.removeFromSuperview()
                })
                
            }else{
                // 跳转到输入密码界面
                self.enterpasswordview = self.setupPasswordView(orgin: CGPoint(x: UIScreen.main.bounds.width, y: 0))
                self.view.addSubview(self.enterpasswordview!)
                UIView.animate(withDuration: 0.5, animations: { 
                    self.enterpasswordview?.frame.origin = CGPoint.zero
                    self.phoneview?.frame.origin = CGPoint(x: -UIScreen.main.bounds.width, y: 0)
                }, completion: { (_) in
                    self.phoneview?.removeFromSuperview()
                })
                
            }
        }
        
    }
    
    /// 登陆
    @objc fileprivate func didClickLoginBtn(){
        
        guard let pwd = passwordtextfield.text,let phonenumber = phonenumber else{
            return
        }
        SwiftyProgressHUD.showLoadingHUD()
        EUNetworkManager.shared.loginByPassword(phone: phonenumber, password: pwd) { (isSuccess, shouldLogin) in
            
            SwiftyProgressHUD.hide()
            if !isSuccess{
                SwiftyProgressHUD.showFaildHUD(text: "网络错误", duration: 1)
                return
            }
            if !shouldLogin{
                SwiftyProgressHUD.showFaildHUD(text: "密码错误", duration: 1)
                return
            }
            self.present(EUMainViewController(), animated: true, completion: nil)
        }
        
        
    }
    
    /// 忘记密码
    @objc fileprivate func didClickForgetBtn(){
        
        guard let phonenumber = phonenumber else {
            return
        }
        
        EUNetworkManager.shared.getVerificationCode(phone: phonenumber, isRegister: false) { (isSuccess, code) in
            if !isSuccess{
                // 提示网络不好
                return
            }
            self.verifycode = code
            
            self.codeview = self.setupCodeUI(orgin: CGPoint(x: UIScreen.main.bounds.width, y: 0))
            UIView.animate(withDuration: 0.5, animations: {
                self.codeview?.frame.origin = CGPoint.zero
                self.enterpasswordview?.frame.origin = CGPoint(x: -UIScreen.main.bounds.width, y: 0)
            }) { (_) in
                self.enterpasswordview?.removeFromSuperview()
            }
        }
        
        
        
    }
    
    /// 忘记密码
    @objc fileprivate func didClickChangePasswordBtn(){
    
        guard let newpwd = newpasswordtextfield.text,let phonenumber = phonenumber else {
            return
        }

        /// 如果是老用户，改完密码直接自动登录
        if isOldUser {
            SwiftyProgressHUD.showLoadingHUD()
            EUNetworkManager.shared.changgePasswordByVerifyCode(phone: phonenumber, newpwd: newpwd, completion: { (isSuccess) in
              
                SwiftyProgressHUD.hide()
                if !isSuccess{
                    SwiftyProgressHUD.showFaildHUD(text: "网络错误", duration: 1)
                }
                // 修改成功，登陆
                EUNetworkManager.shared.loginByPassword(phone: phonenumber, password: newpwd, completion: { (isSuccess, _) in
                    
                    self.present(EUMainViewController(), animated: true, completion: nil)
                })
                
            })
        }else{
            
            /// 新用户还要填写一堆个人资料
            let vc = EUserInfoInputViewController()
            vc.password = newpwd
            vc.phone = phonenumber
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    /// 更新重发时间
    @objc fileprivate func updateResendTime(){
        
        resendtime -= 1
    }
    
    /// 重发验证码
    @objc fileprivate func sendVerifyCode(){
        
        resendBtn.isEnabled = false
        resendtime = 60
        
        // 重新获取验证码
        guard let phonenumber = phonenumber else {
            return
        }
        
        SwiftyProgressHUD.showLoadingHUD()
        EUNetworkManager.shared.getVerificationCode(phone: phonenumber, isRegister: !isOldUser) { (isSuccess, code) in
            
            SwiftyProgressHUD.hide()
            if !isSuccess{
                
                SwiftyProgressHUD.showFaildHUD(text: "网络错误", duration: 0.5)
                return
            }
            if let code = code {
                self.verifycode = code
            }
        }
        
    }
    
}
