//
//  TableviewProtocol.swift
//  NewsDomo-Swift
//
//  Created by Dai Qinfu on 16/4/26.
//  Copyright © 2016年 Wingzki. All rights reserved.
//

import UIKit

let CellSnap  = "SnapTableViewCell"
let CellImage = "ImageTableViewCell"

class TableviewProtocol: NSObject, UITableViewDataSource, UITableViewDelegate {

    var newsArray : NSArray?
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = self.newsArray?.count {
            
            return count
            
        }
        
        return 0
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0 {
            
            let cell : SnapTableViewCell = tableView.dequeueReusableCellWithIdentifier(CellSnap) as! SnapTableViewCell
            
            if let data : NSDictionary = self.newsArray?[indexPath.row] as? NSDictionary {
                
                cell.titleLabel.text  = data["title"] as? String
                cell.detailLabel.text = data["digest"] as? String
                
                if let url : String = data["img"] as? String {
                    
                    cell.testImageView.kf_setImageWithURL(NSURL.init(string: url)!)
                    
                }
                
            }
            
            return cell
            
        }else {
            
            let cell : ImageTableViewCell = tableView.dequeueReusableCellWithIdentifier(CellImage) as! ImageTableViewCell
            
            if let data : NSDictionary = self.newsArray?[indexPath.row] as? NSDictionary {
                
                cell.titleLabel.text  = data["title"] as? String
                
                if let url : String = data["img"] as? String {
                    
                    cell.bigImageView.kf_setImageWithURL(NSURL.init(string: url)!)
                    
                }
                
            }
            
            return cell
            
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row % 2 == 0 {
            return 90.0
        }else {
            return 170.0
        }
        
    }

    
}
