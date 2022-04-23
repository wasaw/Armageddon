//
//  BruceCell.swift
//  Armageddon
//
//  Created by Александр Меренков on 4/23/22.
//

import UIKit

protocol DeleteAsteroidDelegate: AnyObject {
    func deleteAsteroid(asteroid: BruceAsteroid, index: Int)
}

class BruceCell: UICollectionViewCell {
    
//    MARK: - Properties
    
    weak var delegate: DeleteAsteroidDelegate?
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 27)
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 16)
        return label
    }()
    
    let arrivalBruceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 16)
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return label
    }()
    
    private let gradiendLayer: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor.safeAsteroidStartGradient.cgColor, UIColor.safeAsteroidFinishGradient.cgColor]
        gradient.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        return gradient
    }()
    
    private let deleteButon: UIButton = {
        let button = UIButton()
        button.setTitle("Отменить уничтожение", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 19)
        button.backgroundColor = .buttonBackground
        button.layer.cornerRadius = 14
        button.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
        button.addTarget(self, action: #selector(handleDeleteButton), for: .touchUpInside)
        return button
    }()
    
    var asteroid: BruceAsteroid? {
        didSet {
            setInformation()
        }
    }
    
    var index = 0
    
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
        let stackView = UIStackView(arrangedSubviews: [nameLabel, dateLabel, arrivalBruceLabel, deleteButon])
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
        dateLabel.text = asteroid.closeApproachData
        if asteroid.isPotentiallyHazardous {
            gradiendLayer.colors = [UIColor.dangerousAsteroidStartGradient.cgColor, UIColor.dangerousAsteroidFinishGradient.cgColor]
        } else {
            gradiendLayer.colors = [UIColor.safeAsteroidStartGradient.cgColor, UIColor.safeAsteroidFinishGradient.cgColor]
        }
        if asteroid.arriveBrigade {
            arrivalBruceLabel.text = "Бригада доставлена"
        } else {
            arrivalBruceLabel.text = "Бригада ожидает отправки"
        }
        arrivalBruceLabel.isHidden = true
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
    
//    MARK: - Seleclorts
    
    @objc private func handleDeleteButton() {
        guard let asteroid = asteroid else { return }
        delegate?.deleteAsteroid(asteroid: asteroid, index: index)
    }
}
