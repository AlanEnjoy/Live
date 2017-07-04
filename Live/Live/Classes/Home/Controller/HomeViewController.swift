//
//  HomeViewController.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/1.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit
private let kTitleViewH: CGFloat = 40

class HomeViewController: UIViewController {
     //懒加载属性
    public lazy var pageContentView : PageContentView = {[weak self] in
        //1.确定内容的Frame
        let contentH = KScreenH - kTitleViewH - kStatusBarH - kNavigationBarH - ktabbarH
        let contentFrame = CGRect(x:0 , y:kStatusBarH+kNavigationBarH+kTitleViewH , width:kScreenW ,height:contentH )
        
        //2.确定所有的子控制器
        var childVcs = [UIViewController]()
        childVcs.append(RecommendViewController())
        for _ in 0..<3 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentViewController: self)
        contentView.delegate = self
        return contentView

    }()
    public lazy var pageTitleView :PageTitleView = {[weak self] in
        let frame = CGRect(x: 0, y:kStatusBarH + kNavigationBarH, width: kScreenW, height: kTitleViewH)
        let titles = ["推荐","游戏","娱乐","趣玩"]
        let titleView = PageTitleView(frame:frame, titles:titles)
        titleView.backgroundColor = UIColor.white
        titleView.delegate = self
        return titleView
    }()
    
    //系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置UI界面
        setupUI()
      
    }
}

//MARK:- 设置UI界面
extension HomeViewController {
        public func setupUI() {
        //0.不需要调整scrollView的内边距
            automaticallyAdjustsScrollViewInsets = false
        //1.设置导航栏
            setupNavigationBar()
        //2.添加TitleView
            view.addSubview(pageTitleView)
        //3.添加ContentView
            view.addSubview(pageContentView)
            pageContentView.backgroundColor = UIColor.purple
        }
    private func setupNavigationBar() {
        //设置左侧Item
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(imageName:"logo" )
        //设置右侧的Items
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(imageName: "image_my_history", highImageName: "Image_my_history_click", size: size)
        
        let searchItem = UIBarButtonItem(imageName: "btn_search", highImageName: "btn_search_clicked", size: size)
        
    
        let qrCodeItem = UIBarButtonItem(imageName: "Image_scan", highImageName: "Image_scan_click", size: size)
        navigationItem.rightBarButtonItems =  [historyItem, searchItem, qrCodeItem ]
    }
    

}

//MARK:- 遵守PageTitleViewDelegate协议
extension HomeViewController : PageTitleViewDelegate {
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
    
    
}
//MARK:- 遵守PageContentViewDelegate协议
extension HomeViewController: PageContentViewDelegate{
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleViewWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}
