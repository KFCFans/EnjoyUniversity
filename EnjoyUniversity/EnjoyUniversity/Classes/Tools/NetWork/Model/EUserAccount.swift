//
//  EUserAccount.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/7.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

/// 用户账户信息
class EUserAccount: NSObject {

    /// 访问令牌
    var accesstoken:String?
    
    /// 用户 uid
    var uid:Int64 = 0
    
    /// 创建时自动读取数据
    override init() {
        super.init()
        loadUserDefaults()
    }
    
    
    
    /// 保存用户信息
    func saveToUserDefaults(dict:[String:Any]){
        
        guard let token = dict["accesstoken"],
              let id = dict["uid"]   else {
            return
        }
        UserDefaults.standard.set(token, forKey: "accesstoken")
        UserDefaults.standard.set(id, forKey: "uid")

    }
    
    /// 读取用户信息
    private func loadUserDefaults(){
        
        guard let accesstoken = UserDefaults.standard.string(forKey: "accesstoken") else {
            return
        }
        
        self.accesstoken = accesstoken
        self.uid = Int64(UserDefaults.standard.integer(forKey: "uid"))
        
    }
    
    /// 退出登陆时自动销毁
    func outLogin(){
        uid = 0
        accesstoken = nil
        UserDefaults.standard.removeObject(forKey: "accesstoken")
        UserDefaults.standard.removeObject(forKey: "uid")
    }
    
}


