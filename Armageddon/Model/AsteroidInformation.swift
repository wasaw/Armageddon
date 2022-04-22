//
//  AsteroidInformation.swift
//  Armageddon
//
//  Created by Александр Меренков on 4/20/22.
//

import Foundation

enum UnitMeasure {
    case kilometers
    case lunar
}

struct AsteridInformation {
    let name: String
    let estimatedDiameter: Double
    let isPotentiallyHazardous: Bool
    let closeApproachData: String
    let distanceKilometers: String
    let distanceLunar: String
    var unitMeasure: UnitMeasure = .kilometers
    
    init(name: String, estimatedDiameter: Double, hazardous: Bool, data: String, distanceKilometers: String, distanceLunar: String) {
        self.name = name
        self.estimatedDiameter = estimatedDiameter
        self.isPotentiallyHazardous = hazardous
        self.closeApproachData = data
        self.distanceKilometers = distanceKilometers
        self.distanceLunar = distanceLunar
    }
}
