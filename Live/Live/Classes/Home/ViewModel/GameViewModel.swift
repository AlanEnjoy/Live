//
//  GameViewModel.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/22.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit

class GameViewModel {
    lazy var games : [GameModel] = [GameModel]()
}

extension GameViewModel {
    func loadAllGameData(finishedCallback: @escaping() -> ()) {
        NetworkTools.requestData(type: .GET, URLString: "https://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: ["shortName" : "game"]) { (result) in
            
            //1.获取到数据                      //字典类型
            guard let resultDict = result as? [String : Any] else { return }
            //从字典中根据data键将游戏数组取出                 //字典数组
            guard let dataArray = resultDict["data"] as? [[String : Any]] else { return }
            
            //2.字典转模型
            for dict in dataArray  {
                self.games.append(GameModel(dict: dict))
            }
            
            //3.完成回调
            finishedCallback()
        }
    }
}
