//
//  MintTableViewBaseCell.swift
//  MintGridView
//
//  Created by 季风 on 2017/11/8.
//

import UIKit

public class MintTableViewBaseCell: UITableViewCell {
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
    public var showLine = true {
        didSet{
            setNeedsLayout()
        }
    }
    public func emptyData() {
        item = nil
        showWay = .dot
        hotCount = 0
        hotCountView = nil
        showLine = true
    }
}
