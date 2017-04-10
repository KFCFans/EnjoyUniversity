//
//  UserInfoViewModel.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/9.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation

class UserinfoViewModel:NSObject{
    
    /// UserInfo 模型
    var model:UserInfo?
    
    /// 性别
    var sex:String?
    
    /// 头像
    var headsculptureurl:String?
    
    init(model:UserInfo) {
        
        /// 计算性别
        switch model.gender {
        case 0:
            sex = "男"
        case 1:
            sex = "女"
        case 2:
            sex = "保密"
        default:
            sex = "人妖"
        }
        
        /// 拼接头像地址
        headsculptureurl = PICTURESERVERADDRESS + "/user/" + (model.avatar ?? "") + ".jpg"
        
    }
}
