//
//  Collection+Ext.swift
//  interview
//
//  Created by Ara Hakobyan on 3/29/24.
//

import Foundation

public extension Collection {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
