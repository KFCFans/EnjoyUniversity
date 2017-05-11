//
//  EUNetworkManager.swift
//  EnjoyUniversity
//
//  Created by lip on 17/3/28.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation
import Alamofire


class EUNetworkManager{
    
    /// 用户账户信息
    lazy var userAccount = EUserAccount()
    
    let manager = Alamofire.SessionManager.default
    
    // 创建单例
    static let shared:EUNetworkManager = {
        // 可以在这里配置网络请求参数
        return EUNetworkManager()
    }()
    
    init() {
        manager.session.configuration.timeoutIntervalForRequest = 10
        
    }
    
    /// 封装网络请求
    ///
    /// - Parameters:
    ///   - urlString: 请求地址
    ///   - method: 请求方式，默认 GET 方式
    ///   - parameters: 请求参数
    ///   - completion: 完成回调 返回数据的 data 部分／网络请求是否成功／状态码
    func request(urlString:String,method:HTTPMethod = .get,parameters:Parameters?,completion:@escaping (Any?,Bool,Int)->())  {

        
        
//        let request = Alamofire.request(urlString, method:method, parameters: parameters, encoding: URLEncoding.default, headers: nil)
        let datarequest = manager.request(urlString, method: method, parameters: parameters, encoding: URLEncoding.default, headers: nil)
        
        
        // 设置超时时间
        
        print("请求网址:\(datarequest)")
        
        datarequest.responseJSON { (response) in
            
            if response.result.isSuccess {
                
                guard let dict = response.result.value as? [String:Any],let statuscode = dict["status"] as? Int,let json = dict["data"]  else{
                    completion(nil,false,400)
                    return
                }
                
                if statuscode == 403{
                    
                    SwiftyProgressHUD.showBigFaildHUD(text: "登陆信息失效", duration: 2)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2, execute: {
                       
                        self.userAccount.outLogin()
                        UIApplication.shared.keyWindow?.rootViewController?.present(EULoginViewController(), animated: true, completion: nil)
                    })
                    return
                }

                completion(json,true,statuscode)
                
            }else{

                completion(nil, false,0)
                
            }

        }
    }
    
    
    /// 带有 Access Token 的请求
    ///
    /// - Parameters:
    ///   - urlString: 请求地址
    ///   - method: 请求方式
    ///   - parameters: 请求参数 ［Sting:Any］类型
    ///   - completion: 完成回调
    func tokenRequest(urlString:String,method:HTTPMethod = .get,parameters:Parameters?,completion:@escaping (Any?,Bool,Int)->()){
        
        // 判断 Token 是否存在，不存在则不做请求
        guard let token = userAccount.accesstoken else {
            completion(nil, false,0)
            return
        }
        
        var parameters = parameters
        
        if parameters == nil{
            parameters = Parameters()
        }
        
        parameters!["accesstoken"] = token 
        
        request(urlString: urlString, method: method, parameters: parameters, completion: completion)
        
        
    }
    
}
