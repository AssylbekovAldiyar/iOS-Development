//
//  API.swift
//  SuperheroRandomizerApp
//
//  Created by Nurken on 28.11.2024.
//

import Foundation


func fetchData(from urlString: String, completion: @escaping(SuperHero?, Error?) -> Void){
    
   guard let url = URL(string: urlString) else{
        print("Error in the url")
        return
    }
    
    let request = URLRequest(url: url)
    
    let task = URLSession.shared.dataTask(with: request){
        data, response, error in
            
        if let error = error {
            completion(nil, error)
            return
        }
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200{
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let result = try decoder.decode(SuperHero.self, from: data)
                    completion(result, nil)
                }
                catch{
                    completion(nil, error)
                }
            }
        }else{
            completion(nil, error)
        }
    }
    
    task.resume()
}
