//
//  UserInfoViewModel.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/9.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation
import UIKit

class UserinfoViewModel{
    
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
    
    /// 认证文字
    var verifyString = "未认证"
    
    /// 职务(只有社团通讯录用到)
    var positionString:String?
    
    init(model:UserInfo) {
        self.model = model
        
        switch model.position {
        case 1:
            positionString = "社员"
        case 2:
            positionString = "管理员"
        case 3:
            positionString = "社长"
        default:
            positionString = nil
        }
        
        reloadData()
    }
    
    func reloadData(){
        
        guard let model = model else {
            return
        }
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
        switch Int(model.verified) {
        case 1:
            verifyImg = UIImage(named: "profile_verifysuccess")
            verifyString = "已认证"
        default:
            verifyImg = UIImage()
        }

    }
    
    
    
}
