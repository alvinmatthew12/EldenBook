//
//  EBImageView.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 23/03/25.
//

import Combine
import UIKit

public final class EBImageView: UIView {
    public let imageView = UIImageView()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let errorIcon = UIImageView(image: UIImage(systemName: "xmark.octagon.fill"))

    private var loader = EBImageLoader()
    private var cancellable: AnyCancellable?

    public var contentModeStyle: UIView.ContentMode = .scaleAspectFit {
        didSet {
            imageView.contentMode = contentModeStyle
        }
    }
    
    public init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    deinit {
        cancel()
    }

    private func setupUI() {
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false

        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        errorIcon.tintColor = .gray
        errorIcon.contentMode = .scaleAspectFit
        errorIcon.translatesAutoresizingMaskIntoConstraints = false
        errorIcon.isHidden = true

        addSubview(imageView)
        addSubview(activityIndicator)
        addSubview(errorIcon)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),

            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor),

            errorIcon.centerXAnchor.constraint(equalTo: centerXAnchor),
            errorIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            errorIcon.heightAnchor.constraint(equalToConstant: 32),
            errorIcon.widthAnchor.constraint(equalToConstant: 32)
        ])
    }

    public func load(url: URL?) {
        guard let url else {
            showError()
            return
        }

        imageView.image = nil
        errorIcon.isHidden = true
        activityIndicator.startAnimating()
        
        loader.load(from: url)

        cancellable = loader.statePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                guard let self = self else { return }

                self.activityIndicator.stopAnimating()

                switch state {
                case .loading:
                    break // already handled

                case .success(let image):
                    self.imageView.image = image
                    self.errorIcon.isHidden = true

                case .failure:
                    self.showError()
                }
            }
    }

    public func cancel() {
        cancellable?.cancel()
        cancellable = nil
    }

    private func showError() {
        imageView.image = nil
        errorIcon.isHidden = false
        activityIndicator.stopAnimating()
    }
}
