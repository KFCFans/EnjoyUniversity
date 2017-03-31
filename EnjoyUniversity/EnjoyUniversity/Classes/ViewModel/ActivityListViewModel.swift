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
    
    /// 加载活动数据
    ///
    /// - Parameters:
    ///   - isPullingUp: 上拉加载更多标记
    ///   - completion: 是否加载成功，是否需要刷新表格
    func loadActivityList(isPullingUp:Bool = false,completion:@escaping (Bool,Bool)->()){
        
        var maxtime:String?
        
        var mintime:String?
        
        // 判断下拉刷新
        if !isPullingUp && vmlist.count > 0 {
            mintime = vmlist.first?.activitymodel.avStarttime
        }
        
        // 判断上拉加载
        if isPullingUp && vmlist.count > 0 {
            maxtime = vmlist.last?.activitymodel.avStarttime
        }
        
        
        
        EUNetworkManager.shared.getActivityList(mintime: mintime, maxtime: maxtime) { (array, isSuccess) in
            
            if !isSuccess{
                completion(false,false)
                return
            }
            
            guard let modelarray = NSArray.yy_modelArray(with: Activity.self, json: array ?? []) as? [Activity] else{
                completion(false,false)
                return
            }
            
            // 判断是否已加载全部数据
            if modelarray.count == 0{
                completion(true,false)
                return
            }
            
            // 接受数据
            var tempvmlist = [ActivityViewModel]()
            
            for model in modelarray{
                tempvmlist.append(ActivityViewModel(model: model))
            }
            
            // 拼接数据
            if isPullingUp{
                self.vmlist = self.vmlist + tempvmlist
            }else{
                self.vmlist = tempvmlist + self.vmlist
            }
            print("加载到的数据条数:\(tempvmlist.count)")
            completion(true, true)
            
        }
        
    }
    
}
