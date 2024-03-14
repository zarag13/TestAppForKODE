//
//  ListOfEmployeesModuleBuilder.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import Foundation

//MARK: - сборка Второго контроллера
class ListOfEmployeesModuleBuilder {
    static func builder() -> ListOfEmployeesViewController {
        
        let view = ListOfEmployeesViewController()
        let router = ListOfEmployeesPouter()
        router.view = view
        let interactor = ListOfEmployeesInteractor()
        let presenter = ListOfEmployeesPresenter(interactor: interactor, router: router)
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter
        return view
    }
}
