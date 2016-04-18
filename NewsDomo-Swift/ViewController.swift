//
//  ViewController.swift
//  NewsDomo-Swift
//
//  Created by Dai Qinfu on 16/4/7.
//  Copyright © 2016年 Wingzki. All rights reserved.
//

import UIKit

import Alamofire
import Kingfisher

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let CellSnap  = "SnapTableViewCell"
    let CellImage = "ImageTableViewCell"
    
    
    var newsArray : NSArray? = []
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubView()
        setupSubview()
        setupLayout()
        
        getDataFromServer()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    MSAK: - ViewSetup
    
    func addSubView() {
        
        self.view.addSubview(tableView)
        
    }
    
    func setupLayout() {
        
        self.tableView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        
    }
    
    func setupSubview() {
        
        self.tableView.delegate   = self
        self.tableView.dataSource = self
        
        self.tableView.registerClass(SnapTableViewCell.self, forCellReuseIdentifier: CellSnap)
        self.tableView.registerClass(ImageTableViewCell.self, forCellReuseIdentifier: CellImage)
        
    }
    
    //    MASK: - Private
    
    func getDataFromServer() {
        
        let url = "http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html?from=toutiao&passport=&devId=ECIDH5J3VtJNmnlsgmFGFUgU324iLqCs%2FTN6KzBE6GrzJ6En48foT5R9wH%2FOcJXY&size=20&version=6.0&spever=false&net=wifi&lat=BNsQafMiQurgbJgINKDqOA%3D%3D&lon=bSHK%2B1pn5rA0G0bX3U5%2FOQ%3D%3D&ts=1460300866&sign=sZkXOQmPZa571vREFlmf4Ko0tVPzkKGHYxTTQ3x8M1N48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore"
        
        Alamofire.request(Method.GET, url).responseJSON { response in
            
            if let dic = response.result.value as? NSDictionary {
                
                if let tempArray = dic["T1348647853363"] as? NSArray {
                    
                    let dataArray  = tempArray.subarrayWithRange(NSRange(location: 1,length: tempArray.count - 1))
                    self.newsArray = dataArray
                    
                    self.tableView.reloadData()
                    
                }
                
            }
            
        }
        
    }
    
    //    MASK: - delegate
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (self.newsArray?.count)!
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row % 2 == 0 {
            
            let cell : SnapTableViewCell = tableView.dequeueReusableCellWithIdentifier(CellSnap) as! SnapTableViewCell
            
            let data : NSDictionary = self.newsArray![indexPath.row] as! NSDictionary
            
            let url : String = data["img"] as! String
            
            cell.titleLabel.text  = data["title"] as! String?
            cell.detailLabel.text = data["digest"] as! String?
            
            cell.testImageView.kf_setImageWithURL(NSURL.init(string: url)!)
            
            return cell
            
        }else {
            
            let cell : ImageTableViewCell = tableView.dequeueReusableCellWithIdentifier(CellImage) as! ImageTableViewCell
            
            let data : NSDictionary = self.newsArray![indexPath.row] as! NSDictionary
            
            let url : String = data["img"] as! String
            
            cell.titleLabel.text = data["title"] as! String?
            cell.bigImageView.kf_setImageWithURL(NSURL.init(string: url)!)
            
            return cell
            
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.row % 2 == 0 {
            return 100.0
        }else {
            return 150.0
        }
        
    }
    
}

