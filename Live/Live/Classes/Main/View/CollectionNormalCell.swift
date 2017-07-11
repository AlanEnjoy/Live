//
//  CollectionNormalCell.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/6.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit



class CollectionNormalCell: CollectionBaseCell {


    //MARK:- 控件的属性
  
    @IBOutlet weak var roomNameLabel: UILabel!

    
    //定义模型属性
    override var anchor : AnchorModel? {
        didSet {
            //1.将属性传递给父类
             super.anchor = anchor
            //2.房间名的显示
            roomNameLabel.text = anchor?.room_name
            if (roomNameLabel.text?.characters.count)! <= 15 {
            self.roomNameLabel.sizeToFit()
            }
           

        }
    }
}
