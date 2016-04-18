//
//  SmallImageTableViewCell.swift
//  NewsDomo-Swift
//
//  Created by Dai Qinfu on 16/4/13.
//  Copyright © 2016年 Wingzki. All rights reserved.
//

import UIKit

class SmallImageTableViewCell: UITableViewCell {

    lazy var imageViewL: UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.grayColor()
        
        return imageView;
    }()
    
    lazy var imageViewM: UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.grayColor()
        
        return imageView;
    }()

    lazy var imageViewR: UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.grayColor()
        
        return imageView;
    }()
    
    lazy var titleLabel: UILabel = {
        
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(12)
        
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(imageViewL)
        self.contentView.addSubview(imageViewM)
        self.contentView.addSubview(imageViewR)
        self.contentView.addSubview(titleLabel)
        
        titleLabel.snp_makeConstraints { (make) in
            
        }
        
        imageViewL.snp_makeConstraints { (make) in
            
        }
        
        imageViewM.snp_makeConstraints { (make) in
            
        }
        
        imageViewR.snp_makeConstraints { (make) in
            
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
