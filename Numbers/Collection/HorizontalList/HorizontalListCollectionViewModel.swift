//
//  HorizontalListCollectionViewModel.swift
//  Numbers
//
//  Created by Daniil MacBook Pro on 06.03.2024.
//

import UIKit

final class HorizontalListCollectionViewModel: CollectionViewModel {
    private(set) var listCollection: [UIView] = []
    
    init() {
        for _ in 0...Int.random(in: 10...50) {
            listCollection.append(
                HorizontalListCollectionCell(
                    style: .default, reuseIdentifier: String(describing: HorizontalListCollectionCell.self)
                )
            )
        }
    }
    
    func updateCollection() {
        guard let cell = listCollection[Int.random(in: 0...listCollection.count - 1)] as? HorizontalListCollectionCell else { return }
        
        cell.updateNumber()
    }
}
