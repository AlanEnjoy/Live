//
//  RecommendModel.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/7.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit

class RecommendViewModel : BaseViewModel {
       //MARK:- 懒加载属性
    public lazy var cycleModels : [CycleModel] = [CycleModel]()
    fileprivate lazy var bigDataGroup : AnchorGroup = AnchorGroup()
    fileprivate lazy var prettyGroup : AnchorGroup = AnchorGroup()
}

//MARK:- 发送网络请求
extension RecommendViewModel {
    
    //请求无线轮播的数据
    func requestCycleData(finishCallback : @escaping () -> ()) {
        NetworkTools.requestData(type: .GET, URLString: "http://www.douyutv.com/api/v1/slide/6", parameters: ["version" : "2.300"]) { (result) in
            //1.获取整体字典数据
            guard let resultDict = result as? [String : NSObject] else { return }
            
            //2.根据data的key获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            //3.字典转模型对象
            for dict in dataArray {
                self.cycleModels.append(CycleModel(dict : dict))
            }
            
            finishCallback()
        }
    }
    
    //请求推荐数据
    func requestData(finishCallback :@escaping () -> ()) {
        //1.定义参数
        let parameters = ["limit" : "4","offset" : "0","time" : NSDate.getCurrentTime() as NSString]
        
        //2.创建Group
        let dgroup = DispatchGroup.init()
        
        
        //3.请求第一部分推荐数据
        dgroup.enter()
        
        NetworkTools.requestData(type: .GET, URLString: "https://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: ["time" : NSDate.getCurrentTime() as NSString]) { (result) in
            
            //3.1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            //3.2.根据data该key，获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            //3.3.遍历字典，并且转成模型对象
            //3.3.1设置组的属性
             self.bigDataGroup.tag_name = "热门"
             self.bigDataGroup.icon_name = "home_header_hot"
            
            //3.3.2获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict : dict)
                self.bigDataGroup.anchors.append(anchor)
            }
            //3.4离开组
            dgroup.leave()

        
        }
        //4.请求第二部分颜值数据
        dgroup.enter()
        NetworkTools.requestData(type: .GET, URLString: "https://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters) { (result) in
            //4.1.将result转成字典类型
            guard let resultDict = result as? [String : NSObject] else { return }
            
            //4.2.根据data该key，获取数据
            guard let dataArray = resultDict["data"] as? [[String : NSObject]] else { return }
            
            //4.3.便利数组，获取字典，并将字典转成模型对象
            //4.3.1设置组的属性
              self.prettyGroup.tag_name = "颜值"
              self.prettyGroup.icon_name = "home_header_phone"
            
            //4.3.2获取主播数据
            for dict in dataArray {
                let anchor = AnchorModel(dict : dict)
                self.prettyGroup.anchors.append(anchor)
            }
     
            //4.4离开组
            dgroup.leave()
        }
        
        
        //5.请求2-12部分的游戏数据
        dgroup.enter()
        loadAnchorData(URLString: "https://capi.douyucdn.cn/api/v1/getHotCate", Parameters: parameters) { 
            finishCallback()
            dgroup.leave()
        }
        
        //6.所有的数据都请求到，之后进行排序
        dgroup.notify(queue: DispatchQueue.main){
            self.anchorGroups.insert(self.prettyGroup, at: 0)
            self.anchorGroups.insert(self.bigDataGroup, at: 0)
            finishCallback()

        }
            
        
        
    }
}
