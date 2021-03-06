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

enum AsteroidSize {
    case small
    case medium
    case big
}

struct AsteroidInformation {
    let name: String
    let estimatedDiameter: Double
    let isPotentiallyHazardous: Bool
    let closeApproachData: String
    let distanceKilometers: String
    let distanceLunar: String
    var unitMeasure: UnitMeasure = .kilometers
    var asteroidSize: AsteroidSize {
        switch estimatedDiameter {
        case ..<0.2:
            return .small
        case ..<1:
            return .medium
        default:
            return.big
        }
    }
    let relativeVelocity: String
    let orbitingBody: String
    
    init(name: String, estimatedDiameter: Double, hazardous: Bool, data: String, distanceKilometers: String, distanceLunar: String, relativeVelocity: String, orbitBody: String) {
        self.name = name
        self.estimatedDiameter = estimatedDiameter
        self.isPotentiallyHazardous = hazardous
        self.closeApproachData = data
        self.distanceKilometers = distanceKilometers
        self.distanceLunar = distanceLunar
        self.relativeVelocity = relativeVelocity
        self.orbitingBody = orbitBody
    }
}
