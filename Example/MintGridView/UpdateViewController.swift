//
//  UpdateViewController.swift
//  MintGridView_Example
//
//  Created by 季风 on 2017/11/13.
//  Copyright © 2017年 CocoaPods. All rights reserved.
//

import UIKit
import SwiftyJSON
import MintGridView

class UpdateViewController: NormalViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "更新", style: .plain, target: self, action: #selector(self.update(_:)))
    }
    
    @objc func update(_ sender: UIBarButtonItem) {
        let path = Bundle.main.path(forResource: "001_2", ofType: "geojson")
        let data = try! Data.init(contentsOf: URL.init(fileURLWithPath: path!))
        let dict = try? JSON(data: data)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: kMintGridViewUpdateNotification), object: self, userInfo: [kNotificationKeyDataID:"001",kNotificationKeyViewData:dict?.dictionaryObject])
    }
}
