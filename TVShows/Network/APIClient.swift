//
//  APIClient.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import Foundation

struct APIClient: Networking {
    static let shared = APIClient()

    private init() {}

    func execute<T: Decodable>(_ requestProviding: URLRequestProviding,
                               completion: @escaping (Result<T, NetworkError>) -> Void) {

        let urlRequest = requestProviding.urlRequest

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completion(.failure(NetworkError.undefinedError))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noDataReceived))
                return
            }

            do {
                let decodedObject = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedObject))
            } catch {
                completion(.failure(NetworkError.invalidData))
            }
        }.resume()
    }
}
