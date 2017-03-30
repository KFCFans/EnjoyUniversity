//
//  ActivityListViewModel.swift
//  EnjoyUniversity
//
//  Created by lip on 17/3/30.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation
import YYModel


class ActivityListViewModel{
    
    var vmlist = [ActivityViewModel]()
    
    func loadActivityList(completion:@escaping (Bool)->()){
        
        EUNetworkManager.shared.getActivityList { (array, isSuccess) in
            
            if !isSuccess{
                completion(false)
            }
            
            guard let modelarray = NSArray.yy_modelArray(with: Activity.self, json: array ?? []) as? [Activity] else{
                completion(false)
                return
            }
            
            for model in modelarray{
                print(model)
                self.vmlist.append(ActivityViewModel(model: model))
            }
            
            
            
        }
        
    }
    
}
