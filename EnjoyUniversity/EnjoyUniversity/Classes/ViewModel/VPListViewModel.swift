//
//  VPListViewModel.swift
//  EnjoyUniversity
//
//  Created by lip on 17/3/28.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation
import SwiftyJSON
import Kingfisher

class VPListViewModel{
 
    lazy var imgArray = [UIImage]()
    lazy var detailArray = [String]()
    
    func loadViewPagers(completion:@escaping (Bool)->()){
        
        EUNetworkManager.shared.getViewPagers { (json, isSuccess) in
            
            //FIXME: 加载失败使用默认图片
            if !isSuccess{
                
            }
            
            let vparray = json as? [[String:Any]] ?? []
            for dict in vparray{
                
                let imgurl = dict["imgurl"] ?? ""
                var detailurl = dict["detailurl"] ?? ""
                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 185))
                let url = URL(string: (imgurl as? String)!)
                print(url)
                imageView.kf.setImage(with: url,
                                      placeholder: UIImage(named: "viewpager_1"),
                                      options: nil,
                                      progressBlock: nil,
                                      completionHandler: nil)
                let img = imageView.image!
                self.imgArray.append(img)
                self.detailArray.append((detailurl as? String)!)
                
            }
            
            completion(true)
            
        }
}
}

