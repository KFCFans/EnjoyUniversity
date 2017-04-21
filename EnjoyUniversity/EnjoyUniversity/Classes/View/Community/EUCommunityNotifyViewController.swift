//
//  EUCommunityNotifyViewController.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/21.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class EUCommunityNotifyViewController: EUBaseViewController {
    let notifyTextview = SwiftyTextView(frame: CGRect(x: 20, y: 20, width: UIScreen.main.bounds.width, height: 200), textContainer: nil, placeholder: "")

    override func viewDidLoad() {
        super.viewDidLoad()

        print(notifyTextview.text)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
