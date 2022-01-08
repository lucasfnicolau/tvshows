//
//  Networking.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import Foundation

protocol Networking {
    /// Execute an API request.
    /// - Parameters:
    ///   - requestProviding: A RequestProviding conforming object.
    ///   - completion: Closure to be executed when the operation is completed.
    func execute<T: Decodable>(_ requestProviding: URLRequestProviding,
                               completion: @escaping (Result<T, NetworkError>) -> Void)
}
