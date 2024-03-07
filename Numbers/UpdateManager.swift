//
//  UpdateManager.swift
//  Numbers
//
//  Created by Daniil MacBook Pro on 06.03.2024.
//

import Foundation

protocol UpdateCellManagerDelegate {
    func updateNumber()
}

final class UpdateManager {
    private weak var timer: Timer?
    private var observers: [Int : UpdateCellManagerDelegate] = [:]
    
    func setObserver(index: Int, observer: UpdateCellManagerDelegate) {
        observers[index] = observer
    }
    
    func removeObserver(index: Int, observer: UpdateCellManagerDelegate) {
        observers[index] = nil
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { [weak self] timer in
            self?.observers.values.forEach({ $0.updateNumber() })
        })
    }
}
