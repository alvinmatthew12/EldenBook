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
    fileprivate static let primary = "#BBA57F"
    fileprivate static let primary800 = "#897859"
    fileprivate static let primary600 = "#A2906F"
    fileprivate static let primary200 = "#D2BA94"
    fileprivate static let text = "#ECECEC"
}

extension Color {
    public static let base = Color(hex: .base)
    public static let primary = Color(hex: .primary)
    public static let primary800 = Color(hex: .primary800)
    public static let primary600 = Color(hex: .primary600)
    public static let primary200 = Color(hex: .primary200)
    public static let text = Color(hex: .text)
}

extension UIColor {
    public static let base = UIColor(hex: .base)
    public static let primary = UIColor(hex: .primary)
    public static let primary800 = UIColor(hex: .primary800)
    public static let primary600 = UIColor(hex: .primary600)
    public static let primary200 = UIColor(hex: .primary200)
    public static let text = UIColor(hex: .text)
}
