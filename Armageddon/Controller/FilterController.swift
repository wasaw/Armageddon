//
//  FilterController.swift
//  Armageddon
//
//  Created by Александр Меренков on 4/21/22.
//

import UIKit

class FilterController: UIViewController {
    
//    MARK: - Properties
    
    private let formView = FilterForm()
    
//    MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        navigationController?.popToRootViewController(animated: true)
    }
}
