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
fileprivate let kNormalItemH = kItemW * 3 / 4
fileprivate let kPrettyItemH = kItemW * 4 / 3
fileprivate let kNormalCellID = "kNormalCellID"
fileprivate let kHeaderViewID = "kHeaderViewID"
fileprivate let kPrettyCellID = "kPrettyCellID"
fileprivate let kHeaderViewH : CGFloat = 50


class RecommendViewController: UIViewController {
    
    
    //MARK:- 懒加载属性
    fileprivate lazy var recommandVM: RecommendViewModel = RecommendViewModel()
    
    fileprivate lazy var collectionView : UICollectionView = {[unowned self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW,height: kNormalItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        //设置组头
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsetsMake(0, kItemMargin, 0, kItemMargin)

        
        //2.创建UICollectionVIew
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: kNormalCellID)
        collectionView.register(UINib(nibName: "PrettyCell", bundle: nil), forCellWithReuseIdentifier: kPrettyCellID)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kHeaderViewID)
        //设置collectionView适应contentView的大小
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        

        // 设置UI界面
        setupUI()

        //发送网络请求
        loadData()
    }

}

//MARK:- 设置UI界面内容
extension RecommendViewController {
    fileprivate func setupUI() {
        //1.将UICollectionView添加到控制器的view中
        view.addSubview(collectionView)
    }
}

//MARK:- 发送网络请求
extension RecommendViewController {
    fileprivate func loadData() {
        recommandVM.requestData { 
            self.collectionView.reloadData()
        }
    }
}

//MARK:- 遵守UICollectionView的数据源协议
extension RecommendViewController : UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return  recommandVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       let group = recommandVM.anchorGroups[section]

        return group.anchors.count

    
 }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //1.取出模型对象
        let group = recommandVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        
        
        //2.取出cell
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kPrettyCellID, for: indexPath) as! PrettyCell
            cell.anchor = anchor
            return cell
            
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellID, for: indexPath) as! CollectionNormalCell
            cell.anchor = anchor
            return cell
        }
        
        
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //1.取出section的HeaderView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kHeaderViewID, for: indexPath) as! CollectionHeaderView
        
        //2.取出模型
        headerView.group = recommandVM.anchorGroups[indexPath.section]
        
        
        return headerView

        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNormalItemH)
    }
    
    
    
}
