//
//  AmuseMenuView.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/26.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit

fileprivate let kMenuCellID = "kMenuCellID"

class AmuseMenuView: UIView {
    //MARK:- 定义属性
    var groups : [AnchorGroup]? {
        didSet {
            collectionView.reloadData()
        }
    }

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //MARK:- 从xib中加载出来
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "AmuseMenuViewCell", bundle: nil), forCellWithReuseIdentifier: kMenuCellID)

        
    }
    override func layoutSubviews() {
        
            super.layoutSubviews()
            
            let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.itemSize = collectionView.bounds.size
        
    }

}
//MARK:- 提供快速创建的类方法
extension AmuseMenuView {
    class func amuseMenuView() -> AmuseMenuView {
        return Bundle.main.loadNibNamed("AmuseMenuView", owner: nil, options: nil)?.first as! AmuseMenuView
    }
}

extension AmuseMenuView : UICollectionViewDataSource {
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if groups == nil { return 0 }
        let PageNum = (groups!.count - 1) / 8 + 1
        pageControl.numberOfPages = PageNum
        if PageNum == 1 {
            pageControl.isHidden = true
        }
        return PageNum
    }
    
    
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.取出cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kMenuCellID, for: indexPath) as! AmuseMenuViewCell
        
        //2.给cell设置数据
        setupCellIDDataWithCell(cell: cell, indexPath: indexPath)
        
        return cell
    }
    
    private func setupCellIDDataWithCell(cell : AmuseMenuViewCell , indexPath : IndexPath) {
        // 0页： 0-7 1页：8-15 2页：15-23
        //1.取出起始位置和终止位置
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        
        //2.判断越界问题
        if endIndex > groups!.count - 1 {
            endIndex = groups!.count - 1
        }
        
        //3.取出数据，并赋值给cell
        cell.clipsToBounds = true
        cell.groups = Array(groups![startIndex...endIndex])
    }
    
}

extension AmuseMenuView : UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        pageControl.currentPage = Int(scrollView.contentOffset.x / scrollView.bounds.width)
 
    }
}
