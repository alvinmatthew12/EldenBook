//
//  EBImageLoader.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 23/03/25.
//

import Combine
import Foundation
import UIKit

public final class EBImageLoader: ObservableObject {
    public enum State: Equatable {
        case loading
        case success(UIImage)
        case failure
    }
    
    @Published var state: State = .loading {
        didSet {
            stateSubject.send(state)
        }
    }
    
    private let stateSubject = CurrentValueSubject<State, Never>(.loading)
    public var statePublisher: AnyPublisher<State, Never> {
        stateSubject.eraseToAnyPublisher()
    }
    
    private var cancellable: AnyCancellable?

    public func load(from url: URL) {
        if let cached = ImageCacheManager.shared.image(for: url) {
            self.state = .success(cached)
            self.cancel()
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { data, _ in UIImage(data: data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                guard let self, let image, let url = URL(string: url.absoluteString) else {
                    self?.state = .failure
                    return
                }
                ImageCacheManager.shared.insert(image, for: url)
                self.state = .success(image)
                self.cancel()
            }
    }

    public func cancel() {
        cancellable?.cancel()
    }
}

fileprivate final class ImageCacheManager {
    internal static let shared = ImageCacheManager()
    
    private let cache = NSCache<NSURL, UIImage>()
    
    private init() {}
    
    internal func image(for url: URL) -> UIImage? {
        cache.object(forKey: url as NSURL)
    }
    
    internal func insert(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
}
