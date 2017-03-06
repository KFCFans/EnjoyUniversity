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
