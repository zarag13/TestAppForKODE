//
//  CreaterSession.swift
//  TestAppForKODE
//
//  Created by Kirill on 12.03.2024.
//

import Foundation


//MARK: - Protocol create URLSession
protocol CreaterSessionProtocol {
    func eployeeListGetSession(completion: @escaping (Result<URLSession, ErrorForNetworkManager>) -> Void)
    func eployeeAvatarDownloadSession(url: String, completion: @escaping (Result<URLSession, ErrorForNetworkManager>) -> Void)
}

//MARK: - Class create URLSession
final class CreaterSession: NSObject, CreaterSessionProtocol {
    
    //MARK: - required queue for work session delegate
    private let operationQueue = OperationQueue()
    
    var configurationSession: URLSessionConfiguration?
    var urlSession: URLSession?
    
    //MARK: - func create URLSession for download JSON
    func eployeeListGetSession(completion: @escaping (Result<URLSession, ErrorForNetworkManager>) -> Void) {
        configurationSession = setupConfigSession(cahePolicy: .useProtocolCachePolicy)
        guard let config = configurationSession else {
            completion(.failure(.createConfigSession))
            return
        }
        
        urlSession = URLSession(configuration: config, delegate: self, delegateQueue: operationQueue)
        guard let session = urlSession else {
            completion(.failure(.createSession))
            return
        }
        completion(.success(session))
    }
    
    
    //MARK: - func create URLSession for download IMAGE
    func eployeeAvatarDownloadSession(url: String, completion: @escaping (Result<URLSession, ErrorForNetworkManager>) -> Void) {
        configurationSession = setupConfigSession(cahePolicy: .returnCacheDataElseLoad)
        guard let config = configurationSession else {
            completion(.failure(.createConfigSession))
            return
        }
        
        urlSession = URLSession(configuration: config, delegate: self, delegateQueue: operationQueue)
        guard let session = urlSession else {
            completion(.failure(.createSession))
            return
        }
        completion(.success(session))
    }
    
    
    //MARK: - create URLSessionConfiguration
    func setupConfigSession(cahePolicy: NSURLRequest.CachePolicy) -> URLSessionConfiguration {
        let config = URLSessionConfiguration.default
        if cahePolicy == .returnCacheDataElseLoad {
            config.urlCache = URLCache(memoryCapacity: 50*1024*1024, diskCapacity: 50*1024*1024, diskPath: "images")
        }
        config.allowsCellularAccess = false
        config.waitsForConnectivity = true
        config.timeoutIntervalForRequest = 30
        config.timeoutIntervalForResource = 30
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
