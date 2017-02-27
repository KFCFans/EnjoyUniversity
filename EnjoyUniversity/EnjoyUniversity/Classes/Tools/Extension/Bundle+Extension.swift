//
//  Bundle+Extension.swift
//  EnjoyUniversity
//
//  Created by lip on 17/2/27.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation

extension Bundle{
    //计算型属性类似于函数，没有参数有返回值，无法存储只能计算
    var namespace:String{
        return infoDictionary?["CFBundleName"] as? String ?? ""
    }
}
