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
    
    // 视图可以直接使用的开始时间
    var startTime:String?
    
    var endTime:String?
    
    var allTime:String?
    
    var price:String?
    
    var expectPeople:String?
    
    var status:String?
    
    var enrollDeadline:String?
    
    /// 需要签到／无需签到
    var needRegister:String?
    
    /// 计算文本杭高
    var detailHeight:CGFloat = 0
    
    /// 拼接 URL 地址
    var imageURL:String?
    
    init(model:Activity) {
        
        activitymodel = model
        
        price = activitymodel.avPrice == 0 ? "免费": "¥\(Int(model.avPrice))"
        
        startTime = timeStampToString(timeStamp: activitymodel.avStarttime)
        endTime = timeStampToString(timeStamp: activitymodel.avEndtime)
        allTime = (startTime ?? "") + " ~ " + (endTime ?? "")
        enrollDeadline = timeStampToString(timeStamp: activitymodel.avEnrolldeadline)
        needRegister = activitymodel.avRegister == -1 ? "无需签到" : "需要签到"
        detailHeight = calculateLabelHeight(text: activitymodel.avDetail ?? "",width: UIScreen.main.bounds.width - 40,font: 14)
        
        imageURL = PICTURESERVERADDRESS + "/activity/" + (model.avLogo ?? "") + ".jpg"
        
    }
    

    
    
    
}
