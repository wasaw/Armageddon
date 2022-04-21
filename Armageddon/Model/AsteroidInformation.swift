//
//  AsteroidInformation.swift
//  Armageddon
//
//  Created by Александр Меренков on 4/20/22.
//

import Foundation

struct AsteridInformation {
    let name: String
    let estimatedDiameter: Int
    let isPotentiallyHazardous: Bool
    let closeApproachData: String
    let distanse: String
    
    init(name: String, estimatedDiameter: Int, hazardous: Bool, data: String, distance: String) {
        self.name = name
        self.estimatedDiameter = estimatedDiameter
        self.isPotentiallyHazardous = hazardous
        self.closeApproachData = data
        self.distanse = distance
    }
}
