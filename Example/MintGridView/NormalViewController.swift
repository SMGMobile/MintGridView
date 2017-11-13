//
//  NormalViewController.swift
//  MintGridView_Example
//
//  Created by 季风 on 2017/11/10.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import MintGridView
import SwiftyJSON

class NormalViewController: UIViewController, MintGridViewDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(gridView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gridView.frame.origin = view.bounds.origin
        gridView.frame.origin.y = 64
        gridView.frame.size.width = view.bounds.width
        gridView.frame.size.height = 150
    }
    
    lazy var gridView: MintGridView = {
        let path = Bundle.main.path(forResource: "001", ofType: "geojson")
        let data = try! Data.init(contentsOf: URL.init(fileURLWithPath: path!))
        let dict = try? JSON(data: data)
        let gv = MintGridView.gridViewWith(data: (dict?.dictionaryObject)!)
        gv.contentShowType = .expand
        let layout = gv.layout as! MintCollectionViewLayout
        layout.flowLayout.fullRowPadding = false
        gv.layout = layout
        gv.delegate = self
        return gv
    }()
    
    //MARK: -
    //MARK: MintGridViewDelegate
    func gridView(_ gridView: MintGridView, didSelectWith item: Dictionary<String, Any>) {
        print(item)
    }
    func gridView(_ gridView: MintGridView, cell: Any, countHotViewFor indexPath: IndexPath) -> UIView? {
        return nil
    }
    func gridView(_ gridView: MintGridView, cell: Any, customFor indexPath: IndexPath) {
        
    }
    func gridView(_ gridView: MintGridView, frameUpdatedWith frame: CGRect) {
        
    }
}
