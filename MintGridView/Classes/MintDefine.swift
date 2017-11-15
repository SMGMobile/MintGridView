//
//  MintDefine.swift
//  MintGridView
//
//  Created by 季风 on 2017/11/8.
//

import UIKit

public enum HotCountShowWay {
    case dot
    case number
}
public let AdaptRate = UIScreen.main.bounds.size.width / 375

public let kStdItemSizeWidth:CGFloat = 120
public let kStdItemSizeHeight:CGFloat = 120
public let kStdImageSizeWidth:CGFloat = 40.0
public let kStdImageSizeHeight:CGFloat = 40.0

public let kMainTextColor: CGFloat = 51.0/256.0
public let kSelectedTextColor: CGFloat = 248.0/256.0


public let kUnreadWidth: CGFloat = 16
public let kUnreadOffset: CGFloat = 4

public let kMintGridViewUpdateNotification = "kMintGridViewUpdate"
public let kNotificationKeyDataID = "dataID";
public let kNotificationKeyViewData = "viewData";

