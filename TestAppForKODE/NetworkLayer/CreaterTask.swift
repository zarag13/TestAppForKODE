//
//  CreaterTask.swift
//  TestAppForKODE
//
//  Created by Kirill on 12.03.2024.
//

import Foundation


//MARK: - Enum error with work dataTask
enum ErrorWorkTask: Error, CustomStringConvertible {
    
    case errorTask
    case errorReciveResponse
    case errorReceiveData
    case errorDecodeData
    
    var description: String {
        switch self {
        case .errorTask:
            return "Eror in dataTask Request"
        case .errorReciveResponse:
            return "Error Recive Response in datTask"
        case .errorReceiveData:
            return "Error Recive Data in datTask"
        case .errorDecodeData:
            return "Error decode data in dataTask"
        }
    }
}

//MARK: - Protocol Creater dataTask
protocol CreaterTaskProtocol {
    func eployeeListGetTask(state: ResultState, completion: @escaping (Result<ModelEmployeeList, ErrorWorkTask>) -> Void)
    func employeeDownloadAvatarImageTask(url: String, completion: @escaping (Result<Data, ErrorWorkTask>) -> Void)
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
    func eployeeListGetTask(state: ResultState, completion: @escaping (Result<ModelEmployeeList, ErrorWorkTask>) -> Void) {
        
        print(" func  ---- \(Thread.current)")
        
        sessionPr.eployeeListGetSession { [weak self] result in
            guard let strSelf = self else { return }
            switch result {
                
            case .success(let session):
                
                strSelf.requestPr.getRequestEmployeeeList(state: state) { result in
                    switch result {
                    case .success(let request):
                        strSelf.task = session.dataTask(with: request, completionHandler: { data, response, error in
                            print(" task  ---- \(Thread.current)")
                            if error != nil {
                                completion(.failure(.errorTask))
                                return
                            }
                            guard let response = response else {
                                completion(.failure(.errorReciveResponse))
                                return
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
                        print(errorRequest.localizedDescription)
                    }
                }
            case .failure(let errorSesion):
                print(errorSesion.localizedDescription)
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
    func employeeDownloadAvatarImageTask(url: String, completion: @escaping (Result<Data, ErrorWorkTask>) -> Void) {
        sessionPr.eployeeAvatarDownloadSession(url: url) { [weak self] result in
            guard let strSelf = self else { return }
            
            switch result {
                
            case .success(let session):
                
                strSelf.requestPr.getRequestForDownloadAvatar(urL: url) { result in
                    switch result {
                    case .success(let request):
                        strSelf.task = session.dataTask(with: request, completionHandler: { data, response, error in
                            if error != nil {
                                completion(.failure(.errorTask))
                                return
                            }
                            guard let response = response else {
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
                        print(errorRequest.localizedDescription)
                    }
                }
            case .failure(let errorSesion):
                print(errorSesion.localizedDescription)
            }
        }
    }
    
}
