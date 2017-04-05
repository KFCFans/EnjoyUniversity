//
//  SwiftyTextView.swift
//  EnjoyUniversity
//
//  Created by lip on 17/4/5.
//  Copyright © 2017年 lip. All rights reserved.
//

import UIKit

class SwiftyTextView: UITextView,UITextViewDelegate {

    lazy var placeholder = UILabel()

    
    init(frame:CGRect,textContainer:NSTextContainer?,placeholder:String) {
        super.init(frame: frame, textContainer: textContainer)
        self.placeholder.text = placeholder
        delegate = self
        setupPlaceHolder()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPlaceHolder(){
        
        placeholder.font = self.font
        placeholder.textColor = UIColor.lightGray
        placeholder.sizeToFit()
        placeholder.frame.origin = CGPoint(x: 5, y: 8)
        addSubview(placeholder)
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        placeholder.isHidden = self.hasText
    }

}

