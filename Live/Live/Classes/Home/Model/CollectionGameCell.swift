//
//  CollectionGameCell.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/13.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit

class CollectionGameCell: UICollectionViewCell {
    //MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK:- 定义模型属性
    var baseGame : BaseGameModel? {
        didSet {
            titleLabel.text = baseGame?.tag_name
            let iconURL = URL(string : baseGame?.icon_url ?? "")
            iconImageView.kf.setImage(with: iconURL, placeholder: UIImage(named: "home_more_btn"))
            
        }
    }

}
