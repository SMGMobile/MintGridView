//
//  MintGridView.swift
//  MintGridView
//
//  Created by 季风 on 2017/11/7.
//

import UIKit
import SwiftyJSON

//动态布局的内容如何展示
public enum ContentShowType {
    case scroll //动态布局的View高度固定，内容超出后在自身view内滚动
    case expand //动态布局的View高度根据内容确定，高度不断延伸，所以需要将它添加到UIScrollView中
}

public enum LayoutType: Int {
    case square = 0 // 九宫格
    case table  // 列表
}

public protocol MintGridViewDelegate: NSObjectProtocol {
    func gridView(_ gridView: MintGridView, didSelectWith item: Dictionary<String, Any>)
    func gridView(_ gridView: MintGridView, cell: Any, countHotViewFor indexPath: IndexPath) -> UIView?
    func gridView(_ gridView: MintGridView, cell: Any, customFor indexPath: IndexPath)
    func gridView(_ gridView: MintGridView, frameUpdatedWith frame: CGRect)
}

public extension MintGridViewDelegate {
    func gridView(_ gridView: MintGridView, didSelectWith item: Dictionary<String, Any>) {
        
    }
    func gridView(_ gridView: MintGridView, cell: Any, countHotViewFor indexPath: IndexPath) -> UIView? {
        return nil
    }
    func gridView(_ gridView: MintGridView, cell: Any, customFor indexPath: IndexPath) {
        
    }
    func gridView(_ gridView: MintGridView, frameUpdatedWith frame: CGRect) {
        
    }
}

public class MintGridView: UIView {
    public var dataID = ""
    public var uniqueID = ""
    
    public var contentShowType: ContentShowType = .scroll {
        didSet {
            setNeedsLayout()
        }
    }
    public var layoutType: LayoutType {
        return .square
    }
    public var layout: MintGridViewLayout? {
        didSet {
            reload()
        }
    }
    public var cellBackgroundColor = UIColor.white
    public var cellFontColor = UIColor.init(white: 51.0/256.0, alpha: 1.0)
    public var cellSelectedColor = UIColor.init(white: 248.0/256.0, alpha: 1.0)
    public var items: [JSON] = [] {
        didSet {
            reload()
        }
    }
    public var delegate: MintGridViewDelegate?
    
    //MARK: -
    //MARK: class method
    public class func gridViewWith(data: Dictionary<String, Any>) -> MintGridView {
        var view: MintGridView
        if let jsonData = JSON.init(data).dictionary {
            let layoutType = jsonData.layoutType
            if layoutType == .table {
                view = MintTableView()
            } else {
                view = MintCollectionView()
                let layout = MintCollectionViewLayout()
                let num = jsonData.numberInRow
                if num > 0 {
                    layout.flowLayout.numberInRow = num
                }
                view.layout = layout
            }
            view.dataID = jsonData.dataID
            view.items = jsonData.items
        } else {
            view = MintCollectionView()
        }
        return view
    }
    
    //MARK: -
    //MARK: lifecycle
    public override init(frame: CGRect) {
        delegate = nil
        super.init(frame: frame)
        NotificationCenter.default.addObserver(self, selector: #selector(self.update(_:)), name: NSNotification.Name(rawValue: kMintGridViewUpdateNotification), object: nil)
    }
    
    public convenience init() {
        self.init(frame: CGRect())
    }
    
    required public init?(coder aDecoder: NSCoder) {
        delegate = nil
        super.init(coder: aDecoder)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: -
    //MARK: public method
    public func reload() {
        
    }
    public func registeIdentifier(_ identifier: String, withClass: AnyClass) {
        
    }
    
    public func updateWithData(_ data: Dictionary<String, Any>) {
        let view: MintGridView = self
        if let jsonData = JSON.init(data).dictionary {
            let layoutType = view.layoutType
            if layoutType == .table {
            } else {
                if let layout = view.layout as? MintCollectionViewLayout {
                    let num = jsonData.numberInRow
                    if num > 0 {
                        layout.flowLayout.numberInRow = num
                    }
                    view.layout = layout
                }
            }
            view.items = jsonData.items
        }
    }
    
    @objc func update(_ notification: Notification) {
        guard let data = notification.userInfo?[kNotificationKeyViewData] else { return }
        guard let dataID = notification.userInfo?[kNotificationKeyDataID] as? String else { return }
        if dataID != self.dataID {
            return
        }
        updateWithData(data as! Dictionary<String, Any>)
    }
}
