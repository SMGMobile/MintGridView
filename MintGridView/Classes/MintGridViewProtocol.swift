//
//  MintGridViewProtocol.swift
//  MintGridView
//
//  Created by 季风 on 2017/11/7.
//

import Foundation

protocol MintGridViewProtocol: NSObjectProtocol {
    associatedtype ViewLayout
    var layout: ViewLayout { get set }
    
}
