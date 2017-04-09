//
//  UserInfo.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/9.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class UserInfo: NSObject {
    
    /// 用户 ID ，即手机号
    var uid:Int64 = 0
    
    /// 头像
    var avatar:String?
    
    /// 昵称
    var nickname:String?
    
    /// 性别 男1女0
    var gender:Int = 0
    
    /// 专业班级
    var professionclass:String?
    
    /// 学号
    var studentid:Int64 = 0
    
    /// 姓名
    var name:String?
    
    /// 个人描述
    var userdescription:String?
    
    /// 用户节操值 满分100
    var reputation:Int = 0
    
    /// 用户验证信息
    var verified:Int = 0

}
