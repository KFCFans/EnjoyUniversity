//
//  EUCommunityWallCell.swift
//  EnjoyUniversity
//
//  Created by lip on 17/2/27.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCommunityWallCell: UITableViewCell {
    
    // 图标
    @IBOutlet weak var communityIcon: UIImageView!
    
    // 背景图片
    @IBOutlet weak var communityBGI: UIImageView!
    
    // 社团名称
    @IBOutlet weak var communityName: UILabel!
    
    // 社团简介
    @IBOutlet weak var communityIntro: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        
        frame = CGRect(x: 0, y: 0, width: 400, height: 360)
        layoutIfNeeded()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
