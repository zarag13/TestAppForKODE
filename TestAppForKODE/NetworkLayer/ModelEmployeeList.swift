//
//  ModelEmployeeList.swift
//  TestAppForKODE
//
//  Created by Kirill on 12.03.2024.
//

import Foundation


// MARK: - Model Array EmployeeList
struct ModelEmployeeList: Codable {
    let employee: [Employee]
    
    enum CodingKeys: String, CodingKey {
        case employee = "items"
    }
}

// MARK: - One item == Employee
struct Employee: Codable {
    let id: String
    let avatarUrl: String
    let firstName, lastName, userTag, department: String
    let position, birthday, phone: String
}
