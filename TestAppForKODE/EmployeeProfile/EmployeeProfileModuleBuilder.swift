//
//  EmployeeProfileModuleBuilder.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import Foundation


//MARK: - сборка Второго контроллера
class EmployeeProfileBuilder {
    static func builder(employe: Employer) -> EmployeeProfileVIewController {
        let iteractor = DetailEmployeeProfileIteractor(employe: employe)
        let router = DetailEmployeeProfileRouter()
        let view = EmployeeProfileVIewController()
        let presenter = DetailEmployeeProfilePresenter(router: router, iteractor: iteractor)
        view.presenter = presenter
        presenter.view = view
        iteractor.presenter = presenter

        return view
    }
}
