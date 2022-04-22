//
//  FilterController.swift
//  Armageddon
//
//  Created by Александр Меренков on 4/21/22.
//

import UIKit

protocol ApplyFilterDelegate: AnyObject {
    func applyFilter(filterDelegate: FilterInfornation)
}

class FilterController: UIViewController {
    
//    MARK: - Properties
    
    weak var delegate: ApplyFilterDelegate?
    
    private let formView = FilterForm()
    private var filter = FilterInfornation()
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formView.delegate = self
        
        navigationItem.title = "Фильтр"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Применить", style: .plain, target: self, action: #selector(handleRightButton))
        tabBarController?.tabBar.isTranslucent = false
        tabBarController?.tabBar.backgroundColor = .navigationBackground
        configureForm()
        
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
    
    private func configureForm() {
        view.addSubview(formView)
        
        formView.translatesAutoresizingMaskIntoConstraints = false
        formView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        formView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 23).isActive = true
        formView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        formView.heightAnchor.constraint(equalToConstant: 88).isActive = true
    }
    
//    MARK: - Selectors
    
    @objc private func handleRightButton() {
        delegate?.applyFilter(filterDelegate: filter)
        navigationController?.popToRootViewController(animated: true)
    }
}

//  MARK: - Extensions

extension FilterController: FilterFormDelegate {
    func changeUnit(unit: Int) {
        unit == 0 ? (filter.unitMeasure = .kilometers) : (filter.unitMeasure = .lunar)
    }
    
    func changeDangerousVisible(value: Bool) {
        filter.isVisibleOnlyDangerous = value
    }
}
