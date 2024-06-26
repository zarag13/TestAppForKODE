//
//  CreaterRequest.swift
//  TestAppForKODE
//
//  Created by Kirill on 12.03.2024.
//

import Foundation


//MARK: - Enum == Response server status (200 or 500)
enum ResultState {
    case code200
    case code500
}

//MARK: - Protocol create Request
protocol CreaterRequestProtocol {
    func getRequestEmployeeeList(state: ResultState, completion: @escaping (Result<URLRequest, ErrorForNetworkManager>) -> Void)
    func getRequestForDownloadAvatar(urL: String, completion: @escaping (Result<URLRequest, ErrorForNetworkManager>) -> Void)
}


//MARK: - Calss create Request
final class CreaterRequest: CreaterRequestProtocol {
    
    //MARK: - required class URL
    let url: CreaterURLProtocol
    var request: URLRequest?
    
    init(url: CreaterURLProtocol) {
        self.url = url
    }
    
    //MARK: - create Request for download JSON (settings + state(200 or 500)
    func getRequestEmployeeeList(state: ResultState, completion: @escaping (Result<URLRequest, ErrorForNetworkManager>) -> Void) {
        
        url.eployeeListGetURL { [weak self] result in
            guard let strSelf = self else { return }
            switch result {
            case .success(let url):
                strSelf.request = URLRequest(url: url)
                strSelf.request?.addValue("application/json", forHTTPHeaderField: "Content-Type")
                switch state {
                case .code200:
                    strSelf.request?.addValue("code=200, example=success", forHTTPHeaderField: "Prefer")
                case .code500:
                    strSelf.request?.addValue("code=500, example=error-500", forHTTPHeaderField: "Prefer")
                }
                strSelf.request?.httpMethod = "GET"
                
                guard let request = strSelf.request else {
                    completion(.failure(.createRequest))
                    return
                }
                completion(.success(request))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    
    //MARK: - create Request for download ImageData (settings)
    func getRequestForDownloadAvatar(urL: String, completion: @escaping (Result<URLRequest, ErrorForNetworkManager>) -> Void) {
        url.employeeAvatarImage(url: urL) { [weak self] result in
            guard let strSelf = self else { return }
            switch result {
            case .success(let url):
                strSelf.request = URLRequest(url: url)
                strSelf.request?.httpMethod = "GET"
                
                guard let request = strSelf.request else {
                    completion(.failure(.createRequest))
                    return
                }
                completion(.success(request))
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
