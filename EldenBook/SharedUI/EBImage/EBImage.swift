//
//  EBImage.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 22/03/25.
//

import Combine
import SwiftUI

public struct EBImage: View {
    public let url: URL?
    public var contentMode: ContentMode = .fit
    
    @StateObject
    private var loader = EBImageLoader()

    public var body: some View {
        Group {
            switch loader.state {
            case .loading:
                ProgressView()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            case let .success(image):
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: contentMode)
                
            case .failure:
                Image(systemName: "xmark.octagon.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.gray)
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
