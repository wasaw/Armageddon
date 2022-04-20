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
    
    private let requestUrl = "https://api.nasa.gov/neo/rest/v1/feed?start_date=2022-01-01&end_date=2022-01-08&api_key=G4ZLBcteOhfBhZ1LDnCeQHJHGWcJGCz2OKQ2XPdU"
    
//    MARK: - Helpers
    
    func loadInformation(complition: @escaping ((JsonResponse)) -> Void) {
        AF.request(requestUrl).responseDecodable(of: JsonResponse.self) { response in
            guard let result = response.value else { return }
            complition(result)
        }
    }
}
