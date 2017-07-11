//
//  CollectionHeaderView.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/5.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit
import Kingfisher

class CollectionHeaderView: UICollectionReusableView {
    
    //MARK:- 控件属性

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    //MARK:- 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            titleLabel.sizeToFit()
            guard let iconURL = NSURL(string: (group?.small_icon_url)!) else { return }
            iconImageView.kf.setImage(with: iconURL as URL)
            if(iconImageView.image == nil) {
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
            }
        }
    }
    
}
