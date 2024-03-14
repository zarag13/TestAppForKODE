//
//  CreaterURL.swift
//  TestAppForKODE
//
//  Created by Kirill on 12.03.2024.
//

import Foundation


//MARK: - Protocol Create URL
protocol CreaterURLProtocol {
    func eployeeListGetURL(completion: @escaping (Result<URL, ErrorForNetworkManager>) -> Void)
    func employeeAvatarImage(url: String, completion: @escaping (Result<URL, ErrorForNetworkManager>) -> Void)
}


//MARK: - Class Create URL with funcs
class CreaterURL: CreaterURLProtocol {
    
    //MARK: - create url for download image
    func employeeAvatarImage(url: String, completion: @escaping (Result<URL, ErrorForNetworkManager>) -> Void) {
        let strURL = url
        guard let url = URL(string: strURL) else {
            completion(.failure(.createURLFromString))
            return
        }
        completion(.success(url))
    }
    
    
    //MARK: - create url for download json
    func eployeeListGetURL(completion: @escaping (Result<URL, ErrorForNetworkManager>) -> Void) {
        let strURL = "https://stoplight.io/mocks/kode-api/trainee-test/331141861/users"
        guard let url = URL(string: strURL) else {
            completion(.failure(.createURLFromString))
            return
        }
        completion(.success(url))
    }
}
