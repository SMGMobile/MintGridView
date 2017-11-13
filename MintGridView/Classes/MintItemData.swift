//
//  MintItemData.swift
//  MintGridView
//
//  Created by 季风 on 2017/11/9.
//

import Foundation
import SwiftyJSON

//MARK: -
//MARK: data的值
extension Dictionary {
    var dataID: String {
        return mintData(.dataID)?.string ?? ""
    }
    var uniqueID: String {
        return mintData(.uniqueID)?.string ?? ""
    }
    var layoutType: LayoutType {
        return (mintData(.layoutType)?.string ?? "").elementsEqual("1") ? .table : .square
    }
    var numberInRow: Int {
        let num = mintData(.numberInRow)?.string ?? ""
        if let n = Int(num) {
            return n
        } else {
            return 0
        }
    }
    var items: Array<JSON> {
        let data = mintData(.items)
        
        return convertToJSON(data: data)?.array ?? []
    }
    func mintData(_ key: MintDataKey) -> JSON? {
        let privateDict = self as! Dictionary<String, JSON>
        return privateDict[key.rawValue]
    }
    func convertToJSON(data: JSON?) -> JSON? {
        if data?.type == .null || data?.type == .unknown {
            return nil
        } else if data?.type == .string {
            return JSON.init(parseJSON: (data?.string)!)
        } else  {
            return data
        }
    }
}

//MARK: -
//MARK: - item的值
extension Dictionary {
    public var itemID: String {
        return mintItemString(.itemID)
    }
    var itemName: String {
        return mintItemString(.itemName)
    }
    var imageURL: String {
        return mintItemString(.imageURL)
    }
    var order: String {
        return mintItemString(.order)
    }
    var path: String {
        return mintItemString(.path)
    }
    var secondPageData: Dictionary<String, JSON>? {
        return convertToJSON(data: mintItem(.secondPageData))?.dictionary
    }
    var extraInfo: Dictionary<String, JSON>? {
        return convertToJSON(data: mintItem(.extraInfo))?.dictionary
    }
    func mintItem(_ key: ItemKey) -> JSON? {
        let privateDict = self as! Dictionary<String, JSON>
        return privateDict[key.rawValue]
    }
    func mintItemString(_ key: ItemKey) -> String {
        return mintItem(key)?.string ?? ""
    }
}
