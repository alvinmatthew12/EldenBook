//
//  Array+Ext.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 23/03/25.
//

import Foundation

extension Array {
    @inlinable
    public subscript(safe index: Index) -> Element? {
        get {
            guard startIndex <= index, index < endIndex else { return nil }
            return self[index]
        }
        set {
            guard let newValue, startIndex <= index, index < endIndex else { return }
            self[index] = newValue
        }
    }
}
