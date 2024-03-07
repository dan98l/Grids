//
//  VerticalListCollection.swift
//  Numbers
//
//  Created by Daniil MacBook Pro on 06.03.2024.
//

import UIKit

final class VerticalListCollection: UIViewController {
    
    private var viewModel: CollectionViewModel?
    private var collectionView: UICollectionView?
    private var diffableDataSource: UICollectionViewDiffableDataSource<Section, HorizontalListCollection>?
    
    func setupVerticalListCollection(viewModel: CollectionViewModel) {
        self.viewModel = viewModel
        
        setupCollectionView()
        setupDiffableDataSource()
        setupDiffableDataSourceSnapshot()
    }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(
            frame: view.frame, 
            collectionViewLayout: UICollectionViewCompositionalLayout(sectionProvider: sectionProvider())
        )
        
        collectionView?.register(
            VerticalListCollectionCell.self,
            forCellWithReuseIdentifier: String(describing: VerticalListCollectionCell.self)
        )
        
        guard let collectionView = collectionView else { return }
        view.addSubview(collectionView)
        
        collectionView.delegate = self
    }
    
    private func setupDiffableDataSource() {
        guard let collectionView = collectionView else { return }
        diffableDataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, itemIdentifier in
            
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: String(describing: VerticalListCollectionCell.self),
                for: indexPath
            ) as? VerticalListCollectionCell else { fatalError("Cannot create the cell") }
            
            cell.setup(itemIdentifier)
            return cell
        })
    }
    
    private func setupDiffableDataSourceSnapshot() {
        guard let viewModel = viewModel, let diffableDataSource = diffableDataSource, let collection = viewModel.listCollection as? [HorizontalListCollection] else { return }
        
        var snaphot = NSDiffableDataSourceSnapshot<Section, HorizontalListCollection>()
        snaphot.appendSections([.verticalList])
        snaphot.appendItems(collection, toSection: .verticalList)
        
        diffableDataSource.apply(snaphot)
    }
    
    private func sectionProvider() -> UICollectionViewCompositionalLayoutSectionProvider {
        let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = {
            (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            let item = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(
                    widthDimension: .absolute(60.0),
                    heightDimension: .fractionalHeight(1.0)
                )
            )
            
            let section = NSCollectionLayoutSection(
                group: NSCollectionLayoutGroup.vertical(
                    layoutSize: NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(0.15), 
                    heightDimension: .fractionalHeight(1.0)
                ), subitems: [item])
            )
            
            section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
            return section
        }
        
        return sectionProvider
    }
}

extension VerticalListCollection: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel as? VerticalListCollectionViewModel else { return }
        
        viewModel.willDisplayCell(index: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let viewModel = viewModel as? VerticalListCollectionViewModel else { return }
        
        viewModel.didEndDisplaying(index: indexPath.row)
    }
}
