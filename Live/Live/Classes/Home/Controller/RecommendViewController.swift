//
//  RecommendViewController.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/4.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit
fileprivate let kCycleViewH = kScreenW * 3 / 8
fileprivate let kGameViewH : CGFloat = 90

class RecommendViewController: BaseAnchorViewController {
    

    //MARK:- 懒加载属性
    fileprivate lazy var gameView : RecommendGameView = {
        let gameView = RecommendGameView.recommendGameView()
        gameView.frame = CGRect(x: 0, y: -kGameViewH, width: kScreenW, height: kGameViewH)
        return gameView
    }()
    
    fileprivate lazy var cycleView : RecommendCycleView = {
        let cycleView = RecommendCycleView.recommendCycleView()
        cycleView.frame = CGRect(x: 0, y: -(kCycleViewH + kGameViewH), width: kScreenW, height: kCycleViewH)
        return cycleView
    }()
    fileprivate lazy var recommandVM: RecommendViewModel = RecommendViewModel()
    
   
}

//MARK:- 设置UI界面内容
extension RecommendViewController {
    override func setupUI() {
        super.setupUI()
        //1.调用父类的setupUI方法
        super.setupUI()
        //2.将CycleView添加到UICollectionView中
        collectionView.addSubview(cycleView)
        
        //3.将GameView添加到CollectionView中
        collectionView.addSubview(gameView)
        
        //4.设置collectionView的内边距
        collectionView.contentInset = UIEdgeInsets(top: kCycleViewH + kGameViewH, left: 0, bottom: 0, right: 0)
    }
}

//MARK:- 发送网络请求
extension RecommendViewController {
    override func loadData() {
            //0.给父类中的ViewModel进行赋值
            baseVM = recommandVM
            //1.请求推荐数据
            recommandVM.requestData {
            //1.1. 展示推荐数据
            self.collectionView.reloadData()
            
            //1.2 将数据传递给GameView
            var groups = self.recommandVM.anchorGroups
            //1.3 移除前两组数据
            groups.removeFirst()
            groups.removeFirst()
            groups.remove(at: 1)
            groups.remove(at: 4)
            
            //1.4 添加“更多”组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups.append(moreGroup)
            self.gameView.groups = groups
                
            //2.数据请求完成
            self.loadDataFinished()
        }
        
        //2.请求轮播数据
        recommandVM.requestCycleData {
           self.cycleView.cycleModels = self.recommandVM.cycleModels
        }
    }
}

extension RecommendViewController : UICollectionViewDelegateFlowLayout {
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            //1.取出PrettyCell
            let prettyCell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath)
            as! PrettyCell
            
            //2.设置数据
            prettyCell.anchor = recommandVM.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            return prettyCell
            
        } else {
            return super.collectionView(collectionView, cellForItemAt: indexPath)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kNormalItemW, height: kPrettyItemH)
        }
        
        return CGSize(width: kNormalItemW, height: kNormalItemH)
    }
    
}

