//
//  VerticalListCollectionViewModel.swift
//  Numbers
//
//  Created by Daniil MacBook Pro on 06.03.2024.
//

import UIKit

final class VerticalListCollectionViewModel: CollectionViewModel {
    private(set) var listCollection: [UIView] = [HorizontalListCollection]()
    private let updateManager: UpdateManager = UpdateManager()
    
    init(size: CGSize) {
        for _ in 0...Int.random(in: 100...500) {
            listCollection.append(
                HorizontalListCollection(
                    frame: CGRect(
                        origin: .zero, size: CGSize(width: 60.0, height: size.height)
                    ).insetBy(dx: 1.0, dy: 0.0),
                    style: .plain, 
                    viewModel: HorizontalListCollectionViewModel()
                )
            )
        }
        
        guard let collection = listCollection as? [HorizontalListCollection] else { return }

        updateManager.start()
    }
    
    func willDisplayCell(index: Int) {
        guard let observer = listCollection[index] as? UpdateCellManagerDelegate else { return }
        updateManager.setObserver(index: index, observer: observer)
    }
    
    func didEndDisplaying(index: Int) {
        guard let observer = listCollection[index] as? UpdateCellManagerDelegate else { return }
        updateManager.removeObserver(index: index, observer: observer)
    }
}
