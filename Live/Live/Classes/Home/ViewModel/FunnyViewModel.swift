//
//  FunnyViewModel.swift
//  Live
//
//  Created by Alan's Macbook on 2017/8/4.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit

class FunnyViewModel : BaseViewModel{
    
}
extension FunnyViewModel {
    func loadFunnyData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(URLString: "https://capi.douyucdn.cn/api/v1/getHotRoom/3") {
            finishedCallback()
        }
    }
}
