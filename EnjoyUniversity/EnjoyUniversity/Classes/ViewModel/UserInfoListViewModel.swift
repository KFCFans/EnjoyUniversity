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
    
    /// 社团通讯录(权限表和用户表联合查询结果)
    lazy var communityContactsList = [UserinfoViewModel]()
    
    /// 社团成员列表
    lazy var communityMemberList = [UserinfoViewModel]()
    
    /// 搜索用户列表
    lazy var searchList = [UserinfoViewModel]()
    
    /// 申请社团成员列表
    lazy var applycmMemberList = [UserinfoViewModel]()
    
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
                    self.waitingRegisterParticipatorList.removeAll()
                    completion(true,false)
                    return
            }
            
            self.waitingRegisterParticipatorList.removeAll()
            for model in modelarray{
                self.waitingRegisterParticipatorList.append(UserinfoViewModel(model: model))
            }
            completion(true,true)
        }
        
    }
    
    /// 加载社团通讯录
    ///
    /// - Parameters:
    ///   - cmid: 社团 ID
    ///   - completion: 完成回调
    func loadCommunityContactsInfoList(cmid:Int,completion:@escaping (Bool,Bool)->()){
        
        EUNetworkManager.shared.getCommunityContactsByID(cmid: cmid) { (isSuccess, json) in
            if !isSuccess{
                completion(false,false)
                return
            }
            guard let json = json,let modelarray = NSArray.yy_modelArray(with: UserInfo.self, json: json) as? [UserInfo] else{
                completion(true,false)
                return
            }
            self.communityContactsList.removeAll()
            for model in modelarray{
                // 去除正在审核的人
                if model.position < 0{
                    continue
                }
                self.communityContactsList.append(UserinfoViewModel(model: model))
            }
            self.communityContactsList.sort(by: { (x, y) -> Bool in
                return x.model?.position ?? 0 > y.model?.position ?? 0
            })
            completion(true,true)
        }
    }
    
    /// 加载社团成员列表
    ///
    /// - Parameters:
    ///   - cmid: 社团 ID
    ///   - completion: 完成回调
    func loadCommunityMemberList(cmid:Int,completion:@escaping (Bool,Bool)->()){
        
        EUNetworkManager.shared.getCommunityMemberInfoList(cmid: cmid) { (isSuccess, json) in
            
            if !isSuccess{
                completion(false,false)
                return
            }
            guard let json = json ,let modelarray = NSArray.yy_modelArray(with: UserInfo.self, json: json) as? [UserInfo] else{
                completion(true,false)
                return
            }
            self.communityMemberList.removeAll()
            for model in modelarray{
  
                self.communityMemberList.append(UserinfoViewModel(model: model))
            }
            completion(true,true)
        }
    }
    
    /// 搜索用户列表
    ///
    /// - Parameters:
    ///   - keyword: 关键字
    ///   - page: 页
    ///   - rows: 每页行数
    ///   - completion: 完成回调
    func loadSearchedUserList(keyword:String,isPullUp:Bool,completion:@escaping (Bool,Bool)->()){
        
        var page = 1
        let rows = EUREQUESTCOUNT
        
        if isPullUp {
            if searchList.count >= rows {
                // swift 整数相处直接舍弃余数
                page = searchList.count / rows + 1
            }
        }
        EUNetworkManager.shared.searchUser(keyword: keyword, page: page, rows: rows) { (isSuccess, json) in
            
            if !isSuccess{
                completion(false,false)
                return
            }
            guard let json = json ,let modelarray = NSArray.yy_modelArray(with: UserInfo.self, json: json) as? [UserInfo] else{
                completion(true,false)
                return
            }
            
            var temp = [UserinfoViewModel]()
            for model in modelarray{
                temp.append(UserinfoViewModel(model: model))
            }
            
            if isPullUp{
                self.searchList = self.searchList + temp
            }else{
                self.searchList = temp
            }
            
            completion(true,true)
            
        }
        
    }
    
    /// 加载申请参加社团的成员列表
    ///
    /// - Parameters:
    ///   - cmid: 社团 ID
    ///   - completion: 完成回到
    func loadApplyCommunityUserList(cmid:Int,completion:@escaping (Bool,Bool)->()){
        EUNetworkManager.shared.getCommunityContactsByID(cmid: cmid) { (isSuccess, json) in
            if !isSuccess{
                completion(false,false)
                return
            }
            guard let json = json,let modelarray = NSArray.yy_modelArray(with: UserInfo.self, json: json) as? [UserInfo] else{
                completion(true,false)
                return
            }
            self.applycmMemberList.removeAll()
            for model in modelarray{
                // 去除正在审核的人
                if model.position > 0{
                    continue
                }
                self.applycmMemberList.append(UserinfoViewModel(model: model))
            }
            completion(true,true)
        }
    }
    
}
