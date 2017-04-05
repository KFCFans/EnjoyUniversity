//
//  RequestResult.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/5.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation
import YYModel

class RequestResult: NSObject {
    
    var status = 0
    
    var msg:String?
    
    var data:String?
    
    override var description: String{
        return yy_modelDescription()
    }
    
    
}
