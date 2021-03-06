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
    private var arrayAsteroidInformation = [AsteroidInformation]()
    private var filter = FilterInfornation()
    private var filteredArray = [AsteroidInformation]()
    private var isNothingVisible = false
    private let formatter = DateFormatter()
    private var lastRequestDate = Date()
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backButtonTitle = "Назад"
        
        configureNavigationController()
        configureCollectionView()
        
        let currentDate = Date()
        formatter.dateFormat = "yyyy-MM-dd"
        let requestCurrentDate = formatter.string(from: currentDate)
        
        loadAsteroidArray(requestDate: requestCurrentDate)

        view.backgroundColor = .navigationBackground
    }
    
//     MARK: - Helpers
    
    private func loadAsteroidArray(requestDate: String) {
        NetworkService.shared.loadInformation(requestDate: requestDate) { response in
            guard let selectedDateObject = response.near_earth_objects[requestDate] else { return }
            for object in selectedDateObject {
                let name = object.name.substring(from: "\\(", to: "\\)")
                
                self.formatter.dateFormat = "yyyy-MM-dd"
                let dateFromString = self.formatter.date(from: object.close_approach_data[0].close_approach_date)
                self.formatter.dateFormat = "dd LLLL yyyy"
                guard let dateFromString = dateFromString else { continue }
                let date = self.formatter.string(from: dateFromString)
                
                var distanceKilometers = object.close_approach_data[0].miss_distance.kilometers.components(separatedBy: ".")[0]
                distanceKilometers = String(distanceKilometers.reversed())
                distanceKilometers = distanceKilometers.separated()
                distanceKilometers = String(distanceKilometers.reversed())
                
                var distanceLunar = object.close_approach_data[0].miss_distance.lunar.components(separatedBy: ".")[0]
                distanceLunar = String(distanceLunar.reversed())
                distanceLunar = distanceLunar.separated()
                distanceLunar = String(distanceLunar.reversed())
                
                var relativeVelocity = object.close_approach_data[0].relative_velocity.kilometers_per_second.components(separatedBy: ".")[0]
                relativeVelocity = String(distanceLunar.reversed())
                relativeVelocity = distanceLunar.separated()
                relativeVelocity = String(distanceLunar.reversed())
                
                let asteroid = AsteroidInformation(name: name, estimatedDiameter: object.estimated_diameter.kilometers.diameter,
                                                  hazardous: object.is_potentially_hazardous_asteroid,
                                                  data: date,
                                                  distanceKilometers: distanceKilometers,
                                                  distanceLunar: distanceLunar,
                                                  relativeVelocity: relativeVelocity,
                                                  orbitBody: object.close_approach_data[0].orbiting_body)
                self.arrayAsteroidInformation.append(asteroid)
            }
            self.collectionView?.reloadData()
        }
    }
    
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
    
    private func filterAsteroid() {
        var i = 0
        for item in arrayAsteroidInformation {
            if filter.isVisibleOnlyDangerous && item.isPotentiallyHazardous {
                filteredArray.append(item)
            }
            arrayAsteroidInformation[i].unitMeasure = filter.unitMeasure
            i += 1
        }
        if filter.isVisibleOnlyDangerous && filteredArray.isEmpty {
            isNothingVisible = true
        }
        self.collectionView?.reloadData()
    }
    
    private func updateAsteroidInformation() {
        guard let modifiedDate = Calendar.current.date(byAdding: .day, value: +1, to: lastRequestDate) else { return }
        lastRequestDate = modifiedDate
        formatter.dateFormat = "yyyy-MM-dd"
        let requestDate = formatter.string(from: lastRequestDate)
        loadAsteroidArray(requestDate: requestDate)
        
        self.collectionView?.reloadData()
    }
    
//    MARK: - Selectors
    
    @objc private func handleRightButton() {
        let vc = FilterController()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - Extensions

extension ArmageddonController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var vc = SelectedAsteroidController(asteroid: arrayAsteroidInformation[indexPath.row])
        if !filteredArray.isEmpty {
            vc = SelectedAsteroidController(asteroid: filteredArray[indexPath.row])
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == collectionView.numberOfItems(inSection: indexPath.section) - 1 {
            updateAsteroidInformation()
        }
    }
}

extension ArmageddonController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifire, for: indexPath) as? ArmageddonCell else { return UICollectionViewCell() }
        if !arrayAsteroidInformation.isEmpty {
            if !filteredArray.isEmpty {
                cell.asteroid = filteredArray[indexPath.row]
                cell.delegate = self
            } else {
                cell.asteroid = arrayAsteroidInformation[indexPath.row]
                cell.delegate = self
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if !arrayAsteroidInformation.isEmpty {
            if !filteredArray.isEmpty {
                return filteredArray.count
            }
            if isNothingVisible {
                return 0
            }
            return arrayAsteroidInformation.count
        }
        return 0
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

extension ArmageddonController: ApplyFilterDelegate {
    func applyFilter(filterDelegate: FilterInfornation) {
        filter = filterDelegate
        isNothingVisible = false
        filteredArray = []
        filterAsteroid()
    }
}

extension ArmageddonController: SaveAsteroidDelegate {
    func saveAsteroid(asteroid: AsteroidInformation) {
        DispatchQueue.main.async {
            DatabaseService.shared.saveAsteroid(asteroid: asteroid)
        }
    }
}
