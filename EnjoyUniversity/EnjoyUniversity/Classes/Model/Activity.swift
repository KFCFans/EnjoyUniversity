//
//  Activity.swift
//  EnjoyUniversity
//
//  Created by lip on 17/3/30.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation

class Activity:NSObject{
    
    // 活动 ID
    var avid:Int = 0
    
    // 活动标题
    var avTitle:String?
    
    // 活动开始时间 服务器返回 1493481600000
    var avStarttime:String?
    
    // 活动结束时间
    var avEndtime:String?
    
    // 活动价格
    var avPrice:Float = 0
    
    // 活动详情
    var avDetail:String?
    
    // 活动预计人数
    var avExpectnum:Int = 0
    
    // 活动创办者 ID
    var uid:Int64 = 0
    
    // 活动 logo
    var avLogo:String?
    
    // 活动状态
    var avState:Int = 0
    
    // 活动背景图片地址
    var avBackground:String?
    
    // 签到信息，4位数字，-1代表无需签到
    var avRegister:Int = 0
    
    // 活动报名截止时间
    var avEnrolldeadline:String?
    
    override var description: String{
        return yy_modelDescription()
    }
    
    
}

