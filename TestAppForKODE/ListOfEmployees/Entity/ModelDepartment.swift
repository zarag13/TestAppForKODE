//
//  ModelDepartment.swift
//  TestAppForKODE
//
//  Created by Kirill on 15.03.2024.
//

import Foundation



//NARK: - MOC data
enum Department: String {
    case all = "Все"
    case android = "Android"
    case ios = "iOS"
    case design = "Дизайн"
    case management = "Менеджмент"
    case qa = "QA"
    case back_office = "Бэк-офис"
    case frontend = "Frontend"
    case hr = "HR"
    case pr = "PR"
    case backend = "Backend"
    case support = "Техподдержка"
    case analytics = "Аналитика"
}

extension Department: CaseIterable {
    static var allDepartments: [String] {
        return Department.allCases.map { $0.rawValue }
    }
}
