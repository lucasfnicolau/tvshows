//
//  NetworkError.swift
//  TVShows
//
//  Created by Lucas Fernandez Nicolau on 08/01/22.
//

import Foundation

enum NetworkError: String, Error {
    case noDataReceived = "The request did not generate any data. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case invalidURL = "The URL is invalid. Please try again."
    case invalidResponse = "Invalid response from the server. Please try again."
    case undefinedError = "Undefined error. Please try again."
}
