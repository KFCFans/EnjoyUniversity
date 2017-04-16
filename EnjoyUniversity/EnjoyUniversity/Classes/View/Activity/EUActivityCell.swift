//
//  EUActivityCell.swift
//  EnjoyUniversity
//
//  Created by lip on 17/3/7.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit
import Kingfisher

class EUActivityCell: UITableViewCell {
    
    var activityVM:ActivityViewModel?{
        
        didSet{
         
            activityName.text = activityVM?.activitymodel.avTitle
            activityTime.text = activityVM?.startTime
            activityLocation.text = activityVM?.activitymodel.avPlace
            activityPrice.text = activityVM?.price
            if activityVM?.isFinished ?? true{
                activityIcon.image = UIImage(named: "av_finished")
                activityIcon.contentMode = .scaleAspectFit
            }else{
                let iconurl = URL(string: activityVM?.imageURL ?? "")
                activityIcon.kf.setImage(with: iconurl,
                                         placeholder: UIImage(named: "eu_placeholder"),
                                         options: [.transition(.fade(1))],
                                         progressBlock: nil,
                                         completionHandler: nil)
            }
            
        }
        
    }
    
    @IBOutlet weak var activityIcon: UIImageView!
    @IBOutlet weak var activityName: UILabel!
    @IBOutlet weak var activityLocation: UILabel!
    @IBOutlet weak var activityTime: UILabel!
    @IBOutlet weak var activityPrice: UILabel!

    

    override func awakeFromNib() {
        super.awakeFromNib()

        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
