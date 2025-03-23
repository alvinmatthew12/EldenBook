//
//  BossListView.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 22/03/25.
//

import SwiftUI

internal struct BossListView: View {
    internal enum ViewMode: Equatable {
        case list, grid
    }
    
    @StateObject
    private var viewModel = BossListViewModel(useCase: BossUseCase())
    
    @State
    private var viewMode: ViewMode = .list
    
    @State
    private var selectedBossID: String?
    
    @ViewBuilder
    private var contentView: some View {
        switch viewMode {
        case .list:
            List(viewModel.state.bosses) { boss in
                BossItemView(boss: boss)
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                    .onTapGesture {
                        selectedBossID = boss.id
                    }
            }
            .background(Color.clear)
            .listStyle(.plain)
            .scrollIndicators(.hidden)
            
        case .grid:
            ScrollView {
                LazyVGrid(
                    columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ],
                    spacing: 0
                ) {
                    ForEach(viewModel.state.bosses) { boss in
                        BossGridItemView(boss: boss)
                            .onTapGesture {
                                selectedBossID = boss.id
                            }
                    }
                }
                .padding(.horizontal, 8)
            }
            .background(Color.clear)
            .scrollIndicators(.hidden)
        }
    }
    
    internal var body: some View {
        NavigationStack {
            contentView
                .background(Color.base)
                .navigationTitle("Bosses")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarBackground(Color.base, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Picker("Layout", selection: $viewMode) {
                            Image(systemName: "list.bullet")
                                .tag(ViewMode.list)
                                .tint(Color.primary)
                            Image(systemName: "square.grid.2x2")
                                .tag(ViewMode.grid)
                                .tint(Color.primary)
                        }
                        .pickerStyle(.segmented)
                        .frame(width: 100)
                    }
                }
                .task {
                    await viewModel.send(.loadData)
                }
                .navigationDestination(item: $selectedBossID) { bossID in
                    BossDetailView(bossID: bossID)
                }
        }
    }
}

#Preview {
    bossListPreview()
}
