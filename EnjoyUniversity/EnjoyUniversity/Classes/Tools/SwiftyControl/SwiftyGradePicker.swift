//
//  SwiftyGradePicker.swift
//  SwiftyGradePicker
//
//  Created by lip on 17/4/25.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit
protocol SwiftyGradePickerDelegate {
    func swiftyGradePickerdidSelected(swiftyGradePicker:SwiftyGradePicker,grade:Int)
}
class SwiftyGradePicker: UIView {
    
    var gradeData = [Int]()
    
    var pickerHeight:CGFloat = 0
    
    var delegate:SwiftyGradePickerDelegate?
    
    let gradepicker = UIPickerView()
    
    init(height:CGFloat,gradeData:[Int]) {
        super.init(frame: CGRect(x: 0,
                                 y: UIScreen.main.bounds.height,
                                 width: UIScreen.main.bounds.width,
                                 height: height + 44))
        pickerHeight = height
        backgroundColor = BACKGROUNDCOLOR
        self.gradeData = gradeData
        setupUI()
        UIView.animate(withDuration: 0.25) {
            self.frame.origin = CGPoint(x: 0, y: UIScreen.main.bounds.height - 44 - height)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(){
        
        gradepicker.frame = CGRect(x: 0,
                                   y: 44,
                                   width: UIScreen.main.bounds.width,
                                   height: pickerHeight)
        gradepicker.delegate = self
        gradepicker.dataSource = self
        gradepicker.backgroundColor = UIColor.white
        addSubview(gradepicker)
        
        let cancelBtn = UIButton(frame: CGRect(x: 16, y: 10, width: 100, height: 24))
        cancelBtn.setTitleColor(UIColor.init(red: 0, green: 122/255, blue: 1, alpha: 1), for: .normal)
        cancelBtn.setTitle("取消", for: .normal)
        addSubview(cancelBtn)
        
        let confirmBtn = UIButton(frame: CGRect(x: UIScreen.main.bounds.width - 116, y: 10, width: 100, height: 24))
        confirmBtn.setTitleColor(UIColor.init(red: 0, green: 122/255, blue: 1, alpha: 1), for: .normal)
        confirmBtn.setTitle("确定", for: .normal)
        addSubview(confirmBtn)
        cancelBtn.addTarget(nil, action: #selector(cancelDatePicker), for: .touchUpInside)
        confirmBtn.addTarget(nil, action: #selector(confirmDatePicker), for: .touchUpInside)
        
    }
    
    @objc private func cancelDatePicker(){
        
        UIView.animate(withDuration: 0.25, animations: {
            self.frame.origin = CGPoint(x: 5, y: UIScreen.main.bounds.height)
        }) { (_) in
            self.removeFromSuperview()
        }
        
    }
    
    @objc private func confirmDatePicker(){
        delegate?.swiftyGradePickerdidSelected(swiftyGradePicker: self, grade: gradeData[gradepicker.selectedRow(inComponent: 0)])
        cancelDatePicker()
        
    }
    
}

extension SwiftyGradePicker:UIPickerViewDelegate,UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(gradeData[row])"
    }
    
}
