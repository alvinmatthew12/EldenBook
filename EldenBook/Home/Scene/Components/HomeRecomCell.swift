//
//  HomeRecomCell.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 23/03/25.
//

import SwiftUI
import UIKit

internal class HomeRecomCell: UITableViewCell {
    internal static let reuseIdentifier = "HomeRecomCell"
    
    private let identifierHolder = RecomCarouselIdentifierHolder()
    private lazy var recomCarouselView = UIHostingController(rootView: RecomCarouselView(
        identifierHolder: identifierHolder
    ))
    
    override internal init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .clear
        
        recomCarouselView.view.backgroundColor = .clear
        recomCarouselView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(recomCarouselView.view)

        NSLayoutConstraint.activate([
            recomCarouselView.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            recomCarouselView.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            recomCarouselView.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            recomCarouselView.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            recomCarouselView.view.heightAnchor.constraint(equalToConstant: 270)
        ])
    }
    
    internal func setIdentifier(_ identifier: String) {
        identifierHolder.identifier = identifier
    }
}
