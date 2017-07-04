//
//  PageContentView.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/2.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int,targetIndex: Int)
}

private let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    //MARK:- 定义属性
    public var childVcs: [UIViewController]
    public weak var parentViewController: UIViewController?
    fileprivate var startOffsetX : CGFloat = 0
    fileprivate var isForbidScrollDelegate = false
    weak var delegate: PageContentViewDelegate?
    
    
    //MARK:- 添加懒熟悉
    public lazy var collectionView:UICollectionView = {[weak self ] in
        //1.创建layout
        //流水布局
        let layout = UICollectionViewFlowLayout()
        //设置itemsize为当前view大小
        layout.itemSize = (self?.bounds.size)!
        //行间距
        layout.minimumLineSpacing = 0
        //Item间距
        layout.minimumInteritemSpacing = 0
        //滚动方向
        layout.scrollDirection = .horizontal
        
        //2.创建UICollectionview
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout )
        collectionView.showsHorizontalScrollIndicator = false
        //分页显示
        collectionView.isPagingEnabled = true
        //不得超出内容的滚动区域
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        collectionView.delegate = self
        return collectionView
    }()
    
    //MARK:- 定义自定义构造函数
    init(frame:CGRect, childVcs: [UIViewController], parentViewController: UIViewController?){
        self.childVcs = childVcs
        self.parentViewController = parentViewController
        
        super.init(frame:frame)
    //设置UI
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK:- 设置UI界面
extension PageContentView {
    public func setupUI() {
        //1.将所有子控制器添加到父控制器中
        for childVc in childVcs {
            parentViewController?.addChildViewController(childVc)
        }
        
        //2.添加UICollectionView，用于在Cell中存放控制器的View
        addSubview(collectionView)
        //frame等于当前bounds
        collectionView.frame = bounds
        
    }
}

//MARK:- 遵守UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.创建cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        
        //2.给Cell设置内容
        //cell会循环利用，可能造成一直往控制器循环添加多遍，故需要释放不需要的cell
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.item]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
}

//MARK:- 遵守UICollectionViewDelegate
extension PageContentView: UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //0.判断是否是点击事件
        if isForbidScrollDelegate { return }
        //1.定义需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        
        //2.判断是左滑或者右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        if currentOffsetX > startOffsetX { //左滑
            //1.1 计算progress
            progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW)
            //1.2 计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            //1.3 计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count  {
                targetIndex = childVcs.count - 1
            }


            //1.4 完全滑过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
                sourceIndex = sourceIndex - 1
            }

            
        } else { //右滑
            //2.1 计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW))
            //2.2 计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            //2.3计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count{
                sourceIndex = childVcs.count - 1
            }
            
        }
        //3.通知代理
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        print("sourceIndex:\(sourceIndex),targetIndex:\(targetIndex)")
   }
}

//MARK:-对外暴露的方法
extension PageContentView {
    public func setCurrentIndex(currentIndex: Int){
    //1.记录需要禁止执行代理方法
    isForbidScrollDelegate = true
    //2.滚动到合理位置
    let offsetX = CGFloat(currentIndex) * collectionView.frame.width
        collectionView.setContentOffset(CGPoint(x:offsetX,y: 0), animated: true)
    }
    
}
