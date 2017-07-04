//
//  RecommendViewController.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/4.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit

fileprivate let kItemMargin : CGFloat = 10
fileprivate let kItemW = (kScreenW - 3 * kItemMargin) / 2
fileprivate let kItemH = kItemW * 3 / 4
fileprivate let kNormalCellID = "kNormalCellID"
fileprivate let kHeaderViewID = "kHeaderViewID"
fileprivate let kHeaderViewH : CGFloat = 50


class RecommendViewController: UIViewController {
    
    
    //MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW,height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        //设置组头
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)

        
        //2.创建UICollectionVIew
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.blue
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self , forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        //设置collectionView适应contentView的大小
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // 设置UI界面
        setupUI()
        

    }

}

//MARK:- 设置UI界面内容
extension RecommendViewController {
    fileprivate func setupUI() {
        //1.将UICollectionView添加到控制器的view中
        view.addSubview(collectionView)
    }
}

//MARK:- 遵守UICollectionView的数据源协议
extension RecommendViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  12
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
    }
    return 4
 }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.获取cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath)
        
        cell.backgroundColor = UIColor.red
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath)
        
        headerView.backgroundColor = UIColor.green
        
        return headerView
        
        
    }
    
    
    
    
    
}
