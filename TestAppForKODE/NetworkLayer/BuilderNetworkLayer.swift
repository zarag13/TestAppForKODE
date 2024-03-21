//
//  BuilderNetworkLayer.swift
//  TestAppForKODE
//
//  Created by Kirill on 12.03.2024.
//

import Foundation
import UIKit


/// Description: Сборка NetworkLayer
final class BuilderNetworkLayer {
    
    /// Description создает все зависимости и возвращает уже сразу готовую к работе задачу(dataTask)
    static func createTaskManagerr() ->  CreaterTaskForSession {
        let url = CreaterURL()
        let request = CreaterRequest(url: url)
        let decoder = JSONCodable()
        let session = CreaterSession()
        let task = CreaterTaskForSession(session: session, request: request, decoder: decoder)
        return task
    }
}
