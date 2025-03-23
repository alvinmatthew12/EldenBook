//
//  HomeBannerCell.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 23/03/25.
//

import UIKit

internal class HomeBannerCell: UITableViewCell {
    internal static let reuseIdentifier = "HomeBannerCell"
    
    private var gradientView: UIView?
    private let containerView = UIView()
    private let bannerImageView = EBImageView()
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
        if gradientView == nil, containerView.bounds.width > 0 {
            setupGradient()
        }
    }
    
    private func setupView() {
        selectionStyle = .none
        backgroundColor = .clear
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .black
        containerView.layer.cornerRadius = 12
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.primary200.withAlphaComponent(0.2).cgColor
        containerView.layer.shadowColor = UIColor.primary.cgColor
        containerView.layer.shadowOpacity = 0.2
        containerView.layer.shadowOffset = CGSize(width: 0, height: 4)
        containerView.layer.shadowRadius = 6
        containerView.layer.masksToBounds = true
        contentView.addSubview(containerView)
        
        bannerImageView.translatesAutoresizingMaskIntoConstraints = false
        bannerImageView.contentModeStyle = .scaleAspectFill
        bannerImageView.clipsToBounds = true
        bannerImageView.layer.masksToBounds = true
        containerView.addSubview(bannerImageView)
        
        let textStackView = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel
        ])
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        textStackView.axis = .vertical
        textStackView.spacing = 2
        containerView.addSubview(textStackView)
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            containerView.heightAnchor.constraint(equalToConstant: 140),
            
            bannerImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            bannerImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            bannerImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            bannerImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            textStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            textStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            textStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12),
        ])
    }
    
    private func setupGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.clear.cgColor,
            UIColor.base.cgColor
        ]
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradient.locations = [0.0, 0.9]

        let gradientView = UIView()
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        bannerImageView.addSubview(gradientView)

        NSLayoutConstraint.activate([
            gradientView.topAnchor.constraint(equalTo: bannerImageView.topAnchor),
            gradientView.leadingAnchor.constraint(equalTo: bannerImageView.leadingAnchor),
            gradientView.trailingAnchor.constraint(equalTo: bannerImageView.trailingAnchor),
            gradientView.bottomAnchor.constraint(equalTo: bannerImageView.bottomAnchor)
        ])

        DispatchQueue.main.async {
            gradient.frame = gradientView.bounds
            gradientView.layer.insertSublayer(gradient, at: 0)
        }

        self.gradientView = gradientView
    }

    
    internal func setupContent(_ content: HomeLayoutContent) {
        bannerImageView.load(url: content.image)
        
        titleLabel.text = content.title
        titleLabel.textColor = .primary
        titleLabel.font = .boldSystemFont(ofSize: 16)
        
        subtitleLabel.text = content.subtitle
        subtitleLabel.textColor = .text
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.numberOfLines = 1
        subtitleLabel.setLineSpacing(2)
    }
}
