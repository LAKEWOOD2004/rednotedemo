//
//  WaterfallLayout.swift
//  rednotedemo
//
//  Created by LAKEWOOD on 2026/2/21.
//

import Foundation
import UIKit

//1.定义瀑布流代理，用来动态获取每个 cell 的高度
protocol WaterfallLayoutDelegate: AnyObject {
    func waterfallLayout(_ layout: WaterfallLayout, heightForItemAt indexPath: IndexPath) -> CGFloat
}

//2.自定义真正的瀑布流 Layout
class WaterfallLayout: UICollectionViewLayout {
    
    weak var delegate: WaterfallLayoutDelegate?
    
    var columnCount = 2
    var columnSpacing: CGFloat = 10
    var rowSpacing: CGFloat = 10
    var edgeInsets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    
    private var attributesArray = [UICollectionViewLayoutAttributes]()//存储所有 cell 的布局信息
    private var columnHeights = [CGFloat]()
    private var contentHeight: CGFloat = 0 //整个内容高度
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }//安全检验
        
        attributesArray.removeAll()
        columnHeights = Array(repeating: edgeInsets.top, count: columnCount)
        contentHeight = 0
        
        let contentWidth = collectionView.bounds.width - edgeInsets.left - edgeInsets.right
        let itemWidth = (contentWidth - CGFloat(columnCount - 1) * columnSpacing) / CGFloat(columnCount)
        let itemCount = collectionView.numberOfItems(inSection: 0)
        
        for i in 0..<itemCount {
            let indexPath = IndexPath(item: i, section: 0) //生成当前 cell 的索引 （第 i 个）
            //核心逻辑 找到当前高度最短的列
            var minHeight = columnHeights[0] //先假设第一列最矮
            var minColumn = 0 //记录最短的列号
            for col in 1..<columnCount {//遍历其他列找到真正的最矮列
                if columnHeights[col] < minHeight {
                    minHeight = columnHeights[col]
                    minColumn = col
                }
            }
            //计算当前 cell 的 xy 坐标
            let x = edgeInsets.left + CGFloat(minColumn) + CGFloat(minColumn) * (itemWidth + columnSpacing)
            let y = minHeight //y坐标
            
            //向代理（vc）索要当前 cell 的高度
            let itemHeight = delegate?.waterfallLayout(self, heightForItemAt: indexPath) ?? 200
            //创建 cell 的布局属性，记录位置大小
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = CGRect(x: x, y: y, width: itemWidth, height: itemHeight)
            attributesArray.append(attributes)
            columnHeights[minColumn] = y + itemHeight + rowSpacing
        }
        //计算整个 collectionview 的滚动高度（最高列的高度 + 底部内边距 - 多减的行间距）
        contentHeight = (columnHeights.max() ?? 0) + edgeInsets.bottom - rowSpacing
    }
    //告诉系统内容总大小
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView?.bounds.width ?? 0, height: contentHeight)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributesArray.filter { $0.frame.intersects(rect) }
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributesArray[indexPath.item]
    }
}
