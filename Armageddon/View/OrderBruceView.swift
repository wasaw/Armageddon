//
//  OrderBruceView.swift
//  Armageddon
//
//  Created by Александр Меренков on 4/23/22.
//

import UIKit

protocol OrderBruceDelegate: AnyObject {
    func orderBruceOnAsteroid()
}

class OrderBruceView: UICollectionReusableView {
    
//    MARK: - Properties
    
    weak var delegate: OrderBruceDelegate?
    
    private let orderBruceButton: UIButton = {
        let button = UIButton()
        button.setTitle("Заказать бригаду", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 19)
        button.backgroundColor = .buttonBackground
        button.layer.cornerRadius = 14
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        button.addTarget(self, action: #selector(handleOrderBruceButton), for: .touchUpInside)
        return button
    }()
    
//    MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureButton()
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Helpers
    
    private func configureButton() {
        addSubview(orderBruceButton)
        
        orderBruceButton.translatesAutoresizingMaskIntoConstraints = false
        orderBruceButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        orderBruceButton.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        orderBruceButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        orderBruceButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32).isActive = true
    }
    
//    MARK: - Selectors
    
    @objc private func handleOrderBruceButton() {
        delegate?.orderBruceOnAsteroid()
    }
}
