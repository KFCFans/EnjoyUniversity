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
func timeStampToString(timeStamp:String?,formate:String = "MM-dd HH:mm")->String? {
    
    guard let timeStamp = timeStamp else{
        return nil
    }
    
    let string = NSString(string: timeStamp)
    
    let timeSta:TimeInterval = string.doubleValue
    let dfmatter = DateFormatter()
    dfmatter.dateFormat = formate
    
    let date = NSDate(timeIntervalSince1970: timeSta/1000)
    
    return dfmatter.string(from: date as Date)
}


/// 时间转时间戳
///
/// - Parameter stringTime: 人看的懂的时间
/// - Returns: 时间戳
func stringToTimeStamp(stringTime:String)->String {
    
    let dfmatter = DateFormatter()
    dfmatter.dateFormat="yyyy-MM-dd HH:mm"
    let date = dfmatter.date(from: stringTime)
    let dateStamp:TimeInterval = date!.timeIntervalSince1970
    let dateSt:Int = Int(dateStamp) * 1000
    print(dateSt)
    return String(dateSt)
    
}


/// 计算文本高度
///
/// - Parameters:
///   - text: 文本
///   - width: 目标区域宽度
///   - font: 文本字体大小
/// - Returns: 文本高度
func calculateLabelHeight(text:String,width:CGFloat,font:CGFloat)->CGFloat{
    
    let textfont = UIFont.boldSystemFont(ofSize: font)
    
    let size = CGSize(width: width, height: 5000)
    
    let height = (text as NSString).boundingRect(with: size,
                                                 options: NSStringDrawingOptions.usesLineFragmentOrigin,
                                                 attributes: [NSFontAttributeName:textfont],
                                                 context: nil).height
    return height
}


/// 裁切图像为圆角图片
///
/// - Parameters:
///   - image: 原图
///   - size: 大小
///   - opaque: 是否透明 true不透明 false透明
///   - backColor: 背景颜色（不透明的话设为同色看不出来）,透明不需要传
/// - Returns: 裁剪后的圆形图像
func avatarImage(image:UIImage?,size:CGSize,opaque:Bool,backColor:UIColor?)->UIImage?{
    
    guard let image = image else {
        return nil
    }
    
    let rect = CGRect(origin: CGPoint.zero, size: size)
    
    UIGraphicsBeginImageContextWithOptions(size, opaque, 0)
    
    // 背景填充
    if opaque {
        backColor?.setFill()
        UIRectFill(rect)
    }
    
    // 实例化圆形路径
    let path = UIBezierPath(ovalIn: rect)
    path.addClip()
    
    image.draw(in: rect)
    
    // 绘制边线
    UIColor.white.setStroke()
    path.lineWidth = 2
    path.stroke()
    
    // 取得结果
    let result = UIGraphicsGetImageFromCurrentImageContext()
    
    UIGraphicsEndImageContext()
    
    return result
}

/// 生成二维码
///
/// - Parameters:
///   - qrString: 二维码信息
///   - qrImageName: 二维码 logo
/// - Returns: 二维码
func createQRForString(qrString: String?, qrImageName: String?) -> UIImage?{
    if let sureQRString = qrString{
        let stringData = sureQRString.data(using: String.Encoding.utf8, allowLossyConversion: false)
        //创建一个二维码的滤镜
        let qrFilter = CIFilter(name: "CIQRCodeGenerator")
        qrFilter?.setValue(stringData, forKey: "inputMessage")
        qrFilter?.setValue("H", forKey: "inputCorrectionLevel")
        let qrCIImage = qrFilter?.outputImage
        
        // 创建一个颜色滤镜,黑白色
        let colorFilter = CIFilter(name: "CIFalseColor")!
        colorFilter.setDefaults()
        colorFilter.setValue(qrCIImage, forKey: "inputImage")
        colorFilter.setValue(CIColor(red: 0, green: 0, blue: 0), forKey: "inputColor0")
        colorFilter.setValue(CIColor(red: 1, green: 1, blue: 1), forKey: "inputColor1")
        // 返回二维码image
        let codeImage = UIImage(ciImage: (colorFilter.outputImage!.applying(CGAffineTransform(scaleX: 5, y: 5))))
        
        // 中间一般放logo
        if let iconImage = UIImage(named: qrImageName ?? "") {
            let rect = CGRect(x: 0, y: 0, width: codeImage.size.width, height: codeImage.size.height)
            
            UIGraphicsBeginImageContext(rect.size)
            codeImage.draw(in: rect)
            let avatarSize = CGSize(width: rect.size.width*0.25, height: rect.size.height*0.25)
            
            let x = (rect.width - avatarSize.width) * 0.5
            let y = (rect.height - avatarSize.height) * 0.5
            iconImage.draw(in: CGRect(x: x, y: y, width: avatarSize.width, height: avatarSize.height))
            
            let resultImage = UIGraphicsGetImageFromCurrentImageContext()
            
            UIGraphicsEndImageContext()
            return resultImage
        }
        return codeImage
    }
    return nil
}




