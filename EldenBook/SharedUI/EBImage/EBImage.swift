//
//  EBImage.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 22/03/25.
//

import Foundation
import SwiftUI
import Combine

public struct EBImage: View {
    public let url: URL?
    public var contentMode: ContentMode = .fit
    
    @StateObject
    private var loader = AsyncImageLoader()

    public var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
            } else if loader.failed {
                Image(systemName: "xmark.octagon.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
            } else {
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .onAppear {
            if let url = url {
                loader.load(from: url)
            }
        }
        .onDisappear {
            loader.cancel()
        }
    }

    private var placeholder: some View {
        Color.gray.opacity(0.2)
            .overlay(
                ProgressView().opacity(0.5)
            )
    }

    private var errorView: some View {
        Image(systemName: "xmark.octagon.fill")
            .resizable()
            .scaledToFit()
            .foregroundColor(.gray)
    }

    private func imageView(_ image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: contentMode)
    }
}

fileprivate final class AsyncImageLoader: ObservableObject {
    @Published var image: UIImage?
    @Published var failed = false
    private var cancellable: AnyCancellable?

    internal func load(from url: URL) {
        if let cached = ImageCacheManager.shared.image(for: url) {
            self.image = cached
            return
        }

        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { data, _ in UIImage(data: data) }
            .handleEvents(receiveOutput: { [weak self] in
                self?.failed = $0 == nil
            })
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                guard let self, let image, let url = URL(string: url.absoluteString) else { return }
                ImageCacheManager.shared.insert(image, for: url)
                self.image = image
            }
    }

    internal func cancel() {
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
