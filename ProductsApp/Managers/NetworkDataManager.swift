//
//  NetworkDataManager.swift
//  ProductsApp
//
//  Created by Jorge Flores Carlos on 22/10/21.
//

import Foundation

class NetworkDataManager {
    static let instance = NetworkDataManager()
    
    func sendRequest<T: Codable>(witRequest request: URLRequest, completion: @escaping(Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(
            with: request) { data, response, error in
                if let error = error as NSError?, error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
                      completion(.failure(NetworkErrors.APIError.failedToGetData))
                }
                guard let data = data, error == nil else {
                    completion(.failure(NetworkErrors.APIError.failedToGetData))
                    return
                }
                do {
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(NetworkErrors.APIError.failedToGetData))
                }
            }.resume()
    }
    
    func get<T: Codable>(withUrl url: String, completion: @escaping(Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NetworkErrors.APIError.failedToGetData))
            return
        }
        let request = URLRequest(url: url)
        sendRequest(witRequest: request) { result in
            completion(result)
        }
    }
    
    func post<T: Codable>(withURL url: String, body: T, completion: @escaping(Result<T, Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(NetworkErrors.APIError.failedToGetData))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(body)
        sendRequest(witRequest: request) { result in
            completion(result)
        }
    }
}
