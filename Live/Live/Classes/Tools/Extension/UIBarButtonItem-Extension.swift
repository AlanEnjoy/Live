//
//  UIBarButtonItem-Extension.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/1.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit
extension UIBarButtonItem {
    //利用类方法创建UIBaruttonItem
    class func createItem(imageName: String, highImageName: String, size: CGSize) -> UIBarButtonItem {
        let btn = UIButton()
        
        btn.setImage(UIImage(named: imageName), for: .normal)
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        
        return UIBarButtonItem(customView: btn)
        
        
    }
    //利用构造函数创建UIBarButtonItem
    //只能扩充便利构造函数：1>以便利convenience开头 2>在构造函数中必须明确用一个设计的构造函数（self）
    convenience init(imageName: String, highImageName: String = "", size: CGSize = CGSize.zero){
        //创建UIButton
        let btn = UIButton()
        //设置btn的图片
        btn.setImage(UIImage(named: imageName), for: .normal)
        if highImageName != "" {
        btn.setImage(UIImage(named: highImageName), for: .highlighted)
        }
        if size == CGSize.zero {
            btn.sizeToFit()
        }else {
        btn.frame = CGRect(origin: CGPoint.zero, size: size)
        }
        //创建UIBarButtonItem
        self.init(customView: btn)
    }
    
}
