//
//  AmuseViewModel.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/24.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit

class AmuseViewModel : BaseViewModel{
   
}
extension AmuseViewModel {
    func loadAmuseData(finishedCallback : @escaping () -> ()) {
        loadAnchorData(URLString: "https://capi.douyucdn.cn/api/v1/getHotRoom/2") {
            finishedCallback()
        }
    }
}

