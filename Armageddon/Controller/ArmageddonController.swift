//
//  ArmageddonController.swift
//  Armageddon
//
//  Created by Александр Меренков on 4/18/22.
//

import UIKit

class ArmageddonController: UIViewController {
    
//    MARK: - Properties
    
    private var collectionView: UICollectionView?
    private let reuseIdentifire = "ArmageddonCell"
    private var arrayAsteroidInformation = [AsteridInformation]()
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationController()
        configureCollectionView()
        
        NetworkService.shared.loadInformation { response in
            guard let selectedDateObject = response.near_earth_objects["2022-01-07"] else { return }
            let formatter = DateFormatter()
            for object in selectedDateObject {
                let name = object.name.substring(from: "\\(", to: "\\)")
                
                formatter.dateFormat = "yyyy-mm-dd"
                let dateFromString = formatter.date(from: object.close_approach_data[0].close_approach_date)
                formatter.dateFormat = "dd LLLL yyyy"
                guard let dateFromString = dateFromString else { continue }
                let date = formatter.string(from: dateFromString)
                
                var distance = object.close_approach_data[0].miss_distance.kilometers.components(separatedBy: ".")[0]
                distance = String(distance.reversed())
                distance = distance.separated()
                distance = String(distance.reversed())
                
                let asteroid = AsteridInformation(name: name, estimatedDiameter: object.estimated_diameter.meters.diameter,
                                                  hazardous: object.is_potentially_hazardous_asteroid,
                                                  data: date,
                                                  distance: distance)
                self.arrayAsteroidInformation.append(asteroid)
            }
            self.collectionView?.reloadData()
        }
        
        view.backgroundColor = .navigationBackground
    }
    
//     MARK: - Helpers
    
    private func configureNavigationController() {
        navigationController?.navigationBar.backgroundColor = .navigationBackground
        navigationItem.title = "Армагеддон 2022"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "RightButton"), style: .done, target: self, action: #selector(handleRightButton))
    }
    
    private func configureCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        guard let collectionView = collectionView else { return }
        collectionView.register(ArmageddonCell.self, forCellWithReuseIdentifier: reuseIdentifire)
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
    
//    MARK: - Selectors
    
    @objc private func handleRightButton() {
        print("DEBUG: print right button")
    }
}

// MARK: - Extensions

extension ArmageddonController: UICollectionViewDelegate {
    
}

extension ArmageddonController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifire, for: indexPath) as? ArmageddonCell else { return UICollectionViewCell() }
        if !arrayAsteroidInformation.isEmpty {
            cell.asteroid = arrayAsteroidInformation[indexPath.row]
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !arrayAsteroidInformation.isEmpty {
            return arrayAsteroidInformation.count
        }
        return 1
    }
    
}

extension ArmageddonController: UICollectionViewDelegateFlowLayout {
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
