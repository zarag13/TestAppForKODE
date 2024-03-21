//
//  EnumErrorForWorkNetworkManager.swift
//  TestAppForKODE
//
//  Created by Kirill on 14.03.2024.
//

import Foundation


/// Description: Список ошибок используемый при работе NetworkLayer
enum ErrorForNetworkManager: Error, CustomStringConvertible{
    //MARK: - Error Create URL
    case createURLFromString
    
    //MARK: - Enum == Erorr create Request
    case createRequest
    
    //MARK: - Enum Error create URLSession
    case createConfigSession
    case createSession

    //MARK: - Enum error with work dataTask
    case errorTask
    case errorReciveResponse
    case errorReceiveData
    case errorDecodeData
    case statusCode500AndMore
    case statusCode400before500
       
    
    var description: String {
        switch self {
            
        case .createURLFromString:
            return "error converting url from string"
            
        case .createRequest:
            return "error create URLRequest"
            
        case .createConfigSession:
            return "error create URLRequest"
        case .createSession:
            return "error create URLSession"
            
        case .errorTask:
            return "Eror in dataTask Request"
        case .errorReciveResponse:
            return "Error Recive Response in datTask"
        case .errorReceiveData:
            return "Error Recive Data in datTask"
        case .errorDecodeData:
            return "Error decode data in dataTask"
        case .statusCode500AndMore:
            return "Error datatTask return response status code 500 and more"
        case .statusCode400before500:
            return "Error datatTask return response status code 400 before 500"
        }
    }
}
