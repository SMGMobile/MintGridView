//
//  MintTableView.swift
//  MintGridView
//
//  Created by 季风 on 2017/11/7.
//

import UIKit

let cellHeight: CGFloat = 50.0

class MintTableView: MintGridView {
    typealias ViewLayout = MintTableViewLayout
    let defaultCellIdentifier = "MintTableViewCell"
    var cellIdentifier = ""
    var cellClass:MintTableViewBaseCell.Type = MintTableViewCell.self
    override var layoutType: LayoutType {
        return .table
    }
    //MARK: -
    //MARK: public
    override func reload() {
        tableView.reloadData()
        setNeedsLayout()
    }
    override func registeIdentifier(_ identifier: String, withClass: AnyClass) {
        cellIdentifier = identifier
        cellClass = withClass as! MintTableViewBaseCell.Type
        tableView .register(cellClass, forCellReuseIdentifier: cellIdentifier)
    }
    //MARK: -
    //MARK: lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        cellIdentifier = defaultCellIdentifier
        registeIdentifier(cellIdentifier, withClass: cellClass)
        self.addSubview(tableView)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        if contentShowType == .expand {
            tableView.isScrollEnabled = false
            var height = cellHeight * CGFloat(items.count)
            if height < 0 {
                height = 0
            }
            var tableViewRect = bounds
            tableViewRect.size.height = height
            tableView.frame = tableViewRect
            var selfRect = frame
            selfRect.size.height = height
            frame = selfRect
            delegate?.gridView(self, frameUpdatedWith: selfRect)
        } else {
            tableView.frame = bounds
            tableView.isScrollEnabled = true
        }
    }
    
    //MARK: -
    //MARK: private
    
    
    //MARK: -
    //MARK: lazyload
    lazy var tableView: UITableView = {
        let table = UITableView.init(frame: CGRect(), style: .plain)
        table.delegate = self
        table.dataSource = self
        table.separatorColor = UIColor.clear
        return table
    }()
}

extension MintTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MintTableViewBaseCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! MintTableViewBaseCell
        cell.backgroundColor = UIColor.clear
        cell.selectedBackgroundView = UIView.init(frame: cell.bounds)
        cell.selectedBackgroundView?.backgroundColor = UIColor.init(white: 204.0/256.0, alpha: 1.0)
        cell.emptyData()
        cell.item = items[indexPath.row].dictionary
        if let del = delegate {
            if del.responds(to: Selector(("gridView:cell:countHotViewForIndexPath:"))) {
                let view = del.gridView(self, cell: cell, countHotViewFor: indexPath)
                cell.hotCountView = view
            }
            if del.responds(to: Selector(("gridView:cell:customForIndexPath:"))) {
                del.gridView(self, cell: cell, customFor: indexPath)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row<items.count {
            if let del = delegate {
                del.gridView(self, didSelectWith: items[indexPath.row].dictionaryObject!)
            }
        }
    }
}
