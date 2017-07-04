//
//  UIColor-Extension.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/2.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit

extension UIColor{
    convenience init(r: CGFloat,g:CGFloat,b:CGFloat){
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
}
