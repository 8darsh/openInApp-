//
//  ApiManager.swift
//  openInAppAssignment
//
//  Created by Adarsh Singh on 20/05/24.
//

import Foundation

enum DataError:Error{
    case invalidResponse
    case invalidURL
    case invalidDecoding
    case network(Error?)
}

typealias Handler = (Result<linkModel, DataError>) -> Void

class ApiManager{
    
    static let shared = ApiManager()
    
    private init(){}
    
    func fetchLinks(completion: @escaping Handler){
        guard let url = URL(string: "https://api.inopenapp.com/api/v1/dashboardNew") else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCkW0ox8tbjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.network(error)))
                return
            }

            guard let response = response as? HTTPURLResponse, 
                    200...299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Response JSON: \(jsonString)")
            }

            do {
                let linkData = try JSONDecoder().decode(linkModel.self, from: data)
                completion(.success(linkData))
            } catch {
                completion(.failure(.invalidDecoding))
            }
        }.resume()
    }
}
