//
//  WaterfallFlowLayout.swift
//  WaterfallFlow
//
//  Created by 高万里 on 15/9/10.
//  Copyright (c) 2015年 高万里. All rights reserved.
//

import UIKit

class WaterfallFlowLayout: UICollectionViewFlowLayout {
    /// 数据源对象
    var dataSource: [WaterfallFlowItem]?
    /// 一行显示的item个数
    var rowItemNum: Int = 0 {
        didSet {
            colItemHeightValues = [CGFloat](count: rowItemNum, repeatedValue: sectionInset.top)
        }
    }
    /// 布局属性数组
    private lazy var layoutAttributes: [UICollectionViewLayoutAttributes]? = {
        return [UICollectionViewLayoutAttributes]()
        }()
    /// 列高数组
    private var colItemHeightValues: [CGFloat]?
    
    override func prepareLayout() {
        super.prepareLayout()
        let screenWidth = CGRectGetWidth(UIScreen.mainScreen().bounds)
        let itemWidth = (screenWidth - (CGFloat(rowItemNum - 1) * minimumInteritemSpacing) - sectionInset.left - sectionInset.right) / CGFloat(rowItemNum)
        // 计算所有item的布局属性
        calcAllItemLayoutAttributeByItemWidth(itemWidth)
    }
    
    /// 返回所有item的布局属性
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return layoutAttributes
    }
    
    /// 设置collectionView的滚动范围
    override func collectionViewContentSize() -> CGSize {
        let y = (colItemHeightValues?.sort().last)! - minimumInteritemSpacing;
        return CGSizeMake(CGRectGetWidth(UIScreen.mainScreen().bounds), y)
    }
}

extension WaterfallFlowLayout {
    /**
    计算所有item的布局属性
    */
    private func calcAllItemLayoutAttributeByItemWidth(itemWidth: CGFloat) {
        if dataSource == nil {
            return
        }
        
        var index = 0
        for _ in dataSource! {
            let attribute = calcItemLayoutAttribute(index++, itemWidth: itemWidth)
            layoutAttributes?.append(attribute)
        }
    }
    
    /**
    计算一个item的布局属性
    */
    private func calcItemLayoutAttribute(index: Int, itemWidth: CGFloat) -> UICollectionViewLayoutAttributes {
        // 创建布局属性
        let attribute = UICollectionViewLayoutAttributes(forCellWithIndexPath: NSIndexPath(forItem: index, inSection: 0))
        
        // 高度最小的列号和列高
        let colAndHeight = findMinHeightColIndexAndHeight()
        
        let x = sectionInset.left + CGFloat(colAndHeight.col) * (itemWidth + minimumInteritemSpacing)
        let y = colAndHeight.height
        let h = calcItemHeight(index, width: itemWidth)
        
        // 将item的高度添加到数组进行记录
        colItemHeightValues![colAndHeight.col] += (h + minimumLineSpacing)
        
        // 设置frame
        attribute.frame = CGRectMake(x, y, itemWidth, h)
        return attribute
    }
    
    /**
    根据数据源中的宽高计算等比例的高度
    
    :returns: item的高度
    */
    private func calcItemHeight(index: Int, width: CGFloat) -> CGFloat {
        let h = dataSource![index].height
        let w = dataSource![index].width
        return w / h * width
    }
    
    /**
    找出高度最小的列
    
    - returns: 列号和列高
    */
    private func findMinHeightColIndexAndHeight() -> (col: Int, height: CGFloat) {
        var minHeight: CGFloat = colItemHeightValues![0]
        var index = 0
        for i in 0..<rowItemNum {
            let h = colItemHeightValues![i]
            if minHeight > h {
                minHeight = h
                index = i
            }
        }
        return (index, minHeight)
    }
}
