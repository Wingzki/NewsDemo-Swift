//
//  TitleSegment.swift
//  NewsDomo-Swift
//
//  Created by Dai Qinfu on 16/4/23.
//  Copyright © 2016年 Wingzki. All rights reserved.
//

import UIKit

class TitleSegment: UIView {

    var titleArray : Array<String>? {
        
        didSet {
            
            createTitleViews()
            
        }
        
    }
    
    lazy var scrollView : UIScrollView = {
        
        let temp = UIScrollView();
        temp.showsHorizontalScrollIndicator = false
        temp.backgroundColor = UIColor.redColor()
        
        return temp
    }()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        scrollView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        self.addSubview(scrollView)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createTitleViews() {
        
        for subview in self.scrollView.subviews {
            
            subview.removeFromSuperview()
            
        }
        
        if let count = titleArray?.count {
            
            let width : CGFloat = 80
            
            for i in 0..<count {
                
                let button = UIButton()
                button.frame = CGRectMake(CGFloat(i) * width, 0, width, frame.size.height)
                button.backgroundColor = UIColor.greenColor()
                self.scrollView.addSubview(button)
                
                if let title = self.titleArray?[i] {
                    
                    button.setTitle(title, forState: UIControlState.Normal)
                    
                }
                
            }
            
            scrollView.contentSize = CGSizeMake(width * CGFloat(count), self.frame.size.height)
            
        }
        
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
