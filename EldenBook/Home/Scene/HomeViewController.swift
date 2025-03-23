//
//  HomeViewController.swift
//  EldenBook
//
//  Created by Alvin Matthew Pratama on 23/03/25.
//

import Combine
import Foundation
import UIKit

public final class HomeViewController: UIViewController {
    private enum Section {
        case main
    }
    
    private let tableView = UITableView()
    private var dataSource: UITableViewDiffableDataSource<Section, HomeSection>?
    
    private let viewModel: HomeViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    private var sections = [HomeSection]()
    
    public init() {
        self.viewModel = HomeViewModel(useCase: HomeUseCase())
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        bindViewModel()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .base
        tableView.showsVerticalScrollIndicator = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: -44),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let cells: [(type: UITableViewCell.Type, identifier: String)] = [
            (HomeHeroSectionCell.self, HomeHeroSectionCell.reuseIdentifier),
            (HomeBannerCell.self, HomeBannerCell.reuseIdentifier),
            (HomeRecomCell.self, HomeRecomCell.reuseIdentifier),
        ]
        
        for cell in cells {
            tableView.register(cell.type, forCellReuseIdentifier: cell.identifier)
        }
        
        dataSource = UITableViewDiffableDataSource<Section, HomeSection>(tableView: tableView) { [weak self] tableView, indexPath, itemIdentifier in
            guard let self, let section = self.sections[safe: indexPath.row] else { return UITableViewCell() }
            
            switch section {
            case let .hero(content):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeHeroSectionCell.reuseIdentifier, for: indexPath) as? HomeHeroSectionCell else { return UITableViewCell() }
                cell.setupContent(content)
                return cell
                
            case let .banner(content):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeBannerCell.reuseIdentifier, for: indexPath) as? HomeBannerCell else { return UITableViewCell() }
                cell.setupContent(content)
                return cell
                
            case let .recommendation(identifier):
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeRecomCell.reuseIdentifier, for: indexPath) as? HomeRecomCell else { return UITableViewCell() }
                cell.setIdentifier(identifier)
                return cell
            }
        }
    }
    
    private func applySections() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, HomeSection>()
        snapshot.appendSections([.main])
        snapshot.appendItems(sections, toSection: .main)
        dataSource?.apply(snapshot, animatingDifferences: true)
    }

    
    private func bindViewModel() {
        let didLoadSubject = PassthroughSubject<Void, Never>()
        
        let output = viewModel.transform(input: .init(
            didLoad: didLoadSubject.eraseToAnyPublisher()
        ))
        
        didLoadSubject.send()
        
        output.sections
            .sink { [weak self] sections in
                self?.sections = sections
                self?.applySections()
            }
            .store(in: &cancellables)
    }
}
