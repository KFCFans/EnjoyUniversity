//
//  SwiftyTimePicker.swift
//  Temple
//
//  Created by lip on 17/4/3.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit



/// 协议传值
protocol SwiftyTimePickerDeleate {
    func didConfirmTimePicker(date:String)
}

class SwiftyTimePicker: UIView {
    
    
    // 定义协议
    var delegate:SwiftyTimePickerDeleate?
    
    // 屏幕宽高
    let WIDTH = UIScreen.main.bounds.width
    let HEIGHT = UIScreen.main.bounds.height
    
    // 视图高度
    var viewheight:CGFloat = 0

    let timepicker = UIDatePicker()
    
    // 记录闭包
    var pickerCompletion:((Bool,String)->())?
    
    /// 初始化时间选择弃
    ///
    /// - Parameter height: 时间选择器高度
    init(height:CGFloat){
        super.init(frame: CGRect(x: 0, y: HEIGHT, width: WIDTH, height: height))
        backgroundColor = UIColor.init(red: 242/255, green: 242/255, blue: 242/255, alpha: 1)
        viewheight = height
        setupUI()
        UIView.animate(withDuration: 0.25) { 
            self.frame.origin = CGPoint(x: 0, y: self.HEIGHT - height)
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


// MARK: - UI 相关方法
extension SwiftyTimePicker{
    
    fileprivate func setupUI(){
        
        timepicker.frame = CGRect(x: 5, y: 44, width: WIDTH - 10, height: viewheight - 44)
        timepicker.datePickerMode = .dateAndTime
        timepicker.locale = Locale(identifier: "zh_CN")
        timepicker.backgroundColor = UIColor.white
        addSubview(timepicker)
        
        let cancelBtn = UIButton(frame: CGRect(x: 16, y: 10, width: 100, height: 24))
        cancelBtn.setTitleColor(UIColor.init(red: 0, green: 122/255, blue: 1, alpha: 1), for: .normal)
        cancelBtn.setTitle("取消", for: .normal)
        
        addSubview(cancelBtn)
        
        let confirmBtn = UIButton(frame: CGRect(x: WIDTH - 116, y: 10, width: 100, height: 24))
        confirmBtn.setTitleColor(UIColor.init(red: 0, green: 122/255, blue: 1, alpha: 1), for: .normal)
        confirmBtn.setTitle("确定", for: .normal)
        addSubview(confirmBtn)
        
        cancelBtn.addTarget(nil, action: #selector(cancelDatePicker), for: .touchUpInside)
        confirmBtn.addTarget(nil, action: #selector(confirmDatePicker), for: .touchUpInside)
        
        
    }
    
    
    // 闭包传值
    func getDate(completion:@escaping (Bool,String)->()){
        
        pickerCompletion = completion
    }
    
}


// MARK: - 监听方法
extension SwiftyTimePicker{
    
    @objc fileprivate func cancelDatePicker(){
        
        if let pickerCompletion = pickerCompletion {
            pickerCompletion(false,"")
        }
        UIView.animate(withDuration: 0.25, animations: {
            self.frame.origin = CGPoint(x: 5, y: self.HEIGHT)
        }) { (_) in
            self.removeFromSuperview()
        }
        
    }
    
    @objc fileprivate func confirmDatePicker(){
        let date = timepicker.date
        
        // 将时间转换成人看得懂的类型
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        let result = formatter.string(from: date)
        if let pickerCompletion = pickerCompletion{
            pickerCompletion(true,result)
        }
        self.delegate?.didConfirmTimePicker(date: result)
        UIView.animate(withDuration: 0.25, animations: {
            self.frame.origin = CGPoint(x: 5, y: self.HEIGHT)
        }) { (_) in
            self.removeFromSuperview()
        }
    }
    
}


