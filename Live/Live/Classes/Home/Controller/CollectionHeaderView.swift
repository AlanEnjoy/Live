//
//  CollectionHeaderView.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/5.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    //MARK:- 控件属性

    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var iconImageView: UIImageView!
    //MARK:- 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            titleLabel.sizeToFit()
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
        }
    }
    
}
