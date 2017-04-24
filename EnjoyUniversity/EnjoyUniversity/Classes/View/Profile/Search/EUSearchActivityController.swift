//
//  EUSearchActivityViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/24.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUSearchActivityController: EUBaseViewController {

    let SEARCHACTIVITYCELL = "SEARCHACTIVITYCELL"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.contentInset = UIEdgeInsetsMake(64, 0, 0, 0)
        tableview.register(UINib(nibName: "EUActivityCell", bundle: nil), forCellReuseIdentifier: SEARCHACTIVITYCELL)
        
    }
    
}
