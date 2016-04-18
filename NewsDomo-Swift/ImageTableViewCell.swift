//
//  ImageTableViewCell.swift
//  NewsDomo-Swift
//
//  Created by Dai Qinfu on 16/4/13.
//  Copyright © 2016年 Wingzki. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell {

    lazy var bigImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.grayColor()
        
        return imageView;
    }()
    
    lazy var titleLabel: UILabel = {
     
        let label = UILabel()
        label.font = UIFont.systemFontOfSize(15)
        
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(bigImageView)
        self.contentView.addSubview(titleLabel)
        
        titleLabel.snp_makeConstraints { (make) in
            
            make.left.top.right.equalTo(self.contentView).inset(UIEdgeInsetsMake(15, 15, 0, 15))
            
        }
        
        bigImageView.snp_makeConstraints { (make) in
            
            make.left.right.equalTo(self.contentView).inset(UIEdgeInsetsMake(0, 15, 0, 15))
            make.top.equalTo(titleLabel.snp_bottom).offset(15)
            make.bottom.equalTo(self.contentView).offset(-15)
            
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
