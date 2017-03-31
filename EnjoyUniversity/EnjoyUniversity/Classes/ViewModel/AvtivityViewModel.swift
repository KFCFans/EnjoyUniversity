//
//  AvtivityViewModel.swift
//  EnjoyUniversity
//
//  Created by lip on 17/3/30.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation

class ActivityViewModel{
 
    var activitymodel:Activity
    
    // 视图可以直接使用的开始时间
    var startTime:String?
    
    var endTime:String?
    
    var price:String?
    
    var expectPeople:String?
    
    var status:String?
    
    var enrollDeadline:String?
    
    init(model:Activity) {
        
        activitymodel = model
        
        price = activitymodel.avPrice == 0 ? "免费": "¥\(Int(model.avPrice))"
        
        startTime = timeStampToString(timeStamp: activitymodel.avStarttime)
        endTime = timeStampToString(timeStamp: activitymodel.avEndtime)
        enrollDeadline = timeStampToString(timeStamp: activitymodel.avEnrolldeadline)
        
    }
    
    
    
}
