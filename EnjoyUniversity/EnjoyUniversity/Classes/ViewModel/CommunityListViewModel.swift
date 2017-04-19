//
//  CommunityListViewModel.swift
//  EnjoyUniversity
//
//  Created by lip on 17/3/30.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation
import YYModel

class CommunityListViewModel{
    
    /// 我参加的活动视图模型列表
    lazy var modelList = [CommunityViewModel]()
    
    /// 我收藏的活动视图模型列表
    lazy var collectedlist = [CommunityViewModel]()
    
    
    
    /// 加载社团列表
    ///
    /// - Parameters:
    ///   - isPullUp: 是否为上拉加载更多
    ///   - completion: 完成回调
    func loadCommunityList(isPullUp:Bool,completion:@escaping (Bool,Bool)->()){
        
        var page = 1
        let rows = EUREQUESTCOUNT
        
        if isPullUp {
            
            if modelList.count > 0 {
                
                // swift 整数相处直接舍弃余数
                page = modelList.count / rows + 1
            }
        }
        
        EUNetworkManager.shared.getCommunityList(page: page,rows: rows) { (list, isSuccess) in
            
            // 1.字典数组转模型数组
            guard let modelArray = NSArray.yy_modelArray(with: Community.self, json: list ?? []) as? [Community] else{
                completion(false,false)
                return
            }
            
            if modelArray.count == 0{
                completion(true,false)
                return
            }
            
            var temp = [CommunityViewModel]()
            for model in modelArray {
                temp.append(CommunityViewModel(model: model))
            }
            
            if isPullUp {
                self.modelList = self.modelList + temp
            }else{
                self.modelList = temp
            }
    
            completion(true,true)
        }
        
    }
    
    /// 加载我收藏的社团列表
    ///
    /// - Parameter completion: 完成回调
    func loadMyCommunityCollection(completion:@escaping (Bool,Bool)->()){
        
        EUNetworkManager.shared.getMyCommunityCollection { (isSuccess, array) in
            
            if !isSuccess{
                completion(false,false)
                return
            }
            guard let array = array,let modelarray = NSArray.yy_modelArray(with: Community.self, json: array) as? [Community] else{
                completion(true,false)
                return
            }
            
            for model in modelarray{
                self.collectedlist.append(CommunityViewModel(model: model))
            }
            completion(true,true)
        }
    
    }
    
    
}
