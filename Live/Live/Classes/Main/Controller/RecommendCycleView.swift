//
//  RecommendCycleView.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/12.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit

fileprivate let kCycleCellID = "kCycleCellID"



class RecommendCycleView: UIView {
    
    //MARK:- 定义属性
    var cycleTimer : Timer?
    var cycleModels : [CycleModel]? {
        didSet {
            //1.刷新collectionView
            collectionView.reloadData()
            
            //2.设置pageControl个数
            pageControl.numberOfPages = cycleModels?.count ?? 0
            
            //3.默认滚动到中间的某一个位置
            let indexPath = NSIndexPath(item: (cycleModels?.count ?? 0) * 10, section: 0)
            collectionView.scrollToItem(at: indexPath as IndexPath, at: .left, animated: false)
            
            //4.添加定时器
            removeCycleTimer()
            addCycleTimer()
            
        }
    }
    
    
    //MARK:- 控件属性
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    //MARK:- 系统回调函数
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //设置该控件不随父控件拉伸而拉伸
        autoresizingMask = UIViewAutoresizing(rawValue: 0)
        
        //注册cell
        collectionView.register(UINib(nibName : "CollectionCycleCell", bundle: nil), forCellWithReuseIdentifier: kCycleCellID)
    }
        //设置collectionView的layout
        override func layoutSubviews() {
            super.layoutSubviews()
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = collectionView.bounds.size

        }
      
        
    }


//MARK:- 提供快速创建类的类方法
extension RecommendCycleView {
    class func recommendCycleView() -> RecommendCycleView {
        return Bundle.main.loadNibNamed("RecommendCycleView", owner: nil, options: nil)?.first as! RecommendCycleView
    }
    
}
//MARK:- 遵守UICollectionView的数据源协议
extension RecommendCycleView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (cycleModels?.count ?? 0) * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kCycleCellID, for: indexPath) as! CollectionCycleCell
        
        cell.cycleModel = cycleModels![indexPath.item % cycleModels!.count]
        
        return cell
    }
}

//MARK:- 遵守UICollectionView的代理协议
extension RecommendCycleView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //1.获取滚动的偏移量
        let offsetX = scrollView.contentOffset.x + scrollView.bounds.width * 0.5
        
        //2.计算pageControl的currentIndex
        pageControl.currentPage = Int(offsetX / scrollView.bounds.width ) % (cycleModels?.count ?? 1)

    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        removeCycleTimer()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        addCycleTimer()
    }
}

//MARK:- 对定时器的操作方法
extension RecommendCycleView {
    fileprivate func addCycleTimer() {
        cycleTimer = Timer.init(timeInterval: 3.0, target: self, selector: #selector(self.scrollToNext), userInfo: nil, repeats: true)
        RunLoop.main.add(cycleTimer!, forMode: .commonModes)
    }
    fileprivate func removeCycleTimer() {
        
        cycleTimer?.invalidate()//从运行循环中移除
        cycleTimer = nil
        
    }
    @objc fileprivate func scrollToNext() {
        //1.获取滚动的偏移量
        let currentoffsetX = collectionView.contentOffset.x
        let offsetX = currentoffsetX + collectionView.bounds.width
        
        //2.滚动该位置
        collectionView.setContentOffset(CGPoint(x: offsetX , y: 0), animated: true)
    }
}
    
