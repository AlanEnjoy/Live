//
//  CollectionNormalCell.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/6.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit



class CollectionNormalCell: UICollectionViewCell {


    //MARK:- 控件的属性
  
    @IBOutlet weak var iconImageView: UIImageView!

    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    
    //定义模型属性
    var anchor : AnchorModel? {
        didSet {
            //0.校验模型是否有值
            guard let anchor = anchor else { return }
            
            //1.取出在线人数现实的文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = "\(Int(anchor.online / 10000))万在线"
            }
            else {
                onlineStr = "\(anchor.online)在线"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            onlineBtn.sizeToFit()
            
            //2.昵称的显示
            nicknameLabel.text = anchor.nickname
            nicknameLabel.sizeToFit()
            
            //3.房间名的显示
            roomNameLabel.text = anchor.room_name
            if (roomNameLabel.text?.characters.count)! <= 15 {
            self.roomNameLabel.sizeToFit()
            }
            //4.显示封面图片
            guard let iconURL = NSURL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconURL as URL)

        }
    }
}
