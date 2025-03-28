//
//  HttpUtility.swift
//  CatFacts
//
//  Created by Amjad on 28/03/25.
//

import Foundation

final class HttpUtility {
    
    static let shared: HttpUtility = HttpUtility()
    
    private init() { }
    
    func loadData<T: Decodable>(for url: String) async throws -> T {
        
        guard let url = URL(string: url) else {
            throw HttpError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw HttpError.invalidResponse
        }
        
        print(data.printJSON())
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw HttpError.invalidData
        }
    }
}

extension Data {
    func printJSON() {
        if let JSONString = String(data: self, encoding: String.Encoding.utf8) {
            print(JSONString)
        }
    }
}
