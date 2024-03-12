//
//  CreaterSession.swift
//  TestAppForKODE
//
//  Created by Kirill on 12.03.2024.
//

import Foundation

//MARK: - Enum Error create URLSession
enum ErrorSession: Error, CustomStringConvertible {
    case errorCreateConfigSession
    case errorCreateSession
    
    var description: String {
        switch self {
        case .errorCreateConfigSession:
            return "error create URLRequest"
        case .errorCreateSession:
            return "error create URLSession"
        }
    }
}

//MARK: - Protocol create URLSession
protocol CreaterSessionProtocol {
    func eployeeListGetSession(completion: @escaping (Result<URLSession, ErrorSession>) -> Void)
    func eployeeAvatarDownloadSession(url: String, completion: @escaping (Result<URLSession, ErrorSession>) -> Void)
}

//MARK: - Class create URLSession
final class CreaterSession: NSObject, CreaterSessionProtocol {
    
    //MARK: - required queue for work session delegate
    private let operationQueue = OperationQueue()
    
    var configurationSession: URLSessionConfiguration?
    var urlSession: URLSession?
    
    //MARK: - func create URLSession for download JSON
    func eployeeListGetSession(completion: @escaping (Result<URLSession, ErrorSession>) -> Void) {
        configurationSession = setupConfigSession(cahePolicy: .useProtocolCachePolicy)
        guard let config = configurationSession else {
            completion(.failure(.errorCreateConfigSession))
            return
        }
        
        urlSession = URLSession(configuration: config, delegate: self, delegateQueue: operationQueue)
        guard let session = urlSession else {
            completion(.failure(.errorCreateSession))
            return
        }
        completion(.success(session))
    }
    
    //MARK: - func create URLSession for download IMAGE
    func eployeeAvatarDownloadSession(url: String, completion: @escaping (Result<URLSession, ErrorSession>) -> Void) {
        configurationSession = setupConfigSession(cahePolicy: .returnCacheDataElseLoad)
        guard let config = configurationSession else {
            completion(.failure(.errorCreateConfigSession))
            return
        }
        
        urlSession = URLSession(configuration: config, delegate: self, delegateQueue: operationQueue)
        guard let session = urlSession else {
            completion(.failure(.errorCreateSession))
            return
        }
        completion(.success(session))
    }
    
    
    //MARK: - create URLSessionConfiguration
    func setupConfigSession(cahePolicy: NSURLRequest.CachePolicy) -> URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        config.allowsCellularAccess = false
        config.waitsForConnectivity = true
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 300
        config.multipathServiceType = .handover
        config.requestCachePolicy = cahePolicy
        return config
    }
}

extension CreaterSession: URLSessionDelegate {
    //Сообщает URLSession, что сеанс признан недействительным.
    func urlSession(_ session: URLSession, didBecomeInvalidWithError error: (any Error)?) {
        //
    }
}

extension CreaterSession: URLSessionTaskDelegate {
     //- Соеденине восстановилось
    func urlSession(_ session: URLSession, taskIsWaitingForConnectivity task: URLSessionTask) {
           // - Ожидание соединения, обновление интерфейса и прочее
    }
}
