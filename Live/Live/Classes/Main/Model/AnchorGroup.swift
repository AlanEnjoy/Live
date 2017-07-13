//
//  AnchorGroup.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/7.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    
    ///该组中对应的房间信息
    var room_list : [[String : NSObject]]? {
        didSet {
            guard let room_list = room_list else { return }
            for dict in room_list {
                anchors.append(AnchorModel(dict : dict))
            }
        }
    }
    ///组显示的标题
    var tag_name : String = ""
    ///组显示的图标
    var small_icon_url : String = ""
    //组图标名
    var icon_name : String?
    //游戏对应的图标
    var icon_url : String = ""
    ///定义主播的模型对象数组
    public lazy var anchors : [AnchorModel] = [AnchorModel]()
    
    //构造函数
    override init() {
        
    }
    
    init(dict : [String : NSObject]){
        super.init()
        
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}
    
   
    
}
