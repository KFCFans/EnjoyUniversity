//
//  AvtivityViewModel.swift
//  EnjoyUniversity
//
//  Created by lip on 17/3/30.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation
import UIKit

class ActivityViewModel{
 
    var activitymodel:Activity
    
    /// 人看的懂的开始时间
    var startTime:String?
    
    /// 人看得懂的结束时间
    var endTime:String?
    
    /// 开始时间 － 结束时间
    var allTime:String?
    
    /// 处理过的价格，直接能显示
    var price:String?
    
    /// 预计人数，已处理
    var expectPeople:String?
    
    /// 活动状态
    var status:String?
    
    /// 人看得懂的活动截至时间
    var enrollDeadline:String?
    
    /// 需要签到／无需签到
    var needRegister:String?
    
    /// 计算文本杭高
    var detailHeight:CGFloat = 0
    
    /// 拼接 URL 地址
    var imageURL:String?
    
    /// 限制人数
    var peoplelimit:String?
    
    /// 二维码跳转
    var qrcodeString:String?
    
    /// 是否需要签到
    var needRegisterBool:Bool = false
    
    /// 活动图片（修改图片得来）
    var activityImg:UIImage?

    
    init(model:Activity) {
        activitymodel = model
        
        reloadData()
    }
    
    func reloadData(){
        
        
        price = activitymodel.avPrice == 0 ? "免费": "¥\(Int(activitymodel.avPrice))"
        
        startTime = timeStampToString(timeStamp: activitymodel.avStarttime)
        endTime = timeStampToString(timeStamp: activitymodel.avEndtime)
        allTime = (startTime ?? "") + " ~ " + (endTime ?? "")
        enrollDeadline = timeStampToString(timeStamp: activitymodel.avEnrolldeadline)
        if activitymodel.avRegister == -1 {
            needRegisterBool = false
            needRegister = "无需签到"
        }else {
            needRegisterBool = true
            needRegister = "需要签到"
            
        }
        detailHeight = calculateLabelHeight(text: activitymodel.avDetail ?? "",width: UIScreen.main.bounds.width - 40,font: 14)
        
        imageURL = PICTURESERVERADDRESS + "/activity/" + (activitymodel.avLogo ?? "") + ".jpg"
        
        expectPeople = activitymodel.avExpectnum == 0 ? "人数不限" : "限\(activitymodel.avExpectnum)人"
        
        qrcodeString = QRCODEPREFIX + "avid=" + activitymodel.avid.description
    }
    

    
    
    
}
