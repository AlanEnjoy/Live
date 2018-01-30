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
    
    @IBOutlet weak var moreBtn: UIButton!
    //MARK:- 定义模型属性
    var group : AnchorGroup? {
        didSet {
            titleLabel.text = group?.tag_name
            titleLabel.sizeToFit()
            iconImageView.frame = CGRect(x: 0, y: 0, width: 18, height: 18)
            guard let iconURL = NSURL(string: (group?.small_icon_url)!) else { return }
            iconImageView.kf.setImage(with: iconURL as URL)
            if(iconImageView.image == nil) {
            iconImageView.image = UIImage(named: group?.icon_name ?? "home_header_normal")
            }

        }
    }
    
}
//MARK:- 从xib中直接创建的类方法
extension CollectionHeaderView {
    class func collectionHeaderView() -> CollectionHeaderView {
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
    }
}
