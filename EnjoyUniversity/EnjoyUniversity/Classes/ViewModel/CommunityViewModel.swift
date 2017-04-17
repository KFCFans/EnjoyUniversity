//
//  CommunityViewModel.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/2.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation
import UIKit

class CommunityViewModel{
    
    
    var communitymodel:Community?
    
    /// 社团介绍文本的高度
    var detailHeight:CGFloat = 0
    
    /// 社团公告文本的高度
    var announcementHeight:CGFloat = 0
    
    /// 我的社团公告文本的高度
    var myannouncementHeight:CGFloat = 0
    
    /// 社团类型 0兴趣社团 1学术社团 2运动社团
    var communityType:String?
    
    /// 社团属性 0学生组织 1院级社团 2校级社团
    var communityAttr:String = "社团性质:"
    
    /// 所属学校
    var communitySchool:String = "所属学校:"
    
    /// Logo 的 URL
    var communityLogoUrl:String = ""
    
    init(model:Community) {
     
        communitymodel = model
        
        // 计算公告高度
        announcementHeight = calculateLabelHeight(text: model.cmAnnouncement ?? "", width: UIScreen.main.bounds.width - 30, font: 13)
        
        // 计算我的社团公告高度
        myannouncementHeight = calculateLabelHeight(text: model.cmAnnouncement ?? "", width: UIScreen.main.bounds.width - 72, font: 15)
        
        // 所属学校
        communitySchool += model.cmSchool ?? "江南大学"
        
        // 计算简介高度
        detailHeight = calculateLabelHeight(text: model.cmDetail ?? "", width: UIScreen.main.bounds.width - 30, font: 14)
        
        // 拼接url
        communityLogoUrl = PICTURESERVERADDRESS + "/community/logo/" + (model.cmLogo ?? "") + ".jpg"
        
        // 社团属性
        switch model.cmAttr {
        case 0:
            communityAttr += "学生组织"
            break
        case 1:
            communityAttr += "院级社团"
            break
        case 2:
            communityAttr += "校级社团"
            break
        default:
            communityAttr += ""
        }
        
        // 社团类型
        switch model.cmType {
        case 0:
            communityType = "兴趣社团"
            break
        case 1:
            communityType = "学术社团"
            break
        case 2:
            communityType = "运动社团"
        default:
            communityType = ""
        }
        
    }
    

 
    
    
}
