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
import PullToRefresh
import SwiftyJSON

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TitleSegmentDelegate {
    
    let firstURL = "http://c.m.163.com/nc/article/headline/T1348647853363/0-20.html?from=toutiao&passport=&devId=ECIDH5J3VtJNmnlsgmFGFUgU324iLqCs%2FTN6KzBE6GrzJ6En48foT5R9wH%2FOcJXY&size=20&version=6.0&spever=false&net=wifi&lat=BNsQafMiQurgbJgINKDqOA%3D%3D&lon=bSHK%2B1pn5rA0G0bX3U5%2FOQ%3D%3D&ts=1460300866&sign=sZkXOQmPZa571vREFlmf4Ko0tVPzkKGHYxTTQ3x8M1N48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore"
    
    let second = "http://c.3g.163.com/nc/article/headline/T1348647853363/20-20.html?from=toutiao&passport=&devId=ECIDH5J3VtJNmnlsgmFGFUgU324iLqCs%2FTN6KzBE6GrzJ6En48foT5R9wH%2FOcJXY&size=20&version=7.0&spever=false&net=wifi&lat=&lon=&ts=1461501767&sign=mXgNK3x2QjdojToKQTv6IaORy9YlCvx7kPOlbxq9e2B48ErR02zJ6%2FKXOnxX046I&encryption=1&canal=appstore"
    
    let CellSnap  = "SnapTableViewCell"
    let CellImage = "ImageTableViewCell"
    
    var newsArray : NSArray?
    var imageURLArray : Array<String>?
    
    lazy var segment : TitleSegment = {
    
        let temp = TitleSegment.init(frame: CGRectMake(0, 0, self.view.bounds.width, 40))
        temp.titleArray = ["头条", "娱乐", "热点" ,"体育" ,"北京", "网易", "财经", "科技"]
        temp.delegate = self
        
        return temp
        
    }()
    
    lazy var topView : ScrollImageView = {
    
        let temp = ScrollImageView.init(frame: CGRectMake(0, 0, self.view.bounds.width, 190))
        
        return temp
        
    }()
    
    lazy var tableView : UITableView = {
        
        let temp = UITableView.init(frame: CGRectMake(0, 40, self.view.bounds.width, self.view.bounds.height - 40 - 64))
        
        temp.delegate   = self
        temp.dataSource = self
        
        return temp
        
    }()
    
    var refresher = PullToRefresh()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavgationBar()
        addSubView()
        setupSubview()
        setupLayout()
        
        getDataFromServer()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //    MARK: - ViewSetup
    
    func setupNavgationBar() {
        
        self.navigationController?.navigationBar.translucent  = false
        self.navigationController?.navigationBar.barTintColor = UIColor.init(colorLiteralRed: 0.86, green: 0.2, blue: 0.22, alpha: 1)
        
    }
    
    func addSubView() {
        
        self.view.addSubview(segment)
        self.view.addSubview(tableView)
        
    }
    
    func setupLayout() {
        
    }
    
    func setupSubview() {
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.tableView.registerClass(SnapTableViewCell.self, forCellReuseIdentifier: CellSnap)
        self.tableView.registerClass(ImageTableViewCell.self, forCellReuseIdentifier: CellImage)
        
        self.tableView.addPullToRefresh(self.refresher) { 
            
            self.getDataFromServer()
            
        }
    
    }
    
    //    MARK: - Private
    
    func getDataFromServer() {
        
        let url = firstURL
        
        Alamofire.request(Method.GET, url).responseJSON { response in
            
            switch response.result {
            case let .Success(data):
                
                let json = JSON(data)
                
                let adArray: Array<JSON> = json["T1348647853363"][0]["ads"].arrayValue
                
                self.topView.imageURLArray = adArray.map({ adDic -> String in
                    
                    return adDic["imgsrc"].stringValue
                    
                })
                
                
                if let tempArray: NSArray = json["T1348647853363"].arrayObject {
                    
                    self.newsArray = tempArray.subarrayWithRange(NSRange(location: 1,length: tempArray.count - 1))
                    
                }
                
                self.tableView.tableHeaderView = self.topView
                self.tableView.reloadData()
                
            case .Failure:
                print(response.result.error)
                
            }
            
        }
        
    }
    
    //    MARK: - delegate
    
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
    
    func buttonDidClicked(index: Int) {
        
        print("点击\(index)")
        
    }
    
}

