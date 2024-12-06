//
//  APIAlamofire.swift
//  SuperheroRandomizerApp
//
//  Created by Nurken on 29.11.2024.
//

import Foundation
import Alamofire

class APIAlamofire{
    static let shared = APIAlamofire();
    private init(){}
    
    func fetchData(from url: String, completion: @escaping(Result<SuperHero, Error>) -> ()){
        AF.request(url)
            .validate()
            .response{ response in
                guard let data = response.data else{
                    if let error = response.error{
                        completion(.failure(error))
                    }
                    return
                }
                
                
                let decoder = JSONDecoder()
                guard let results = try? decoder.decode(SuperHero.self, from: data) else {
                    completion(.failure(URLError(.cannotDecodeContentData)))
                    return
                }
                
                
                completion(.success(results))

            }
        
    }
}
