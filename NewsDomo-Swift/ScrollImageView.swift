//
//  ScrollImageView.swift
//  NewsDomo-Swift
//
//  Created by Dai Qinfu on 16/4/19.
//  Copyright © 2016年 Wingzki. All rights reserved.
//

import UIKit

import Kingfisher

class ScrollImageView: UIView, UIScrollViewDelegate {

    var imageURLArray: Array<String>? {

        didSet {
            
            creatImageViews()
            
        }
        
    }
    
    var scrollView : UIScrollView?
    var timer : NSTimer?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView = UIScrollView.init(frame: CGRectMake(0, 0, frame.size.width, frame.size.height))
        scrollView?.pagingEnabled = true
        scrollView?.delegate      = self;
        self.addSubview(scrollView!)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatImageViews() {
    
        for subview in scrollView!.subviews {
            
            subview.removeFromSuperview()
            
        }
        
        if let count = imageURLArray?.count {
            
            for index in 0..<count {
                
                let imageView = UIImageView()
                imageView.frame = CGRectMake(CGFloat(index) * self.frame.size.width, 0 ,self.frame.size.width, self.frame.size.height)
                
                scrollView!.addSubview(imageView)
                
                if let url = imageURLArray?[index] {
                    
                    imageView.kf_setImageWithURL(NSURL.init(string: url)!)
                    
                }
                
            }
            
            let imageLeft = UIImageView.init(frame: CGRectMake(-self.frame.size.width, 0, self.frame.size.width, self.frame.size.height))
            scrollView!.addSubview(imageLeft)
            
            if let url = imageURLArray?[count - 1] {
                
                imageLeft.kf_setImageWithURL(NSURL.init(string: url)!)
                
            }
            
            let imageRight = UIImageView.init(frame: CGRectMake(CGFloat(count) * self.frame.size.width, 0, self.frame.size.width, self.frame.size.height))
            scrollView!.addSubview(imageRight)
            
            if let url = imageURLArray?[0] {
                
                imageRight.kf_setImageWithURL(NSURL.init(string: url)!)
                
            }
            
            scrollView?.contentSize = CGSizeMake(CGFloat(count) * self.frame.size.width , self.frame.size.height)
            scrollView?.contentInset = UIEdgeInsetsMake(0, self.frame.size.width, 0, self.frame.size.width)
            
        }
        
        if ((self.timer?.valid) != nil) {
            
            self.timer?.invalidate()
            
        }
        
        self.timer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: #selector(timerHanle), userInfo: nil, repeats: true)
    
    }
    
    func timerHanle(){
        
        self.scrollView?.setContentOffset(CGPointMake(self.scrollView!.contentOffset.x + self.frame.size.width, 0), animated: true)
        
    }
    
//    MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let point = scrollView.contentOffset
        
        if point.x == -self.frame.size.width {
            
            scrollView.setContentOffset(CGPointMake(scrollView.contentSize.width - self.frame.size.width, 0), animated: false)
            
        }else if point.x == scrollView.contentSize.width {
            
            scrollView.setContentOffset(CGPointMake(0, 0), animated: false)
            
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
