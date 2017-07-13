//
//  RecommendGameView.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/13.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit
fileprivate let kGameCellID = "kGameCellID"
fileprivate let kEdgeInsetMargin : CGFloat = 8

class RecommendGameView: UIView {
    //MARK:- 定义数据的属性
    var groups :[AnchorGroup]? {
        
        didSet {
            //1.移除前两组数据
            groups?.removeFirst()
            groups?.removeFirst()
            groups?.remove(at: 1)
            groups?.remove(at: 4)
            //2.添加“更多”组
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            groups?.append(moreGroup)
            
            //3.刷新数据
            collectionView.reloadData()
        }
    }
    
    //MARK:- 控件属性
    
    @IBOutlet weak var collectionView: UICollectionView!
    
     //MARK:- 系统回调
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //让控件不随父控件的拉伸而拉伸
        autoresizingMask = UIViewAutoresizing(rawValue: 0)
        
        //注册cell
        collectionView.register(UINib(nibName: "CollectionGameCell", bundle: nil), forCellWithReuseIdentifier: kGameCellID)
        
        //给collectionGameView添加内边距
        collectionView.contentInset = UIEdgeInsetsMake(0, kEdgeInsetMargin , 0, kEdgeInsetMargin )
    }

    

}

//MARK:- 提供快速创建的类方法
extension RecommendGameView {
    class func recommendGameView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }
}

//MARK:- 遵守UICollectionView的数据源协议
extension RecommendGameView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kGameCellID, for: indexPath) as! CollectionGameCell
        
        cell.group = groups![indexPath.item]
        
        
        return cell
    }
}
