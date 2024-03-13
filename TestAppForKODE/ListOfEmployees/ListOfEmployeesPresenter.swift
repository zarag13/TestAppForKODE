//
//  ListOfEmployeesPresenter.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import Foundation

protocol ListOfEmployeesPresenterProtocol: AnyObject {
    
}

class ListOfEmployeesPresenter {
    weak var view: ListOfEmployeesViewControllerProtocol?
    let interactor: ListOfEmployeesInteractorProtocol
    let router: ListOfEmployeesPouterProtocol
    
    init(interactor: ListOfEmployeesInteractorProtocol, router: ListOfEmployeesPouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension ListOfEmployeesPresenter: ListOfEmployeesPresenterProtocol {
    
}
