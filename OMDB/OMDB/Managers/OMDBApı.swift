//
//  OMDBApı.swift
//  OMDB
//
//  Created by Halit Baskurt on 22.07.2023.
//

import Foundation

struct OMDBAPI {
    
    enum OMDBAPIError: Error {
        case invalidURL
        case requestFailed(Error)
        case invalidData
        case decodingFailed(Error)
        case queryEncodingFailed
    }
    
    private init() { }
    
    private static let baseURL = "https://www.omdbapi.com"
    private static let apiKey = "f8048348"
    
    static func search(query: String, completion: @escaping (Result<SearchMovie, OMDBAPIError>) -> Void) {
        guard let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
            completion(.failure(.queryEncodingFailed))
            return
        }
        
        let endpoint = "/?s=\(encodedQuery)&apikey=\(apiKey)"
        performRequest(endpoint: endpoint, completion: completion)
    }
    
    private static func performRequest<T: Decodable>(endpoint: String, completion: @escaping (Result<T, OMDBAPIError>) -> Void) {
        guard let url = URL(string: baseURL + endpoint) else {
            completion(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.requestFailed(error)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let result = try decoder.decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingFailed(error)))
            }
        }
        task.resume()
    }
}
