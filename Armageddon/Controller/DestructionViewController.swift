//
//  DestructionViewController.swift
//  Armageddon
//
//  Created by Александр Меренков on 4/18/22.
//

import UIKit

class DestructionViewController: UIViewController {
    
//    MARK: - Properties
    
    private var collectionView: UICollectionView?
    private let reuseIdentifire = "ArmageddonCell"
    private var bruceAsteroid: [BruceAsteroid]?
    private let reuseIdentifireFooter = "Footer"
    private var isBruceOrder = false
    
//    MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadBruceAsteroid()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()

        navigationItem.title = "Ожидание бригады"
        
        loadBruceAsteroid()
        
        view.backgroundColor = .white
    }
    
//    MARK: - Helpers
    
    private func loadBruceAsteroid() {
        DispatchQueue.main.async {
            self.bruceAsteroid = DatabaseService.shared.getAsteroidInformation()
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd LLLL yyyy"
            let currentDateString = formatter.string(from: currentDate)

            var i = 0
            if !(self.bruceAsteroid?.isEmpty ?? true) {
                while i < self.bruceAsteroid!.count {
                    if currentDateString == self.bruceAsteroid![i].closeApproachData {
                        self.bruceAsteroid![i].arriveBrigade = true
                    }
                    i += 1
                }
            }
            
            
            self.collectionView?.reloadData()
        }
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(BruceCell.self, forCellWithReuseIdentifier: reuseIdentifire)
        collectionView.register(OrderBruceView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: reuseIdentifireFooter)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        collectionView.backgroundColor = .white
    }
}

//  MARK: - Extensions

extension DestructionViewController: UICollectionViewDelegate {
    
}

extension DestructionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifire, for: indexPath) as? BruceCell else { return UICollectionViewCell() }
        guard let bruceAsteroid = bruceAsteroid else { return UICollectionViewCell() }
        cell.asteroid = bruceAsteroid[indexPath.row]
        cell.delegate = self
        cell.index = indexPath.row
        if isBruceOrder {
            cell.arrivalBruceLabel.isHidden = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let bruceAsteroid = bruceAsteroid else { return 0 }
        return bruceAsteroid.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: reuseIdentifireFooter, for: indexPath) as! OrderBruceView
        footer.delegate = self
        return footer
    }
}

extension DestructionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 19.5, left: 16, bottom: 43.5, right: 19)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 70)
    }
}

extension DestructionViewController: DeleteAsteroidDelegate {
    func deleteAsteroid(asteroid: BruceAsteroid, index: Int) {
        DispatchQueue.main.async {
            DatabaseService.shared.deleteAsteroid(asteroid: asteroid)
            self.bruceAsteroid?.remove(at: index)
            self.collectionView?.reloadData()
        }
    }
}

extension DestructionViewController: OrderBruceDelegate {
    func orderBruceOnAsteroid() {
        isBruceOrder = true
        collectionView?.reloadData()
    }
}


