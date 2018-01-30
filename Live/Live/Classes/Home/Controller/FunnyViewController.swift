//
//  FunnyViewController.swift
//  Live
//
//  Created by Alan's Macbook on 2017/8/4.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit


class FunnyViewController: AmuseViewController{

    fileprivate lazy var funnyVM : FunnyViewModel = FunnyViewModel()
    fileprivate lazy var menuView : AmuseMenuView = {
        let menuView = AmuseMenuView.amuseMenuView()
        menuView.frame = CGRect(x: 0, y: -kMenuViewH, width: kScreenW, height: kMenuViewH)
        return menuView
        
    }()

    
   

}

//MARK:- 设置UI界面
extension FunnyViewController {
    override func setupUI() {
        super.setupUI()
        
        //将菜单的View添加到控制器的View中
        collectionView.addSubview(menuView)
        collectionView.contentInset = UIEdgeInsets(top: kMenuViewH, left: 0, bottom: 0, right: 0)
    }
}


//MARK:- 请求数据
extension FunnyViewController {
    override func loadData() {
        //给父类中的ViewModel进行赋值
        baseVM = funnyVM
        //一旦请求到数据，立马刷新collectionView
        funnyVM.loadFunnyData  {
            self.collectionView.reloadData()
            var tempGroups = self.funnyVM.anchorGroups
            tempGroups.removeFirst()
            self.menuView.groups = tempGroups
            //数据请求完成
            self.loadDataFinished()

        }
        
    }
}

