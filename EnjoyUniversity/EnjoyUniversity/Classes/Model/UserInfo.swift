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
    
    /// 性别 男0 女1 保密2
    var gender:Int = 0
    
    /// 专业班级
    var professionclass:String?
    
    /// 学号
    var studentid:Int64 = 0
    
    /// 姓名
    var name:String?
    
    /// 用户节操值 满分100
    var reputation:Int = 0
    
    /// 用户验证信息
    var verified:Int = 0
    
    /// 入学年份
    var grade:Int = 0
    
    /// 职位（不属于这个表，将就着用） -3表示提交申请，－2表示进行笔试，－1表示进行面试，1表示成员，2表示管理员 3表示社长
    var position:Int = -4
    
    init(uid:Int64,avatar:String?,nickname:String,gender:Int,professionclass:String,studentid:Int64,name:String,grade:Int) {
        
        self.uid = uid
        self.nickname = nickname
        self.avatar = avatar
        self.gender = gender
        self.professionclass = professionclass
        self.name = name
        self.studentid = studentid
        self.grade = grade
    }
    
    override init() {
        super.init()
    }

}
