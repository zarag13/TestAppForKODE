//
//  ModelDetailProfile.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import Foundation


#warning("Мока для таблицы - исправить при парсинге данных и конкретной разрабтки арихтектуры")
//Структура ячеек
struct Employer: Hashable, Identifiable {
    let date: String
    let phoneNumber: String
    let years: String?
    
    
    let id = UUID()
    
    static func ==(lhs: Employer, rhs: Employer) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    init(date: String, phoneNumber: String, years: String? = nil) {
        self.date = date
        self.phoneNumber = phoneNumber
        self.years = years
    }
}



//Какие секции будет (хранят ассоциативное значение == ячейке)
enum DetailSection: Hashable {
    case dateSection(Employer)
    case phoneSection(Employer)
    
    //быстрый доступ к ассоциативным значенияем
    var items: Employer {
        switch self {
        case    .dateSection(let user),
                .phoneSection(let user):
            return user
        }
    }
}


//Созданые данных
struct MockData {
    static let shared = MockData()
    
    //Создаем данные секции - Скидки
    private let dateSection: DetailSection = {
        return .dateSection(.init(date: "123123312", phoneNumber: "+7 (996) 959 32 62", years: "24"))
    }()
    
    //Создаем данные секции - Категории
    private let phoneSection: DetailSection = {
        return .phoneSection(.init(date: "57657675675675", phoneNumber: "+79969593262"))
    }()
    
    
    //Объединение выше созданных категорий
    var pageDta: [DetailSection] {
        [dateSection, phoneSection]
    }
}
