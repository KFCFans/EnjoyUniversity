//
//  UserInfoListViewModel.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/10.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation
import YYModel

class UserInfoListViewModel{
    
    
    lazy var activityParticipatorList = [UserinfoViewModel]()
    
    
    /// 加载活动参与者信息
    func loadActivityMemberInfoList(avid:Int,completion:@escaping (Bool,Bool)->()){
        
        
        EUNetworkManager.shared.getActivityParticipators(avid: avid) { (isSuccess, json) in
            
            if !isSuccess{
                
                completion(false,false)
                return
            }
            
            guard let json = json,
                let modelarray = NSArray.yy_modelArray(with: UserInfo.self, json: json) as? [UserInfo] else{
                completion(true,false)
                return
            }
            
            for model in modelarray{
                self.activityParticipatorList.append(UserinfoViewModel(model: model))
            }
            completion(true,true)
            
        }
    }
    
    /// 加载社团成员信息
    func loadCommunityMemberInfoList(){
        
    }
    

}
