//
//  BruceAsteroid.swift
//  Armageddon
//
//  Created by Александр Меренков on 4/23/22.
//

struct BruceAsteroid {
    let name: String
    let isPotentiallyHazardous: Bool
    let closeApproachData: String
    var arriveBrigade = false
    
    init(name: String, date: String, isHazardous: Bool) {
        self.name = name
        self.isPotentiallyHazardous = isHazardous
        self.closeApproachData = date
    }
}
