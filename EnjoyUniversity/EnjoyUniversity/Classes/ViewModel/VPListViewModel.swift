//
//  VPListViewModel.swift
//  EnjoyUniversity
//
//  Created by lip on 17/3/28.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation


class VPListViewModel{
 
    lazy var imageArray = [String]()
    lazy var detailArray = [String]()
    
    func loadViewPagers(completion:@escaping (Bool)->()){
        
        EUNetworkManager.shared.getViewPagers { (json, isSuccess) in
            
            //FIXME: 加载失败使用默认图片
            if !isSuccess{
                
            }
            
            let vparray = json as? [[String:Any]] ?? []
            for dict in vparray{
                
                let imgurl = dict["imgurl"] as? String ?? ""
                let detailurl = dict["detailurl"] as? String ?? ""
                self.imageArray.append(imgurl)
                self.detailArray.append(detailurl)

                
            }
            
            completion(true)
            
        }
}
}

