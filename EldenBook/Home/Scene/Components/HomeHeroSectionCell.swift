//
//  HomeHeroSectionCell.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 23/03/25.
//

import UIKit

internal class HomeHeroSectionCell: UITableViewCell {
    internal static let reuseIdentifier = "HomeHeroSectionCell"
    
    private var gradientView: UIView?
    private let backgroundImageView = EBImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    override internal init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    internal required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override internal func layoutSubviews() {
        super.layoutSubviews()
        if gradientView == nil {
            setupGradient()
        }
    }
    
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .clear
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.contentModeStyle = .scaleAspectFill
        contentView.addSubview(backgroundImageView)
        
        let textStackView = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel
        ])
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        textStackView.axis = .vertical
        textStackView.spacing = 2
        contentView.addSubview(textStackView)
        
        NSLayoutConstraint.activate([
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: backgroundImageView.widthAnchor, multiplier: 0.8),
            backgroundImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            textStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            textStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            textStackView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor, constant: -4),
        ])
    }
    
    private func setupGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.base.withAlphaComponent(0.8).cgColor,
            UIColor.clear.cgColor,
            UIColor.clear.cgColor,
            UIColor.base.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.locations = [0.05, 0.3, 0.6, 0.95]
        gradient.frame = CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height)
        
        let gradientView = UIView()
        gradientView.layer.addSublayer(gradient)
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.addSubview(gradientView)
        
        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: backgroundImageView.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: backgroundImageView.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: backgroundImageView.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: backgroundImageView.bottomAnchor),
        ])
        
        self.gradientView = gradientView
    }
    
    internal func setupContent(_ content: HomeLayoutContent) {
        backgroundImageView.load(url: content.image)
        
        titleLabel.text = content.title
        titleLabel.textColor = .primary
        titleLabel.font = .boldSystemFont(ofSize: 21)
        
        subtitleLabel.text = content.subtitle
        subtitleLabel.textColor = .text
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.numberOfLines = 0
        subtitleLabel.setLineSpacing(2)
    }
}
