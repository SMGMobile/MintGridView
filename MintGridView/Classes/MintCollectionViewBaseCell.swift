//
//  MintCollectionViewBaseCell.swift
//  Kingfisher
//
//  Created by 季风 on 2017/11/9.
//

import UIKit

public class MintCollectionViewBaseCell: UICollectionViewCell {
    public var item: [String: Any]? {
        didSet{
            setNeedsLayout()
        }
    }
    public var showWay = HotCountShowWay.dot {
        didSet{
            setNeedsLayout()
        }
    }
    public var hotCount = 0 {
        didSet{
            setNeedsLayout()
        }
    }
    public var hotCountView: UIView? {
        didSet{
            setNeedsLayout()
        }
    }
    var cellFontColor: UIColor?
    var cellSelectedColor: UIColor?
    var imageSize: CGSize = CGSize()
    var scale: CGFloat = 1.0
    
    public func emptyData() {
        item = nil
        showWay = .dot
        hotCount = 0
        hotCountView = nil
        cellFontColor = nil
        cellSelectedColor = nil
        imageSize = CGSize()
        scale = 1.0
    }
}
