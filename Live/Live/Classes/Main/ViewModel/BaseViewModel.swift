//
//  BaseViewModel.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/25.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit

class BaseViewModel {
    lazy var anchorGroups : [AnchorGroup] = [AnchorGroup]()
}

extension BaseViewModel {
    func loadAnchorData(URLString : String, Parameters : [String : Any]? = nil, finishedCallback : @escaping () -> ()) {
        NetworkTools.requestData(type: .GET, URLString: URLString) { (result) in
            //1.对界面进行处理
            guard let resultDict = result as? [String: Any] else { return }
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            //2.遍历数组中的字典
            for dict in dataArray {
                self.anchorGroups.append(AnchorGroup(dict: dict))
            }
            
            //3.完成回调
            finishedCallback()

    }
 }
}
