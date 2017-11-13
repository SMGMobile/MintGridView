//
//  MintResource.swift
//  MintGridView
//
//  Created by 季风 on 2017/11/12.
//

import Foundation

extension Bundle {
    class func relativePath() -> String {
        let mainBundlePath = Bundle.main.bundlePath
        let currentBundlePath = Bundle.init(for: MintGridView.self).bundlePath
        var relativePath = ""
        if mainBundlePath.elementsEqual(currentBundlePath) {
            relativePath = ""
        } else {
            if let range = currentBundlePath.range(of: mainBundlePath) {
                if range.lowerBound != range.upperBound {
                    relativePath = String(currentBundlePath[currentBundlePath.index(after: range.upperBound)...])
                }
            }
        }
        return relativePath
    }
    
    class func cellDefaultImageName() -> String {
        return self.relativePath() + "/MintGridView.bundle/fxtx"
    }
}
