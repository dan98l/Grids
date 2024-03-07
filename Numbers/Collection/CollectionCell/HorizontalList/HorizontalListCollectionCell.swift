//
//  HorizontalListCollectionCell.swift
//  Numbers
//
//  Created by Daniil MacBook Pro on 06.03.2024.
//

import UIKit

final class HorizontalListCollectionCell: UITableViewCell {
    private var randomNumberLabel: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLabel()
        selectionStyle = .none
        layer.cornerRadius = 8
        layer.borderWidth = 0.5
        backgroundColor = .white
        layer.borderColor = UIColor.black.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateNumber() {
        randomNumberLabel.text = "\(Int.random(in: 10...50))"
    }
    
    private func setupLabel() {
        randomNumberLabel.textColor = .black
        randomNumberLabel.textAlignment = .center
        randomNumberLabel.text = "\(Int.random(in: 10...50))"
        randomNumberLabel.frame = CGRect(origin: .zero, size: CGSize(width: 50.0, height: frame.height))
        addSubview(randomNumberLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        })
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.transform = .identity
        })
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut, animations: {
            self.transform = .identity
        })
    }
}
