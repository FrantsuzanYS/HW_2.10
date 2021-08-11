//
//  NetworkManager.swift
//  HW_2.10
//
//  Created by emmisar on 11.08.2021.
//


import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from url: String?, with complition: @escaping(Result<NumberFact, Error>) -> Void) {
        guard let stringURL = url else { return }
        guard let url = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                print(error?.localizedDescription ?? "no descripption")
                return
            }
            
            do {
                let fact = try JSONDecoder().decode(NumberFact.self, from: data)
                DispatchQueue.main.async {
                    complition(.success(fact))
                }
            } catch let error {
                complition(.failure(error))
            }
        }.resume()
    }
    
}
