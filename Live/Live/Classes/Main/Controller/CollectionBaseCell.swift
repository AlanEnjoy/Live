//
//  CollectionBaseCell.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/11.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    //MARK:- 控件属性
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var onlineBtn: UIButton!
    
    //MARK:- 定义模型
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
            if (nicknameLabel.text?.characters.count)! <= 8 {
            nicknameLabel.sizeToFit()
            }
            
            //3.显示封面图片
            guard let iconURL = NSURL(string: anchor.vertical_src) else { return }
            iconImageView.kf.setImage(with: iconURL as URL)
            
        }
    }
}
