//
//  CommunityAuthorityListViewModel.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/15.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation

class CommunityAuthorityListViewModel{
    
    
    lazy var communityauthoritylist = [CommunityAuthority]()
    
    /// 加载我参加的社团信息
    ///
    /// - Parameter completion: 完成回调
    func loadCommunityNameList(completion:@escaping (Bool,Bool)->()){
        
        EUNetworkManager.shared.getCommunityNameList { (isSuccess, array) in
            
            if !isSuccess{
                completion(false,false)
                return
            }
            guard let array = array,let temp = NSArray.yy_modelArray(with: CommunityAuthority.self, json: array) as? [CommunityAuthority] else{
                // 还没有加入社团
                completion(true,false)
                return
            }
            
            // 排序
            self.communityauthoritylist = temp.sorted(by: { (x:CommunityAuthority, y:CommunityAuthority) -> Bool in
                return x.lastselect > y.lastselect
            })
            
            completion(true,true)
        }
    }
    
}
