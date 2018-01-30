//
//  BaseViewController.swift
//  Live
//
//  Created by Alan's Macbook on 2017/8/5.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK:- 定义属性
    var contentView : UIView?
    
    //MARK:- 懒加载属性
    fileprivate lazy var aniImageView : UIImageView = { [unowned self] in
        let imageView = UIImageView(image:UIImage(named: "img_loading_1"))
        imageView.center = self.view.center
        imageView.animationImages = [UIImage(named : "img_loading_1")!,UIImage(named : "img_loading_2")!]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.autoresizingMask = [.flexibleTopMargin,.flexibleBottomMargin]
        return imageView
        
    }()
    
    //MARK:- 系统回调
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        
    }
    
}

extension BaseViewController {
    func setupUI() {
        //1.隐藏内容的view
        contentView?.isHidden = true
        
        //2.添加执行动画的UIImageView
        view.addSubview(aniImageView)
        
        //3.给aniImageView执行动画
        aniImageView.startAnimating()
        
        //4.设置View的背景颜色
        view.backgroundColor = UIColor(r: 250, g: 250, b: 250)
    }
}

extension BaseViewController {
    func loadDataFinished() {
        //1.停止动画
        aniImageView.stopAnimating()
        
        //2.隐藏aniImageView
        aniImageView.isHidden = true
        
        //3.显示内容的view
        contentView?.isHidden = false
    }
}
