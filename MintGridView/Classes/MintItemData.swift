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
public extension Dictionary {
    public var dataID: String {
        return mintData(.dataID)?.string ?? ""
    }
    public var uniqueID: String {
        return mintData(.uniqueID)?.string ?? ""
    }
    public var layoutType: LayoutType {
        return (mintData(.layoutType)?.string ?? "").elementsEqual("1") ? .table : .square
    }
    public var numberInRow: Int {
        let num = mintData(.numberInRow)?.string ?? ""
        if let n = Int(num) {
            return n
        } else {
            return 0
        }
    }
    public var items: Array<JSON> {
        let data = mintData(.items)
        
        return convertToJSON(data: data)?.array ?? []
    }
    public func mintData(_ key: MintDataKey) -> JSON? {
        let privateDict = self as! Dictionary<String, JSON>
        return privateDict[key.rawValue]
    }
    public func convertToJSON(data: JSON?) -> JSON? {
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
public extension Dictionary {
    public var itemID: String {
        return mintItemString(.itemID)
    }
    public var itemName: String {
        return mintItemString(.itemName)
    }
    public var imageURL: String {
        return mintItemString(.imageURL)
    }
    public var order: String {
        return mintItemString(.order)
    }
    public var path: String {
        return mintItemString(.path)
    }
    public var secondPageData: Dictionary<String, JSON>? {
        return convertToJSON(data: mintItem(.secondPageData))?.dictionary
    }
    public var extraInfo: Dictionary<String, JSON>? {
        return convertToJSON(data: mintItem(.extraInfo))?.dictionary
    }
    public func mintItem(_ key: ItemKey) -> JSON? {
        let privateDict = self as! Dictionary<String, JSON>
        return privateDict[key.rawValue]
    }
    public func mintItemString(_ key: ItemKey) -> String {
        return mintItem(key)?.string ?? ""
    }
}
