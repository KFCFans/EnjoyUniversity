//
//  CommunityWall.swift
//  EnjoyUniversity
//
//  Created by lip on 17/2/27.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation

class Community:NSObject{
    
    // 社团 ID
    var cmid:Int = 0
    
    // 社团 Logo 地址
    var cmLogo:String?
    
    // 社团介绍
    var cmDetail:String?
    
    // 社团名称
    var cmName:String?
    
    // 社团背景图片地址
    var cmBackground:String?
    
    // 社团类型
    var cmType:Int = 0
    
    // 社团属性
    var cmAttr:Int = 0
    
    // 社团公告
    var cmAnnouncement:String?
    
    // 社团是否开启招新 默认0关闭，1开启招新
    var cmRecruit:Int = 0
    
    // 社团热度，后期用于排序
    var  cmHeat:Int = 0
    
    // 社团所属学校
    var cmSchool:String?
    
    // 社团社长
    var cmBoss:Int64 = 0
    
    override var description: String{
        return yy_modelDescription()
    }
    
    
}
