//
//  EUProfileTableViewCell.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/10.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUProfileTableViewCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    init(image:UIImage,title:String,style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: nil)
        
        let imgview = UIImageView(frame: CGRect(x: 15, y: 12, width: 20, height: 20))
        imgview.image = image
        addSubview(imgview)
        
        let mytitleLabel = UILabel(frame: CGRect(x: 53, y: 13, width: 80, height: 15))
        mytitleLabel.text = title
        mytitleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        mytitleLabel.textColor = UIColor.init(red: 82/255, green: 82/255, blue: 82/255, alpha: 1)
        mytitleLabel.center.y = center.y
        mytitleLabel.sizeToFit()
        addSubview(mytitleLabel)
        
    }
    

}

