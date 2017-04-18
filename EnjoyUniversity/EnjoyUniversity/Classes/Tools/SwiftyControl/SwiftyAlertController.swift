//
//  SwiftyAlertController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/18.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class SwiftyAlertController: UIAlertController {

    let textview = UITextView(frame: CGRect(x: 16, y: 43.5, width: 238, height: 80))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTextField { (tv) in
            tv.removeFromSuperview()
        }
        view.addSubview(textview)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        textview.becomeFirstResponder()
    }

}
