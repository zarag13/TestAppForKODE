//
//  CreaterTask.swift
//  TestAppForKODE
//
//  Created by Kirill on 12.03.2024.
//

import Foundation



//MARK: - Protocol Creater dataTask
protocol CreaterTaskProtocol {
    func eployeeListGetTask(state: ResultState, completion: @escaping (Result<ModelEmployeeList, ErrorForNetworkManager>) -> Void)
    func employeeDownloadAvatarImageTask(url: String, completion: @escaping (Result<Data, ErrorForNetworkManager>) -> Void)
}

//MARK: - Class Creater dataTask
final class CreaterTaskForSession: CreaterTaskProtocol {
    
    //MARK: - Required object for work dataTask (session + request + decoder)
    let sessionPr: CreaterSessionProtocol
    let requestPr: CreaterRequestProtocol
    let decoderPr: JSONCodableProtocol
    
    init(session: CreaterSessionProtocol, request: CreaterRequestProtocol, decoder: JSONCodableProtocol) {
        self.sessionPr = session
        self.requestPr = request
        self.decoderPr = decoder
    }
    
    private var task: URLSessionTask?
    
    
    /// RequestJSONData
    /// - Parameters:
    ///   - state: response code 200 or 500
    ///   - completion: result (data or error)
    ///   - Warning: !!!!!! Use MAIN thread for processing of the received Data!!!!!!!
    func eployeeListGetTask(state: ResultState, completion: @escaping (Result<ModelEmployeeList, ErrorForNetworkManager>) -> Void) {
        
        sessionPr.eployeeListGetSession { [weak self] result in
            guard let strSelf = self else { return }
            switch result {
                
            case .success(let session):
                
                strSelf.requestPr.getRequestEmployeeeList(state: state) { result in
                    switch result {
                    case .success(let request):
                        strSelf.task = session.dataTask(with: request, completionHandler: { data, response, error in
                            if error != nil {
                                completion(.failure(.errorTask))
                                return
                            }
                            guard let httpResponse = response as? HTTPURLResponse else {
                                completion(.failure(.errorReciveResponse))
                                return
                            }
                            
                            switch httpResponse.statusCode {
                            case 400..<500:
                                completion(.failure(.statusCode400before500))
                                return
                            case 500... :
                                completion(.failure(.statusCode500AndMore))
                                return
                            default: break
                            }
                            
                            
                            guard let data = data else {
                                completion(.failure(.errorReceiveData))
                                return
                            }
                            guard let json = strSelf.decoderPr.decodeJson(type: ModelEmployeeList.self, from: data) else {
                                completion(.failure(.errorDecodeData))
                                return
                            }
                            completion(.success(json))
                            
                        })
                        strSelf.task?.resume()
                    case .failure(let errorRequest):
                        completion(.failure(errorRequest))
                    }
                }
            case .failure(let errorSesion):
                completion(.failure(errorSesion))
            }
        }
    }
    
    
    
    
    /// DownloadImageResult
    /// - Parameters:
    ///   - url: url for download dataImage
    ///   - completion: result (dataImage or error)
    ///   - Warning: !!!!!! Use MAIN thread for processing of the received Data!!!!!!!
    ///   - Return: returns the data that needs to be converted in UIImage(data: result)
    ///   - Description: такое решение было принято, что бы не импортировать UIKit
    func employeeDownloadAvatarImageTask(url: String, completion: @escaping (Result<Data, ErrorForNetworkManager>) -> Void) {
        sessionPr.eployeeAvatarDownloadSession(url: url) { [weak self] rsultSession in
            guard let strSelf = self else { return }
            
            switch rsultSession {
                
            case .success(let session):
                
                strSelf.requestPr.getRequestForDownloadAvatar(urL: url) { result in
                    
                    
                    
                    switch result {
                    case .success(let request):
                        strSelf.task = session.dataTask(with: request, completionHandler: { data, response, error in
                            //
                            if let cacheResponse = session.configuration.urlCache?.cachedResponse(for: request) {
                                completion(.success(cacheResponse.data))
                                return
                            }
                            //
                            
                            if error != nil {
                                completion(.failure(.errorTask))
                                return
                            }
                            guard let httpResponse = response as? HTTPURLResponse else {
                                completion(.failure(.errorReciveResponse))
                                return
                            }
                            
                            guard let data = data else {
                                completion(.failure(.errorReceiveData))
                                return
                            }
                            completion(.success(data))
                            
                        })
                        strSelf.task?.resume()
                    case .failure(let errorRequest):
                        completion(.failure(errorRequest))
                    }
                }
            case .failure(let errorSesion):
                completion(.failure(errorSesion))
            }
        }
    }
    
}
