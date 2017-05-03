//
//  MessageListViewModel.swift
//  EnjoyUniversity
//
//  Created by lip on 17/5/3.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation

class MessageListViewModel{
    
    lazy var systemNotifications = [MessageViewModel]()
    
    lazy var activityNotifications = [MessageViewModel]()
    
    lazy var communityNotifications = [MessageViewModel]()
    
    /// 加载系统通知
    ///
    /// - Parameter completion: 完成回调
    func loadSystemNotifications(completion:@escaping (Bool,Bool)->()){
        EUNetworkManager.shared.getSystemNotifications { (isSuccess,json) in
            if !isSuccess{
                completion(false,false)
                return
            }
            guard let json = json,let modelarray = NSArray.yy_modelArray(with: Message.self, json: json) as? [Message] else{
                completion(true,false)
                return
            }
            self.systemNotifications.removeAll()
            for model in modelarray{
                self.systemNotifications.append(MessageViewModel(model: model))
            }
            completion(true,true)
        }
    }
    
    /// 加载活动通知
    ///
    /// - Parameter completion: 完成回调
    func loadActivityNotifications(completion:@escaping (Bool,Bool)->()){
        
        EUNetworkManager.shared.getActivityNotifications { (isSuccess, json) in
            if !isSuccess{
                completion(false,false)
                return
            }
            guard let json = json,let modelarray = NSArray.yy_modelArray(with: Message.self, json: json) as? [Message] else{
                completion(true,false)
                return
            }
            self.activityNotifications.removeAll()
            for model in modelarray{
                self.activityNotifications.append(MessageViewModel(model: model))
            }
            completion(true,true)
        }
    }
    
    
    /// 加载社团通知
    ///
    /// - Parameter completion: 完成回调
    func loadCommunityNotifications(completion:@escaping (Bool,Bool)->()){
        
        EUNetworkManager.shared.getCommunityNotifications { (isSuccess, json) in
            if !isSuccess{
                completion(false,false)
                return
            }
            guard let json = json,let modelarray = NSArray.yy_modelArray(with: Message.self, json: json) as? [Message] else{
                completion(true,false)
                return
            }
            self.communityNotifications.removeAll()
            for model in modelarray{
                self.communityNotifications.append(MessageViewModel(model: model))
            }
            completion(true,true)
        }
        
    }
    
}
