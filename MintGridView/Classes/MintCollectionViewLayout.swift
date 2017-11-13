//
//  MintCollectionViewLayout.swift
//  MintGridView
//
//  Created by 季风 on 2017/11/7.
//

import Foundation

public enum SizeAdaptType {
    case proportion   // 保持宽高比
    case fixedHeight  // 固定高度
}

public class MintCollectionViewLayout: MintGridViewLayout {
    public var flowLayout = MintCollectionViewFlowLayout()
    public override init() {
        super.init()
    }
}

public class MintCollectionViewFlowLayout: UICollectionViewFlowLayout {
    /// 每行的个数，默认是3个一行
    public var numberInRow = 3
    /// 是否需要分割线，默认有
    public var needSeparatrix = true
    /// 显示时cell是否需要整行填充，默认YES
    public var fullRowPadding = true
    
    open var maximumInteritemSpacing: CGFloat = 1
    public var sizeAdaptType = SizeAdaptType.proportion
    public var imageSize = CGSize()
    
    override init() {
        super.init()
        minimumLineSpacing = 1
        minimumInteritemSpacing = 1
        maximumInteritemSpacing = 1
        itemSize = CGSize.init(width: kStdItemSizeWidth, height: kStdItemSizeHeight)
        imageSize = CGSize.init(width: kStdImageSizeWidth, height: kStdImageSizeHeight)
        headerReferenceSize = CGSize()
        footerReferenceSize = CGSize()
        scrollDirection = .vertical
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        if var attributes = super.layoutAttributesForElements(in: rect) {
            for (index, item) in attributes.enumerated() {
                if index == 0 {
                    continue
                }
                let curAttr = item
                let preAttr = attributes[index-1]
                let origin = preAttr.frame.origin.x + preAttr.frame.size.width
                let targetX = origin + maximumInteritemSpacing
                if curAttr.frame.origin.x > targetX {
                    if targetX + curAttr.frame.size.width < collectionViewContentSize.width {
                        curAttr.frame.origin.x = targetX
                        attributes[index] = curAttr
                    }
                }
            }
            return attributes
        } else {
            return nil
        }
    }
}
