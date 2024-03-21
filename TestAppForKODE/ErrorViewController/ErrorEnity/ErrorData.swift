//
//  ErrorData.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import Foundation


/// Description: данные которые будут заполнять контент контроллера с ошибкой загрузки первоначальных данных
struct ErrorData {
    var fisrtTitle: String
    var secondTitle: String
    var imageName: String
    var buttonText: String
    
    static func createData() -> ErrorData {
        let data = ErrorData(fisrtTitle: "Какой-то сверхразум все сломал", secondTitle: "Постараемся быстро починить", imageName: Resources.Image.flyingSaucer, buttonText: "Попробовать снова")
        return data
    }
}
