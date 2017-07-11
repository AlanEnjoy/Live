//
//  PageTitleView.swift
//  Live
//
//  Created by Alan's Macbook on 2017/7/2.
//  Copyright © 2017年 zhushuai. All rights reserved.
//

import UIKit
//MARK:- 定义协议
protocol  PageTitleViewDelegate : class {
    //selectedIndex为外部参数，index为内部参数
    func pageTitleView(titleView: PageTitleView,selectedIndex index : Int)
}

//MARK:- 定义常量
fileprivate let kNormalColor : (CGFloat,CGFloat,CGFloat) = (85, 85, 85)
fileprivate let kSelectColor : (CGFloat,CGFloat,CGFloat) = (255,128,0)
private let kScrollLineH: CGFloat = 2

class PageTitleView: UIView {
    //MARK:- 定义属性
    fileprivate var currentIndex : Int = 0
    fileprivate var titles : [String]
    weak var delegate: PageTitleViewDelegate?
    
    //MARK:- 懒加载属性
    public lazy var titleLabels: [UILabel] = [UILabel]()
    public lazy var scrollLine: UIView = {
       let scrollLine = UIView()
        scrollLine.backgroundColor = UIColor.orange
        return scrollLine
    }()
    public lazy var scrollView : UIScrollView = {
        let scrollerView = UIScrollView()
        //水平滚动条不显示
        scrollerView.showsHorizontalScrollIndicator = false
        scrollerView.scrollsToTop = false
        scrollerView.bounces = false
        return scrollerView
    }()
    //MARK:- 自定义构造函数
    init(frame: CGRect, titles : [String]){
    self.titles = titles
    super.init(frame: frame)
    //设置UI界面
    setupUI()
        
    }

    //重写或自定义构造函数必须重写init with coder构造函数
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//MARK:-设置UI界面
extension PageTitleView {
    public func setupUI() {
            //1.添加UIScrollView
           addSubview(scrollView)
           scrollView.frame = bounds
            //2.添加Title对应的Label
           setupTitleLabels()
            //3.设置底线和滚动滑块
           setupBotttomLineAndScrollLine()
   }
        private func setupTitleLabels(){
            for (index,title) in titles.enumerated() {
            //0.确定一些frame的值
                let labelW : CGFloat = frame.width / CGFloat(titles.count)
                let labelH : CGFloat = frame.height - kScrollLineH
                let labelY : CGFloat = 0

            //1.设置UILabel
                let label = UILabel()
                
            //2.设置Label的属性
                label.text = title
                label.tag = index
                label.font = UIFont.systemFont(ofSize: 16.0)
                label.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
                label.textAlignment = .center
            //3.设置label的frame
        
                let labelX : CGFloat = labelW * CGFloat(index)
                label.frame = CGRect(x:labelX,y:labelY,width:labelW,height: labelH)
            //4.将label 添加到scrollView中
                scrollView.addSubview(label)
                titleLabels.append(label)
            //5.给Label添加手势
                label.isUserInteractionEnabled = true
                let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.titleLabelClick(tapGes:)))
                label.addGestureRecognizer(tapGes)
            }
        }
    private func setupBotttomLineAndScrollLine(){
           //1.添加底线
               let bottomLine = UIView()
               bottomLine.backgroundColor = UIColor.lightGray
               let lineH : CGFloat = 0.5
               bottomLine.frame = CGRect(x:0, y:frame.height - lineH,width: frame.width,height:lineH)
               scrollView.addSubview(bottomLine)
        
          //2.添加scrollView
          //2.1选取第一个Label
               guard let firstLabel = titleLabels.first else {return}
               firstLabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
          //2.2设置scrollView的属性
               scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x:firstLabel.frame.origin.x,y:frame.height - kScrollLineH,width: firstLabel.frame.width, height:kScrollLineH)
        
    }
}

//MARK:- 监听Label的点击
extension PageTitleView {
    @objc fileprivate func titleLabelClick(tapGes: UITapGestureRecognizer){
        
        
        //0.获取当前label的下标值
        guard let currentlabel = tapGes.view as? UILabel else { return }
        
        //0.如果是重复点击同一个title，那么直接返回
        if currentlabel.tag == currentIndex { return }
        
        //2.获取之前的label
        let oddLabel = titleLabels[currentIndex]
        
        //3.切换文字的颜色
        currentlabel.textColor = UIColor(r: kSelectColor.0, g: kSelectColor.1, b: kSelectColor.2)
        oddLabel.textColor = UIColor(r: kNormalColor.0, g: kNormalColor.1, b: kNormalColor.2)
        
        //4.保存最新Label的下标值
        currentIndex = currentlabel.tag
        
        //5.滚动条的位置发生改变
        let scrollLineX = CGFloat(currentlabel.tag) * scrollLine.frame.width
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        
        //6.通知代理
        delegate?.pageTitleView(titleView: self, selectedIndex: currentIndex)
        
    }
}

//MARK:- 对外暴露的方法
extension PageTitleView {
    func setTitleViewWithProgress(progress:CGFloat, sourceIndex: Int, targetIndex:Int){
        //1.取出sourceLabel/targetLabel
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        //2.处理滑块的逻辑
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveX = moveTotalX * progress
        scrollLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        //3.TitleViewText颜色变化
        //3.1取出变化的范围
        let colorDelta = (kSelectColor.0 - kNormalColor.0, kSelectColor.1 - kNormalColor.1, kSelectColor.2 - kNormalColor.2)
        
        //3.2变化sourceLabel
        sourceLabel.textColor = UIColor(r: kSelectColor.0 - colorDelta.0 * progress, g: kSelectColor.1 - colorDelta.1 * progress, b: kSelectColor.2 - colorDelta.2 * progress)
        //3.2变化targetLabel
        targetLabel.textColor = UIColor(r: kNormalColor.0 + colorDelta.0 * progress, g: kNormalColor.1 + colorDelta.1 * progress, b: kNormalColor.2 + colorDelta.2 * progress)
        
        //4.记录最新的Index
        currentIndex = targetIndex
        
    }
}
