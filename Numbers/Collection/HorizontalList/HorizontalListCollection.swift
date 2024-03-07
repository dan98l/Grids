//
//  HorizontalListCollection.swift
//  Numbers
//
//  Created by Daniil MacBook Pro on 06.03.2024.
//

import UIKit

final class HorizontalListCollection: UITableView {
    
    private(set) var viewModel: CollectionViewModel
    
    private var snapshot = NSDiffableDataSourceSnapshot<Section, HorizontalListCollectionCell>()
    private var diffableDataSource: UITableViewDiffableDataSource<Section, HorizontalListCollectionCell>?
    
    init(frame: CGRect, style: UITableView.Style, viewModel: CollectionViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame, style: style)
        
        separatorStyle = .none
        backgroundColor = .white
        showsVerticalScrollIndicator = false
        
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        register(
            HorizontalListCollectionCell.self, forCellReuseIdentifier: String(describing: HorizontalListCollectionCell.self)
        )
        
        diffableDataSource = UITableViewDiffableDataSource(
            tableView: self,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                return itemIdentifier
            }
        )
        
        snapshot.appendSections([.horizontalList])
        
        guard let collection = viewModel.listCollection as? [HorizontalListCollectionCell], let diffableDataSource = diffableDataSource else { return }
        
        snapshot.appendItems(collection, toSection: .horizontalList)
        diffableDataSource.apply(snapshot)
    }
}

extension HorizontalListCollection: UpdateCellManagerDelegate {
    func updateNumber() {
        guard let viewModel = viewModel as? HorizontalListCollectionViewModel else { return }
        viewModel.updateCollection()
    }
}
