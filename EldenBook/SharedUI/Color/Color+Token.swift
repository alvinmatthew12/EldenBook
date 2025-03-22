//
//  Color+Token.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 22/03/25.
//

import SwiftUI
import UIKit

extension String {
    fileprivate static let base = "#0A0A0A"
    fileprivate static let primary = "#897859"
    fileprivate static let text = "#ECECEC"
}

extension Color {
    public static let base = Color(hex: .base)
    public static let primary = Color(hex: .primary)
    public static let text = Color(hex: .text)
}

extension UIColor {
    public static let base = UIColor(hex: .base)
    public static let primary = UIColor(hex: .primary)
    public static let text = UIColor(hex: .text)
}
