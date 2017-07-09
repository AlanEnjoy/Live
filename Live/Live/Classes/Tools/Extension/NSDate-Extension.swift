//
//  NSDate-Extension.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/7.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import Foundation

extension NSDate {
    class func getCurrentTime() -> String {
        let nowDate = NSDate()
        let interval = Int(nowDate.timeIntervalSince1970)
        return "\(interval)"
    }
}
