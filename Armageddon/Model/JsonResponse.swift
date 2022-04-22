//
//  Model.swift
//  Armageddon
//
//  Created by Александр Меренков on 4/19/22.
//

struct JsonResponse: Decodable {
    let element_count: Int
    let near_earth_objects: [String : [Asteroid]]
}

struct Asteroid: Decodable {
    let name: String
    let estimated_diameter: EstimatedDiameter
    let is_potentially_hazardous_asteroid: Bool
    let close_approach_data: [CloseApproachData]
}

struct EstimatedDiameter: Decodable {
    let kilometers: Measure
}

struct Measure: Decodable {
    let estimated_diameter_min: Double
    let estimated_diameter_max: Double
    var diameter: Double {
        return (estimated_diameter_max + estimated_diameter_min) / 2
    }
}

struct CloseApproachData: Decodable {
    let close_approach_date: String
    let close_approach_date_full: String
    let miss_distance: MissDistance
    let relative_velocity: RelativeVelocity
    let orbiting_body: String
}

struct MissDistance: Decodable {
    let kilometers: String
    let lunar: String
}

struct RelativeVelocity: Decodable {
    let kilometers_per_second: String
}
