//
//  CollectionCycleCell.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/12.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit

class CollectionCycleCell: UICollectionViewCell {
    
    //控件属性
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    

   //MARK:- 定义模型属性
    var cycleModel : CycleModel? {
        didSet {
            titleLabel.text = cycleModel?.title
            let iconURL = NSURL(string : cycleModel?.pic_url ?? "")!
            iconImageView.kf.setImage(with: iconURL as? URL, placeholder: UIImage(named: "Img_default"))
        }
    }

}
