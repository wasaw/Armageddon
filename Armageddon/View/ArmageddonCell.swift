//
//  ArmageddonCell.swift
//  Armageddon
//
//  Created by Александр Меренков on 4/18/22.
//

import UIKit

class ArmageddonCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .gray
        layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
