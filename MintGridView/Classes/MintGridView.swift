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
    /// 表格id
    public var dataID = ""
    /// 表格唯一id，保存数据使用
    public var uniqueID = ""
    
    /// 内容显示方式
    public var contentShowType: ContentShowType = .scroll {
        didSet {
            setNeedsLayout()
        }
    }
    /// 布局类型
    public var layoutType: LayoutType {
        return .square
    }
    /// 布局对象
    public var layout: MintGridViewLayout? {
        didSet {
            reload()
        }
    }
    /// 单元格背景色
    public var cellBackgroundColor = UIColor.white
    /// 单元格字体颜色
    public var cellFontColor = UIColor.init(white: 51.0/256.0, alpha: 1.0)
    /// 单元格选中颜色
    public var cellSelectedColor = UIColor.init(white: 248.0/256.0, alpha: 1.0)
    /// 项目数组
    public var items: [JSON] = [] {
        didSet {
            reload()
        }
    }
    /// 代理对象
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
    
    /// 重新加载
    public func reload() {
        
    }
    /// 注册单元格重用标识
    ///
    /// - Parameters:
    ///   - identifier: 标识符
    ///   - withClass: 类名
    public func registeIdentifier(_ identifier: String, withClass: AnyClass) {
        
    }
    
    /// 更新表格数据
    ///
    /// - Parameter data: 表格字典类型数据
    public func updateWithData(_ data: Dictionary<String, Any>) {
        let view: MintGridView = self
        if let jsonData = JSON.init(data).dictionary {
            let layoutType = view.layoutType
            if layoutType == .table {
            } else {
                /// 更新当前的layout对象
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
