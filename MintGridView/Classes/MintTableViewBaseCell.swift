//
//  MintTableViewBaseCell.swift
//  MintGridView
//
//  Created by 季风 on 2017/11/8.
//

import UIKit

public class MintTableViewBaseCell: UITableViewCell {
    var item: [String: Any]? {
        didSet{
            setNeedsLayout()
        }
    }
    var showWay = HotCountShowWay.dot {
        didSet{
            setNeedsLayout()
        }
    }
    var hotCount = 0 {
        didSet{
            setNeedsLayout()
        }
    }
    var hotCountView: UIView? {
        didSet{
            setNeedsLayout()
        }
    }
    var showLine = true {
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
