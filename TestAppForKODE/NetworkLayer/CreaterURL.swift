//
//  CreaterURL.swift
//  TestAppForKODE
//
//  Created by Kirill on 12.03.2024.
//

import Foundation

//MARK: - Error Create URL
enum ErrorURL: Error, CustomStringConvertible {
    case transform
    
    var description: String {
        switch self {
            
        case .transform:
            return "error converting url from string"
        }
    }
}

//MARK: - Protocol Create URL
protocol CreaterURLProtocol {
    func eployeeListGetURL(completion: @escaping (Result<URL, ErrorURL>) -> Void)
    func employeeAvatarImage(url: String, completion: @escaping (Result<URL, ErrorURL>) -> Void)
}


//MARK: - Class Create URL with funcs
class CreaterURL: CreaterURLProtocol {
    
    //MARK: - create url for download image
    func employeeAvatarImage(url: String, completion: @escaping (Result<URL, ErrorURL>) -> Void) {
        let strURL = url
        guard let url = URL(string: strURL) else {
            completion(.failure(.transform))
            return
        }
        completion(.success(url))
    }
    
    
    //MARK: - create url for download json
    func eployeeListGetURL(completion: @escaping (Result<URL, ErrorURL>) -> Void) {
        let strURL = "https://stoplight.io/mocks/kode-api/trainee-test/331141861/users"
        guard let url = URL(string: strURL) else {
            completion(.failure(.transform))
            return
        }
        completion(.success(url))
    }
}
