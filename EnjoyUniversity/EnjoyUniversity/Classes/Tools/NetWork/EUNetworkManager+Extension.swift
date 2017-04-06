//
//  EUNetworkManager+Extension.swift
//  EnjoyUniversity
//
//  Created by lip on 17/3/28.
//  Copyright © 2017年 lip. All rights reserved.
//

// MARK: - 封装具体的网络接口
import Alamofire


// MARK: - 读取接口
extension EUNetworkManager{
    
    
    /// 获取 ViewPager
    func getViewPagers(completion:@escaping (Any?,Bool)->()){
        
        let url = SERVERADDRESS + "/eu/viewpager/show"
        
        request(urlString: url, parameters: nil) { (json, isSuccess) in
            completion(json, isSuccess)

        }
        
    }
    
    /// 获取社团数据 注意：page的0和1一样
    func getCommunityList(page:Int = 1,rows:Int = EUREQUESTCOUNT,completion:@escaping ([[String:Any]]?,Bool)->()){
        
        let url = SERVERADDRESS + "/eu/community/commoncm"
        
        var paramters = Parameters()
        
        paramters["page"] = page
        paramters["rows"] = rows
        
        request(urlString: url, parameters: paramters) { (json, isSuccess) in
            
            let array = json as? [[String:Any]]
            completion(array, isSuccess)
            
        }
        
    }
    
    /// 获取活动数据
    func getActivityList(mintime:String?,maxtime:String?,count:Int = EUREQUESTCOUNT,completion:@escaping ([[String:Any]]?,Bool)->()){
     
        let url = SERVERADDRESS + "/eu/activity/commonav"
        
        var parameters = Parameters()
        parameters["count"] = count
        
        if let mintime = mintime {
            parameters["mintime"] = mintime
        }
        
        if let maxtime = maxtime {
            parameters["maxtime"] = maxtime
        }
        
        request(urlString: url, parameters: parameters) { (json, isSuccess) in
            guard let array = json as? [[String:Any]] else{
                completion(nil, false)
                return
            }
            completion(array,true)
        }
        
    }
    
    /// 获取我参加的活动数据
    func getParticipatedActivityList(completion:@escaping ([[String:Any]]?,Bool)->()){
        
        let url = SERVERADDRESS + "/eu/activity/joinedav"
        
        var parameters = Parameters()
        // FIXME: 用户登录后，获取用户 uid
        parameters["uid"] = "15061883391"
        
        tokenRequest(urlString: url, method: .post, parameters: parameters) { (json, isSuccess) in
            
            guard let array = json as? [[String:Any]] else{
                completion(nil,false)
                return
            }
            completion(array,true)
            
        }
        
        
    }
    
    /// 获取我创建的活动数据
    func getCreatedActivityList(completion:@escaping ([[String:Any]]?,Bool)->()){
        
        let url = SERVERADDRESS + "/eu/activity/createdav"
        
        var parameters = Parameters()
        // FIXME: 用户登录后，获取用户 uid
        parameters["uid"] = "15061883391"
        
        tokenRequest(urlString: url, method: .post, parameters: parameters) { (json, isSuccess) in
            
            guard let array = json as? [[String:Any]] else{
                completion(nil,false)
                return
            }
            completion(array,true)
            
        }
        
        
    }
    

}

// MARK: - 写入接口
extension EUNetworkManager{
    
    
    /// 创建活动
    func releaseActivity(activity:Activity,completion:@escaping (Bool)->()){
        
        let url = SERVERADDRESS + "/eu/activity/createav"
        
        var parameters = Parameters()
        
        // FIXME: 用户登陆后，获取用户 uid
        parameters["uid"] = "15061883391"
        
        parameters["avTitle"] = activity.avTitle
        parameters["avDetail"] = activity.avDetail
        parameters["avPlace"] = activity.avPlace
        parameters["avPrice"] = activity.avPrice
        parameters["avExpectnum"] = activity.avExpectnum
        parameters["avstarttime"] = activity.avStarttime
        parameters["avendtime"] = activity.avEndtime
        parameters["avenrolldeadline"] = activity.avEnrolldeadline
        parameters["avRegister"] = activity.avRegister
        
        tokenRequest(urlString: url, method: .post, parameters: parameters) { (json, isSuccess) in
            
            if !isSuccess{
                completion(false)
                return
            }
            guard let array = json as? [String:Any] else{
                completion(false)
                return
            }
            
            if let status = array["status"] as? Int {
                
                if status == 200{
                    
                    completion(true)
                }else{
                    completion(false)
                }
                return
                
            }
            
        }
        
    }

}

// MARK: - 上传接口
extension EUNetworkManager{
    
    func uploadActivityLogo(uploadimg:UIImage){
        
        let url = SERVERADDRESS + "/eu/upload/activity"
        
        //将选择的图片保存到Document目录下
        let fileManager = FileManager.default
        let rootPath = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask, true)[0] as String
        let filePath = "\(rootPath)/pickedimage.jpg"
        let imageData = UIImageJPEGRepresentation(uploadimg, 1.0)
        fileManager.createFile(atPath: filePath, contents: imageData, attributes: nil)
        print(filePath)
        //上传图片
        if (fileManager.fileExists(atPath: filePath)){
            //取得NSURL
            //let imageNSURL:NSURL = NSURL.init(fileURLWithPath: filePath)
            Alamofire.upload(multipartFormData: { (multipartdata) in
                
                multipartdata.append(URL(fileURLWithPath: filePath), withName: "file")
                
            }, to: url, encodingCompletion: { (encodingResult) in
                
           
                // 接受从服务器返回的参数
                switch encodingResult {
                case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                    upload.responseJSON(completionHandler: { (json) in
                        print(json)
                    })
                    break
                case .failure(let error):
                    print(error)
                    break
                    
                }
                
            })

            
            
        }
        
    }
    
}
