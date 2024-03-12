//
//  JSONCodable.swift
//  TestAppForKODE
//
//  Created by Kirill on 12.03.2024.
//

import Foundation

//MARK: - JSONCodableProtocol
protocol JSONCodableProtocol {
    func decodeJson<T: Codable>(type: T.Type, from: Data) -> T?
}

//MARK: - JSONCodable
class JSONCodable: JSONCodableProtocol {
    
    //MARK: - universal func decoding Models
    func decodeJson<T: Codable>(type: T.Type, from: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            let object = try decoder.decode(type.self, from: from)
            return object
        }catch let error {
            debugPrint(error)
            return nil
        }
    }
}
