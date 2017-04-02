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
    
    lazy var modelList = [CommunityViewModel]()
    
    
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
    
    
}
