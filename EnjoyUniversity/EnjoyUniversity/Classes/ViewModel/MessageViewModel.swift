//
//  MessageViewModel.swift
//  EnjoyUniversity
//
//  Created by lip on 17/5/3.
//  Copyright © 2017年 lip. All rights reserved.
//

import Foundation

class MessageViewModel{
    
    /// 通知消息模型
    var model:Message?
    
    /// 通知消息的文本高度
    var messageHeight:CGFloat = 0
    
    /// 人看得懂的发送时间
    var sendTime:String?
    
    init(model:Message) {
        self.model = model
        
        // 人看得懂的时间
        sendTime = timeStampToString(timeStamp: model.sendtime, formate: "yyyy-MM-dd HH:mm")
        
        // 计算文本高度
        messageHeight = calculateLabelHeight(text: model.msg ?? "暂时没有消息", width: UIScreen.main.bounds.width - 24, font: 15)
        
        
    }
    
}
