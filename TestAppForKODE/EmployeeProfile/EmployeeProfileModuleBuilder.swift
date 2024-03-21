//
//  EmployeeProfileModuleBuilder.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import Foundation


//MARK: - сборка Второго контроллера
final class EmployeeProfileBuilder {
    static func builder(employee: Employee) -> EmployeeProfileVIewController {
        let view = EmployeeProfileVIewController()
        let iteractor = DetailEmployeeProfileIteractor(employe: employee)
        let router = DetailEmployeeProfileRouter()
        router.view = view
        let presenter = DetailEmployeeProfilePresenter(router: router, iteractor: iteractor)
        view.presenter = presenter
        presenter.view = view
        iteractor.presenter = presenter

        return view
    }
}
