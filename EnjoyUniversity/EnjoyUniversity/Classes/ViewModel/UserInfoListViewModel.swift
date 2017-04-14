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
    
    
    /// 活动参与者
    lazy var activityParticipatorList = [UserinfoViewModel]()
    
    /// 完成签到的活动参与者
    lazy var finishedRegisterParticipatorList = [UserinfoViewModel]()
    
    /// 未完成签到的互动参与者
    lazy var waitingRegisterParticipatorList = [UserinfoViewModel]()
    
    /// 加载活动参与者信息
    ///
    /// - Parameters:
    ///   - avid: 活动 ID
    ///   - completion: 完成回调
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
            var temp = [UserinfoViewModel]()
            for model in modelarray{
                temp.append(UserinfoViewModel(model: model))
            }
            self.activityParticipatorList = temp
            completion(true,true)
            
        }
    }
    
    /// 加载未完成签到者信息
    ///
    /// - Parameters:
    ///   - avid: 活动ID
    ///   - completion: 完成回调
    func loadWaitingRegisterMemberInfoList(avid:Int,completion:@escaping (Bool,Bool)->()){
        
        EUNetworkManager.shared.getActivityParticipators(avid: avid, choice: -1) { (isSuccess, json) in
            
            if !isSuccess{
                completion(false,false)
                return
            }
            
            guard let json = json,
                let modelarray = NSArray.yy_modelArray(with: UserInfo.self, json: json) as? [UserInfo] else{
                    completion(true,false)
                    return
            }
            var temp = [UserinfoViewModel]()
            for model in modelarray{
                temp.append(UserinfoViewModel(model: model))
            }
            self.waitingRegisterParticipatorList = temp
            completion(true,true)
        }
        
    }
    
    
    /// 加载社团成员信息
    func loadCommunityMemberInfoList(){
        
    }
    

}
