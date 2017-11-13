//
//  HotCountViewController.swift
//  MintGridView_Example
//
//  Created by 季风 on 2017/11/13.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import Foundation
import MintGridView

class HotCountViewController: NormalViewController {
    
    override func gridView(_ gridView: MintGridView, didSelectWith item: Dictionary<String, Any>) {
        print("项目数据：\(item)")
    }
    
    override func gridView(_ gridView: MintGridView, cell: Any, customFor indexPath: IndexPath) {
        let cell = cell as! MintCollectionViewCell
        cell.showWay = .number
        cell.hotCount = 100
    }
    
}

extension HotCountViewController {
}
