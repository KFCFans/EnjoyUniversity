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
    
    lazy var modelList = [Community]()
    
    
    func loadCommunityList(completion:@escaping (Bool)->()){
        
        EUNetworkManager.shared.getCommunityList { (list, isSuccess) in
            
            // 1.字典数组转模型数组
            guard let modelArray = NSArray.yy_modelArray(with: Community.self, json: list ?? []) as? [Community] else{
                return
            }
    
            self.modelList += modelArray
            
            completion(isSuccess)
        }
        
        
        
    }
    
    
}
