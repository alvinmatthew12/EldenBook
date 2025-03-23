//
//  UILabel+Ext.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 23/03/25.
//

import UIKit

extension UILabel {
    public func setLineSpacing(_ spacing: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing

        let attributedString = NSAttributedString(
            string: self.text ?? "",
            attributes: [
                .paragraphStyle: paragraphStyle,
                .foregroundColor: self.textColor ?? .label,
                .font: self.font ?? UIFont.systemFont(ofSize: 17)
            ]
        )

        attributedText = attributedString
    }
}
