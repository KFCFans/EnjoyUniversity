//
//  EUCommunityWallCell.swift
//  EnjoyUniversity
//
//  Created by lip on 17/2/27.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit
import Kingfisher

class EUCommunityWallCell: UITableViewCell {
    
    var communityModel:CommunityViewModel?{
        
        didSet{
            communityName.text = communityModel?.communitymodel?.cmName
            communityIntro.text = communityModel?.communitymodel?.cmDetail
            let logourl = URL(string: communityModel?.communitymodel?.cmLogo ?? "")
            let bgiurl = URL(string: communityModel?.communitymodel?.cmBackground ?? "")
            communityIcon.kf.setImage(with: logourl,
                                      placeholder: UIImage(named: "Facebook_25"),
                                      options: [.transition(.fade(1))],
                                      progressBlock: nil,
                                      completionHandler: nil)
            communityBGI.kf.setImage(with: bgiurl,
                                      placeholder: UIImage(named: "wallbackground"),
                                      options: [.transition(.fade(1))],
                                      progressBlock: nil,
                                      completionHandler: nil)
        }
        
    }
    
    
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
