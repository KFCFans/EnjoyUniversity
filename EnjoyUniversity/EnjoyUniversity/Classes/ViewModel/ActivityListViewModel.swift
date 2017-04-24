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
    
    // 获取当前活动
    var vmlist = [ActivityViewModel]()
    
    // 获取用户参加的所有活动
    var participatedlist = [ActivityViewModel]()
    
    // 用户创建的所有活动
    var createdlist = [ActivityViewModel]()
    
    // 用户收藏的所有活动
    var collectedlist = [ActivityViewModel]()
    
    // 用户搜索的所有活动
    var searchedlist = [ActivityViewModel]()
    
    /// 加载活动数据
    ///
    /// - Parameters:
    ///   - isPullingUp: 上拉加载更多标记
    ///   - completion: 是否加载成功，是否需要刷新表格
    func loadActivityList(isPullingUp:Bool = false,completion:@escaping (Bool,Bool)->()){
        
        var maxtime:String?
        
//        var mintime:String?
        
        // 判断下拉刷新
//        if !isPullingUp && vmlist.count > 0 {
//            mintime = vmlist.first?.activitymodel.avStarttime
//        }
        
        // 判断上拉加载
        if isPullingUp && vmlist.count > 0 {
            maxtime = vmlist.last?.activitymodel.avStarttime
        }
        
        
        
        EUNetworkManager.shared.getActivityList(mintime: nil, maxtime: maxtime) { (array, isSuccess) in
            
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
                self.vmlist = tempvmlist
            }
            print("加载到的数据条数:\(tempvmlist.count)")
            completion(true, true)
            
        }
        
    }
    
    
    /// 我参加的活动
    ///
    /// - Parameter completion: 是否需要刷新表格
    func loadParticipatdActivity(completion:@escaping (Bool)->()){
        
        EUNetworkManager.shared.getParticipatedActivityList { (array, isSuccess) in
            
            if !isSuccess{
                completion(false)
                return
            }
            
            guard let modelarray = NSArray.yy_modelArray(with: Activity.self, json: array ?? []) as? [Activity] else{
                completion(false)
                return
            }
            
            // 判断是否需要刷新
            if modelarray.count == 0{
                completion(false)
                return
            }
            
            // 接受数据
            var tempvmlist = [ActivityViewModel]()
            for model in modelarray{
                tempvmlist.append(ActivityViewModel(model: model))
            }
            
            tempvmlist = tempvmlist.sorted(by: { (x:ActivityViewModel, y:ActivityViewModel) -> Bool in
                
                return Int(x.activitymodel.avStarttime ?? "0") ?? 0 < Int(y.activitymodel.avStarttime ?? "0") ?? 0
            })
            
            // 将已结束的活动放倒最末端
            self.participatedlist = tempvmlist
            for (index,viewmodel) in tempvmlist.enumerated(){
                if viewmodel.isFinished{
                    self.participatedlist.remove(at: index)
                    self.participatedlist.append(viewmodel)
                }
            }
            
            completion(true)

        }
        
        
    }
    
    /// 我创建的活动
    ///
    /// - Parameter completion: 是否需要刷新表格
    func loadCreatedActivity(completion:@escaping (Bool)->()){
        
        EUNetworkManager.shared.getCreatedActivityList { (array, isSuccess) in
            
            if !isSuccess{
                completion(false)
                return
            }
            
            guard let modelarray = NSArray.yy_modelArray(with: Activity.self, json: array ?? []) as? [Activity] else{
                completion(false)
                return
            }
            
            // 判断是否需要刷新
            if modelarray.count == 0{
                completion(false)
                return
            }
            
            // 接受数据
            var tempvmlist = [ActivityViewModel]()
            
            for model in modelarray{
                tempvmlist.append(ActivityViewModel(model: model))
            }
            
            tempvmlist = tempvmlist.sorted(by: { (x:ActivityViewModel, y:ActivityViewModel) -> Bool in
                
                return Int(x.activitymodel.avStarttime ?? "0") ?? 0 < Int(y.activitymodel.avStarttime ?? "0") ?? 0
            })
            // 将已结束的活动放倒最末端
            self.createdlist = tempvmlist
            for (index,viewmodel) in tempvmlist.enumerated(){
                if viewmodel.isFinished{
                    self.createdlist.remove(at: index)
                    self.createdlist.append(viewmodel)
                }
            }
           

            completion(true)
            
        }
        
    }
    
    /// 加载我收藏的活动
    ///
    /// - Parameter completion: 完成回调 网络请求是否成功,是否有数据
    func loadMyCollectedActivity(completion:@escaping (Bool,Bool)->()){
        
        EUNetworkManager.shared.getMyActivityCollection { (isSuccess, array) in
            
            if !isSuccess{
                completion(false,false)
                return
            }
            guard let array = array,let modelarray = NSArray.yy_modelArray(with: Activity.self, json: array) as? [Activity] else{
                completion(true, false)
                return
            }
            if modelarray.count == 0{
                completion(true,false)
                return
            }
            
            // 接受数据
            var tempvmlist = [ActivityViewModel]()
            
            for model in modelarray{
                tempvmlist.append(ActivityViewModel(model: model))
            }
            
            tempvmlist = tempvmlist.sorted(by: { (x:ActivityViewModel, y:ActivityViewModel) -> Bool in
                
                return Int(x.activitymodel.avStarttime ?? "0") ?? 0 < Int(y.activitymodel.avStarttime ?? "0") ?? 0
            })
            // 将已结束的活动放倒最末端
            self.collectedlist = tempvmlist
            for (index,viewmodel) in tempvmlist.enumerated(){
                if viewmodel.isFinished{
                    self.collectedlist.remove(at: index)
                    self.collectedlist.append(viewmodel)
                }
            }
            completion(true,true)
        }
        
    }
    
    /// 加载搜索的活动
    ///
    /// - Parameter completion: 完成回调
    func loadSearchedActivity(keyword:String,isPullup:Bool,completion:@escaping (Bool,Bool)->()){
        
        var page = 1
        let rows = EUREQUESTCOUNT
        
        if searchedlist.count >= rows{
            page = searchedlist.count / rows + 1
        }
        
        EUNetworkManager.shared.searchActivity(keyword: keyword, page: page, rows: rows) { (isSuccess, array) in
            
            if !isSuccess{
                completion(false,false)
                return
            }
            guard let array = array,let modelarray = NSArray.yy_modelArray(with: Activity.self, json: array) as? [Activity] else{
                completion(true,false)
                return
            }
            
            var temp = [ActivityViewModel]()
            for model in modelarray{
                temp.append(ActivityViewModel(model: model))
            }
            
            if isPullup{
                
            }else{
                
            }
            
        }
        
    }
}
