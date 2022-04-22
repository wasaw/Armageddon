//
//  FilterForm.swift
//  Armageddon
//
//  Created by Александр Меренков on 4/21/22.
//

import UIKit

protocol FilterFormDelegate: AnyObject {
    func changeDangerousVisible(value: Bool)
    func changeUnit(unit: Int)
}

class FilterForm: UIView {
    
//    MARK: - Properties
    
    weak var delegate: FilterFormDelegate?
    
    private let unitSwitcher: UISegmentedControl = {
        let sg = UISegmentedControl(items: ["км", "л.орб."])
        sg.setTitleTextAttributes([.font : UIFont(name: "SFProText-Regular", size: 13) ?? UIFont.systemFont(ofSize: 13) ], for: .normal)
        sg.addTarget(self, action: #selector(handleUnitSwitcher), for: .valueChanged)
        return sg
    }()
    
    private let unitLabel: UILabel = {
        let label = UILabel()
        label.text = "Ед. изм. расстояний"
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        return label
    }()
    
    private let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private let dangerousSwitch: UISwitch = {
        let sw = UISwitch()
        sw.addTarget(self, action: #selector(handleDangerousSwitch), for: .valueChanged)
        return sw
    }()
    
    private let dangerousLabel: UILabel = {
        let label = UILabel()
        label.text = "Показывать толко опасные"
        label.font = UIFont(name: "SFProText-Regular", size: 17)
        return label
    }()
    
//    MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 10
        
        configureUnitSwitcher()
        configureUnitLabel()
        configureLineView()
        configureDangerousSwitch()
        configureDangerousLabel()
        
        backgroundColor = .formBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    MARK: - Helpers
    
    private func configureUnitSwitcher() {
        addSubview(unitSwitcher)
                
        unitSwitcher.translatesAutoresizingMaskIntoConstraints = false
        unitSwitcher.rightAnchor.constraint(equalTo: rightAnchor, constant: -7).isActive = true
        unitSwitcher.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        unitSwitcher.widthAnchor.constraint(equalToConstant: 113).isActive = true
        unitSwitcher.heightAnchor.constraint(equalToConstant: 29).isActive = true
    }
    
    private func configureUnitLabel() {
        addSubview(unitLabel)
        
        unitLabel.translatesAutoresizingMaskIntoConstraints = false
        unitLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        unitLabel.topAnchor.constraint(equalTo: topAnchor, constant: 11).isActive = true
        unitLabel.rightAnchor.constraint(equalTo: unitSwitcher.leftAnchor, constant: 48).isActive = true
        unitLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
    private func configureLineView() {
        addSubview(lineView)
        
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16).isActive = true
        lineView.topAnchor.constraint(equalTo: topAnchor, constant: 43.5).isActive = true
        lineView.rightAnchor.constraint(equalTo: rightAnchor, constant: -16).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    private func configureDangerousSwitch() {
        addSubview(dangerousSwitch)
        
        dangerousSwitch.translatesAutoresizingMaskIntoConstraints = false
        dangerousSwitch.rightAnchor.constraint(equalTo: rightAnchor, constant: -17).isActive = true
        dangerousSwitch.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -7).isActive = true
        dangerousSwitch.heightAnchor.constraint(equalToConstant: 30).isActive = true
        dangerousSwitch.widthAnchor.constraint(equalToConstant: 51).isActive = true
    }
    
    private func configureDangerousLabel() {
        addSubview(dangerousLabel)
        
        dangerousLabel.translatesAutoresizingMaskIntoConstraints = false
        dangerousLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15).isActive = true
        dangerousLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11).isActive = true
        dangerousLabel.rightAnchor.constraint(equalTo: dangerousSwitch.leftAnchor, constant: -35).isActive = true
        dangerousLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
    }
    
//    MARK: - Selectors
    
    @objc private func handleDangerousSwitch(dangerousSwitch: UISwitch) {
        delegate?.changeDangerousVisible(value: dangerousSwitch.isOn)
    }
    
    @objc private func handleUnitSwitcher(unitSwitcher: UISegmentedControl) {
        delegate?.changeUnit(unit: unitSwitcher.selectedSegmentIndex)
    }
}
