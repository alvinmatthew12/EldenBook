//
//  RecomCarouselView.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 23/03/25.
//

import SwiftUI

public final class RecomCarouselIdentifierHolder: ObservableObject {
    @Published
    public var identifier: String = ""
    
    public init() {}
}

public struct RecomCarouselView: View {
    @Binding
    public var identifier: String
    
    @ObservedObject
    public var identifierHolder: RecomCarouselIdentifierHolder
    
    @StateObject
    private var viewModel = RecomCarouselViewModel(
        useCase: RecomUseCase(),
        routeEnvironment: RouteEnvironment()
    )
    
    public init(
        identifier: String = "",
        identifierHolder: RecomCarouselIdentifierHolder = .init()
    ) {
        _identifier = .constant(identifier)
        self.identifierHolder = identifierHolder
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            if !viewModel.state.data.title.isEmpty {
                Text(viewModel.state.data.title)
                    .font(.system(size: 21))
                    .foregroundStyle(Color.primary)
                    .fontWeight(.semibold)
                    .padding(.top, 12)
                    .padding(.bottom, 2)
                    .padding(.leading, 18)
            }
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 4) {
                    Spacer().frame(width: 10)
                    
                    ForEach(viewModel.state.data.items) { item in
                        RecomCarouselItemView(item: item)
                            .onTapGesture {
                                Task {
                                    await viewModel.send(.route(url: item.applink))
                                }
                            }
                    }
                    
                    if let seeMoreApplink = viewModel.state.data.seeMoreApplink {
                        RecomCarouselSeeMoreView()
                            .onTapGesture {
                                Task {
                                    await viewModel.send(.route(url: seeMoreApplink))
                                }
                            }
                    }
                    
                    Spacer().frame(width: 16)
                }
            }
            .background(Color.clear)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            .scrollIndicators(.hidden)
        }
        .onReceive(identifierHolder.$identifier) { identifier in
            Task {
                await viewModel.send(.loadData(identifier: identifier))
            }
        }
        .onChange(of: identifier) { _, newValue in
            Task {
                await viewModel.send(.loadData(identifier: newValue))
            }
        }
        .task {
            if !identifier.isEmpty {
                await viewModel.send(.loadData(identifier: identifier))
            }
        }
    }
}

#Preview {
    RecomCarouselView(identifier: "Bosses")
        .preferredColorScheme(.dark)
}
