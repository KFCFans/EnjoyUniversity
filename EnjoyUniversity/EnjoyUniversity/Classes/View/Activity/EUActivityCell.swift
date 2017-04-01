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
            let iconurl = URL(string: activityVM?.activitymodel.avLogo ?? "")
            activityIcon.kf.setImage(with: iconurl,
                                     placeholder: nil,
                                     options: nil,
                                     progressBlock: nil,
                                     completionHandler: nil)
            
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
