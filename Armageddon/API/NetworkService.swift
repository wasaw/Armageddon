//
//  NetworkService.swift
//  Armageddon
//
//  Created by Александр Меренков on 4/19/22.
//

import Alamofire

class NetworkService {
    static let shared = NetworkService()
    
//    MARK: - Properties
    
    private let url = "https://api.nasa.gov/neo/rest/v1/feed?start_date="
    private let apiKey = "G4ZLBcteOhfBhZ1LDnCeQHJHGWcJGCz2OKQ2XPdU"
    
//    MARK: - Helpers
    
    func loadInformation(requestDate: String, complition: @escaping ((JsonResponse)) -> Void) {
        let requestUrl = url + requestDate + "&end_date=" + requestDate + "&api_key=" + apiKey
        AF.request(requestUrl).responseDecodable(of: JsonResponse.self) { response in
            guard let result = response.value else { return }
            complition(result)
        }
    }
}
