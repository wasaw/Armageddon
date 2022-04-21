//
//  ArmageddonCell.swift
//  Armageddon
//
//  Created by Александр Меренков on 4/18/22.
//

import UIKit

class ArmageddonCell: UICollectionViewCell {
    
//    MARK: - Properties
    
    private let asteroidView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let asteroidImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "SmallAsteroid")
        return iv
    }()
    
    private let asteroidNameLabel: UILabel = {
        let label = UILabel()
        label.text = "2021 FQ"
//        label.lineBreakMode = .byWordWrapping
        label.font = UIFont(name: "Helvetica Bold", size: 24)
        return label
    }()
    
    private let dinosaurImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "dino")
        return iv
    }()

    private let gradiendLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.safeAsteroidStartGradient.cgColor, UIColor.safeAsteroidFinishGradient.cgColor]
        gradient.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        return gradient
    }()
    
    private let asteroidInformationView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 163).isActive = true
        view.backgroundColor = .white
        return view
    }()
    
    private let diameterLabel: UILabel = {
        let label = UILabel()
        label.text = "Диаметр: 85 м"
        label.font = UIFont(name: "Helvetica", size: 16)
        return label
    }()
    
    private let arrivalLabel: UILabel = {
        let label = UILabel()
        label.text = "Подлетает 12 сентября 2022"
        label.font = UIFont(name: "Helvetica", size: 16)
        return label
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "на расстояние 7 235 024 км"
        label.font = UIFont(name: "Helvetica", size: 16)
        return label
    }()
    
    private let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "Оценка: не опасен"
        label.font = UIFont(name: "Helvetica", size: 16)
        return label
    }()
    
    private let destroyButton: UIButton = {
        let button = UIButton()
        button.setTitle("УНИЧТОЖИТЬ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont(name: "SFProText-Semibold", size: 13)
        button.backgroundColor = .buttonBackground
        button.layer.cornerRadius = 14
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        return button
    }()
    
    var asteroid: AsteridInformation? {
        didSet {
            setInformation()
        }
    }
        
//    MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureStackView()
        configureAsteroidView()
        configureAsteroidInformationView()
                
        asteroidView.layer.insertSublayer(gradiendLayer, at: 0)
        
        shadow()
        
        backgroundColor = .white
    }
    
    override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        gradiendLayer.frame = asteroidView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Helpers
    
    private func configureStackView() {
        let stackView = UIStackView(arrangedSubviews: [asteroidView, asteroidInformationView])
        stackView.axis = .vertical
        addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        stackView.layer.cornerRadius = 10
        stackView.layer.masksToBounds = true
    }
    
    private func configureAsteroidView() {
        asteroidView.addSubview(asteroidImageView)
        
        asteroidImageView.translatesAutoresizingMaskIntoConstraints = false
        asteroidImageView.leftAnchor.constraint(equalTo: asteroidView.leftAnchor, constant: 27).isActive = true
        asteroidImageView.topAnchor.constraint(equalTo: asteroidView.topAnchor, constant: 22).isActive = true
        asteroidImageView.widthAnchor.constraint(equalToConstant: 61).isActive = true
        asteroidImageView.heightAnchor.constraint(equalToConstant: 62).isActive = true
        
        asteroidView.addSubview(dinosaurImageView)
        
        dinosaurImageView.translatesAutoresizingMaskIntoConstraints = false
        dinosaurImageView.rightAnchor.constraint(equalTo: asteroidView.rightAnchor, constant: -12).isActive = true
        dinosaurImageView.bottomAnchor.constraint(equalTo: asteroidView.bottomAnchor).isActive = true
        dinosaurImageView.widthAnchor.constraint(equalToConstant: 35).isActive = true
        dinosaurImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        asteroidView.addSubview(asteroidNameLabel)
        
        asteroidNameLabel.translatesAutoresizingMaskIntoConstraints = false
        asteroidNameLabel.leftAnchor.constraint(equalTo: asteroidView.leftAnchor, constant: 16).isActive = true
        asteroidNameLabel.bottomAnchor.constraint(equalTo: asteroidView.bottomAnchor, constant: -8).isActive = true
        asteroidNameLabel.rightAnchor.constraint(equalTo: dinosaurImageView.leftAnchor, constant: -10).isActive = true
        asteroidNameLabel.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
    
    private func configureAsteroidInformationView() {
        let labelStackView = UIStackView(arrangedSubviews: [diameterLabel, arrivalLabel, distanceLabel])
        labelStackView.axis = .vertical
        labelStackView.distribution = .fillProportionally
        asteroidInformationView.addSubview(labelStackView)
        
        labelStackView.translatesAutoresizingMaskIntoConstraints = false
        labelStackView.leftAnchor.constraint(equalTo: asteroidInformationView.leftAnchor, constant: 16).isActive = true
        labelStackView.topAnchor.constraint(equalTo: asteroidInformationView.topAnchor, constant: 16).isActive = true
//        labelStackView.rightAnchor.constraint(equalTo: asteroidInformationView.rightAnchor, constant: -16).isActive = true
        labelStackView.widthAnchor.constraint(equalToConstant: 219).isActive = true
        labelStackView.heightAnchor.constraint(equalToConstant: 88).isActive = true
        
        asteroidInformationView.addSubview(scoreLabel)
        
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        scoreLabel.leftAnchor.constraint(equalTo: asteroidInformationView.leftAnchor, constant: 16).isActive = true
        scoreLabel.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 16).isActive = true
        scoreLabel.widthAnchor.constraint(equalToConstant: 141).isActive = true
        scoreLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        asteroidInformationView.addSubview(destroyButton)

        destroyButton.translatesAutoresizingMaskIntoConstraints = false
        destroyButton.leftAnchor.constraint(equalTo: scoreLabel.rightAnchor, constant: 46).isActive = true
        destroyButton.topAnchor.constraint(equalTo: labelStackView.bottomAnchor, constant: 15).isActive = true
        destroyButton.widthAnchor.constraint(equalToConstant: 121).isActive = true
        destroyButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
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
    
    private func setInformation() {
        guard let asteroid = asteroid else { return }
        asteroidNameLabel.text = asteroid.name
        diameterLabel.text = "Диаметр: " + String(asteroid.estimatedDiameter) + " m"
        arrivalLabel.text = "Подлетает " + asteroid.closeApproachData
        distanceLabel.text = "на расстояние " + asteroid.distanse + " км"
        if asteroid.isPotentiallyHazardous {
            scoreLabel.text = "Оценка: опасен"
            gradiendLayer.colors = [UIColor.dangerousAsteroidStartGradient.cgColor, UIColor.dangerousAsteroidFinishGradient.cgColor]
        }
    }
}
