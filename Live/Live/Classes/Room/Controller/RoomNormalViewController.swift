//
//  RoomNormalViewController.swift
//  Live
//
//  Created by Alan's Macbook on 2017/8/5.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit

class RoomNormalViewController: UIViewController,UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.orange
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        //隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
        //依然保持手势
//        navigationController?.interactivePopGestureRecognizer?.delegate = self
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }



}
