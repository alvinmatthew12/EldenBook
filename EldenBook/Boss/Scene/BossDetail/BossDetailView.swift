//
//  BossView.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 22/03/25.
//

import SwiftUI

internal struct BossView: View {
    @StateObject
    private var viewModel: BossViewModel
    
    @Environment(\.dismiss)
    private var dismiss
    
    internal init(bossID: String) {
        _viewModel = StateObject(wrappedValue: BossViewModel(
            bossID: bossID,
            useCase: BossUseCase()
        ))
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch viewModel.state.viewState {
        case .loading:
            VStack {
                Spacer()
                ProgressView()
                Spacer()
            }
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        case let .error(error):
            Text("error")
            
        case let .boss(boss):
            ScrollView {
                VStack(alignment: .leading) {
                    ZStack(alignment: .bottom) {
                        EBImage(url: boss.image, contentMode: .fill)
                            .aspectRatio(1, contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        LinearGradient(colors: [.clear, .base], startPoint: .top, endPoint: .bottom)
                            .frame(height: 115)
                            .padding(.top, 235)
                    }
                    VStack {
                        Text(boss.name)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundStyle(Color.primary)
                            .font(.system(size: 24))
                            .fontWeight(.semibold)
                            .padding(.bottom, 2)
                        Text(boss.location)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundStyle(Color.text)
                            .font(.system(size: 14))
                            .opacity(0.7)
                            .padding(.bottom, 24)
                        Text(boss.description)
                            .foregroundStyle(Color.text)
                            .font(.system(size: 16))
                            .lineSpacing(2.5)
                    }
                    .padding(.horizontal, 24)
                }
            }
            .scrollIndicators(.hidden)
            .background(Color.clear)
        }
    }
    
    internal var body: some View {
        NavigationStack {
            ZStack(alignment: .topLeading) {
                contentView
                    .task {
                        await viewModel.send(.loadData)
                    }
                    .toolbarBackground(.hidden, for: .navigationBar)
                    .ignoresSafeArea(.container, edges: .top)
                    .navigationBarBackButtonHidden(true)
                
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(12)
                        .background(Color.black.opacity(0.6))
                        .clipShape(Circle())
                        .shadow(radius: 4)
                }
                .padding(.leading, 16)
            }
            .background(Color.base)
        }
    }
}

#Preview {
    BossView(bossID: "1")
        .preferredColorScheme(.dark)
}
