//
//  MintCollectionView.swift
//  MintGridView
//
//  Created by 季风 on 2017/11/7.
//

import Foundation

class MintCollectionView: MintGridView {
    var extra = 0
    
    /// 在layoutSubviews()方法中更新frame属性会造成死循环，所以要缓存一下高度
    var frameHeight: CGFloat = 0
    let defaultCellIdentifier = "MintCollectionViewCell"
    var actualItemSize = CGSize()
    var cellIdentifier = ""
    var cellClass:MintCollectionViewBaseCell.Type = MintCollectionViewCell.self
    override var layout: MintGridViewLayout? {
        didSet {
            flowLayout = (layout as! MintCollectionViewLayout).flowLayout
        }
    }
    var flowLayout = MintCollectionViewFlowLayout()
    
    //MARK: -
    //MARK: public
    override func reload() {
        collectionView.reloadData()
        setNeedsLayout()
    }
    override func registeIdentifier(_ identifier: String, withClass: AnyClass) {
        cellIdentifier = identifier
        cellClass = withClass as! MintCollectionViewBaseCell.Type
        
        collectionView.register(withClass, forCellWithReuseIdentifier: identifier)
    }
    //MARK: -
    //MARK: lifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellIdentifier = defaultCellIdentifier
        collectionView.register(cellClass, forCellWithReuseIdentifier: cellIdentifier)
        addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if #available(iOS 11.0, *) {
            collectionView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        setCollectionViewBackgroundColor()
        
        extra = Int((bounds.width - CGFloat(flowLayout.numberInRow - 1) * flowLayout.minimumInteritemSpacing - flowLayout.sectionInset.left - flowLayout.sectionInset.right).truncatingRemainder(dividingBy: CGFloat(flowLayout.numberInRow)))
        let perWidth = floor((bounds.width - CGFloat(flowLayout.numberInRow - 1) * flowLayout.minimumInteritemSpacing - flowLayout.sectionInset.left - flowLayout.sectionInset.right) / CGFloat(flowLayout.numberInRow))
        var perHeight:CGFloat
        
        switch flowLayout.sizeAdaptType {
        case .proportion:
            perHeight = perWidth * flowLayout.itemSize.height / flowLayout.itemSize.width
        case .fixedHeight:
            perHeight = flowLayout.itemSize.height
        }
        actualItemSize = CGSize.init(width: perWidth, height: perHeight)
        
        // 计算collectionView实时高度
        let row = ceil(CGFloat(items.count) / CGFloat(flowLayout.numberInRow))
        let totalSpace = flowLayout.minimumLineSpacing * (row - 1)
        var height = flowLayout.sectionInset.top + (actualItemSize.height * row) + totalSpace + flowLayout.sectionInset.bottom
        if height < 0 {
            height = 0
        }
        if height==frameHeight {
            return
        }
        if contentShowType == .scroll {
            var collectionRect = bounds
            if height < collectionRect.height {
                collectionRect.size.height = height
            }
            collectionView.frame = collectionRect
        } else if contentShowType == .expand {
            var collectionRect = bounds
            collectionRect.size.height = height
            collectionView.frame = collectionRect
            
            var selfRect = frame
            if selfRect.height != height {
                selfRect.size.height = height
                frame = selfRect
                delegate?.gridView(self, frameUpdatedWith: frame)
            }
        }
        frameHeight = height
    }
    //MARK: -
    //MARK: private
    func setCollectionViewBackgroundColor() {
        collectionView.backgroundColor = flowLayout.needSeparatrix ? UIColor.init(white: 243.0/256.0, alpha: 1.0) : UIColor.clear
    }
    //MARK: -
    //MARK: lazyLoad
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView.init(frame: CGRect(), collectionViewLayout: flowLayout)
        cv.delegate = self as UICollectionViewDelegate
        cv.dataSource = self
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
}

extension MintCollectionView: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if flowLayout.fullRowPadding {
            return Int(ceil(Float(items.count) / Float(flowLayout.numberInRow))) * flowLayout.numberInRow
        } else {
            return items.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MintCollectionViewBaseCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MintCollectionViewBaseCell
        cell.emptyData()
        cell.backgroundColor = cellBackgroundColor
        cell.cellFontColor = cellFontColor
        cell.cellSelectedColor = cellSelectedColor
        let widthScale = actualItemSize.width / kStdItemSizeWidth
        let heightScale = actualItemSize.height / kStdItemSizeHeight
        cell.scale = widthScale < heightScale ? widthScale : heightScale
        cell.imageSize = flowLayout.imageSize
        
        if indexPath.row < items.count {
            cell.item = items[indexPath.row].dictionary
            if let view = delegate?.gridView(self, cell: cell, countHotViewFor: indexPath) {
                cell.addSubview(view)
            }
            delegate?.gridView(self, cell: cell, customFor: indexPath)
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row % flowLayout.numberInRow < extra {
            return CGSize.init(width: actualItemSize.width+1, height: actualItemSize.height)
        } else {
            return actualItemSize
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if indexPath.row < items.count {
            delegate?.gridView(self, didSelectWith: items[indexPath.row].dictionaryObject!)
        }
    }
}
