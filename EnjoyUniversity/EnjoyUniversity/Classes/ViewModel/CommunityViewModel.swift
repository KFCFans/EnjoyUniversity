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
    
    /// 社团类型 0兴趣社团 1学术社团 2运动社团
    var communityType:String?
    
    /// 社团属性 0学生组织 1院级社团 2校级社团
    var communityAttr:String?
    
    init(model:Community) {
     
        communitymodel = model
        
    }
    

 
    
    
}
