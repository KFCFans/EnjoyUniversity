//
//  Message.swift
//  EnjoyUniversity
//
//  Created by lip on 17/5/3.
//  Copyright © 2017年 lip. All rights reserved.
//

class Message: NSObject {
    
    
    /// 消息 共有
    var msg:String?
    
    /// 发送时间 共有
    var sendtime:String?
    
    /// 发送者（标题）
    var sender:String?
    
    /// 活动 ID
    var avid:Int = 0
    
    /// 社团 ID
    var cmid:Int = 0
    
    /// 用户 ID
    var uid:Int64 = 0
    
    var nexturl:String?

}
