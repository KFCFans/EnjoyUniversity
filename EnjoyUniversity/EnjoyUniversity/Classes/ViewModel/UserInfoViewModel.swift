//
//  UserInfoViewModel.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/9.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation
import UIKit

class UserinfoViewModel:NSObject{
    
    /// UserInfo 模型
    var model:UserInfo?
    
    /// 性别
    var sex:String?
    
    /// 头像
    var headsculptureurl:String?
    
    /// 节操值拼接
    var reputationString:String?
    
    /// 认证图标
    var verifyImg:UIImage?
    
    init(model:UserInfo) {
        
        self.model = model
        
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
        
        /// 拼接节操值
        reputationString = "节操值 " + model.reputation.description
        
        /// 选择认证图标
        switch model.reputation {
        case 1:
            verifyImg = UIImage(named: "profile_verifysuccess")
        default:
            verifyImg = UIImage()
        }
        
    }
}
