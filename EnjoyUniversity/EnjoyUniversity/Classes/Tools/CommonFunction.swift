//
//  CoreImage.swift
//  EnjoyUniversity
//
//  Created by lip on 17/3/6.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation
import UIKit




/// 创建指定大小和颜色的图片
///
/// - Parameters:
///   - size: 图片大小
///   - color: 图片颜色
/// - Returns: UIImage
func createImage(size:CGSize,color:UIColor)->UIImage{
    
    // 获取上下文 size表示图片大小 false表示透明 0表示自动适配屏幕大小
    UIGraphicsBeginImageContextWithOptions(size, false, 0)
    
    let context = UIGraphicsGetCurrentContext()

    // 设置颜色
    context?.setFillColor(color.cgColor)
    
    context?.setLineWidth(0.0)
    context?.fill(CGRect(origin: CGPoint(), size: size))
    
    let img = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    
    return img ?? UIImage()
    
}


/// 时间戳转时间函数
///
/// - Parameter timeStamp: 时间戳
/// - Returns: 人看得懂的时间
func timeStampToString(timeStamp:String?)->String? {
    
    guard let timeStamp = timeStamp else{
        return nil
    }
    
    let string = NSString(string: timeStamp)
    
    let timeSta:TimeInterval = string.doubleValue
    let dfmatter = DateFormatter()
    dfmatter.dateFormat="yyyy年MM月dd日"
    
    let date = NSDate(timeIntervalSince1970: timeSta/1000)
    
    return dfmatter.string(from: date as Date)
}
