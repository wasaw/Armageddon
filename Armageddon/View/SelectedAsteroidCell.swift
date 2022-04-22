//
//  SelectedAsteroidCell.swift
//  Armageddon
//
//  Created by Александр Меренков on 4/22/22.
//

import UIKit

class SelectedAsteroidCell: UICollectionViewCell {
    
//    MARK: - Properties
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        return label
    }()
    
    private let diameterLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 16)
        return label
    }()
    
    private let arrivalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 16)
        return label
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 16)
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 16)
        return label
    }()
    
    private let relativeVelocity: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 16)
        return label
    }()
    
    private let orbitingBody: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 16)
        return label
    }()
    
    private let gradiendLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.safeAsteroidStartGradient.cgColor, UIColor.safeAsteroidFinishGradient.cgColor]
        gradient.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        return gradient
    }()
    
    var asteroid: AsteroidInformation? {
        didSet {
            setInformation()
        }
    }
    
//    MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
        shadow()
        
        layer.insertSublayer(gradiendLayer, at: 0)
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradiendLayer.frame = bounds
    }
    
//    MARK: - Helpers
    
    private func configureCell() {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, diameterLabel, arrivalLabel, distanceLabel, scoreLabel, relativeVelocity, orbitingBody])
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
    
    private func setInformation() {
        guard let asteroid = asteroid else { return }
        nameLabel.text = asteroid.name
        diameterLabel.text = "Диаметр: " + String(format: "%.2f", asteroid.estimatedDiameter) + " км"
        arrivalLabel.text = "Подлетает " + asteroid.closeApproachData
        distanceLabel.text = "на расстояние " + asteroid.distanceKilometers + " км"
        if asteroid.isPotentiallyHazardous {
            scoreLabel.text = "Оценка: опасен"
            gradiendLayer.colors = [UIColor.dangerousAsteroidStartGradient.cgColor, UIColor.dangerousAsteroidFinishGradient.cgColor]
        } else {
            scoreLabel.text = "Оценка: не опасен"
            gradiendLayer.colors = [UIColor.safeAsteroidStartGradient.cgColor, UIColor.safeAsteroidFinishGradient.cgColor]
        }
        relativeVelocity.text = "Относительная скорость: " + asteroid.relativeVelocity + " км/сек"
        orbitingBody.text = "Орбита: " + asteroid.orbitingBody
    }
    
    private func shadow() {
        layer.cornerRadius = 10
        layer.masksToBounds = false
        clipsToBounds = false
        layer.shadowColor = UIColor.cellShadowBackground.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.097
        layer.shadowRadius = 10
    }
}
