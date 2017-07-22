//
//  BaseGameModel.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/22.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit

class BaseGameModel: NSObject {
    
    //MARK:- 定义属性
    var tag_name : String = ""
    var icon_url : String = ""
    //构造函数
    override init() {
        
    }
    //MARK:- 自定义构造函数
    init(dict : [String : Any]){
        super.init()
            
        setValuesForKeys(dict)
    }

    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {}

}
