//
//  UITableView+Extension.swift
//  EnjoyUniversity
//
//  Created by lip on 17/5/9.
//  Copyright © 2017年 lip. All rights reserved.
//

extension UITableView{
    
    func showPlaceHolderView(){
        
        let noneImage = UIImageView(image: UIImage(named: "eu_nothing"))
        noneImage.center.x = center.x
        noneImage.center.y = center.y - 64
        addSubview(noneImage)
    }
    
}
