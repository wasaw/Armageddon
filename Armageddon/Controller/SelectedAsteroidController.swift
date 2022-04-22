//
//  SelectedAsteroidController.swift
//  Armageddon
//
//  Created by Александр Меренков on 4/22/22.
//

import UIKit

class SelectedAsteroidController: UIViewController {
    
//    MARK: - Properties
    
    private var collectionView: UICollectionView?
    private let reuseIdentifire = "ArmageddonCell"
    private let asteroid: AsteroidInformation
    
//    MARK: - Lifecycle
    
    init(asteroid: AsteroidInformation) {
        self.asteroid = asteroid
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Астероид"
        tabBarController?.tabBar.isTranslucent = false
        tabBarController?.tabBar.backgroundColor = .navigationBackground
        
        configureCollectionView()
        
        view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .navigationBackground

            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.compactAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }
    
//    MARK: - Helpers
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(SelectedAsteroidCell.self, forCellWithReuseIdentifier: reuseIdentifire)
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

//  MARK: - Extensions

extension SelectedAsteroidController: UICollectionViewDelegate {
    
}

extension SelectedAsteroidController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifire, for: indexPath) as? SelectedAsteroidCell else { return UICollectionViewCell() }
        cell.asteroid = asteroid
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
}

extension SelectedAsteroidController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 340, height: 308)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 19.5, left: 16, bottom: 43.5, right: 19)
    }
}
