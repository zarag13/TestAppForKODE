//
//  ListOfEmployeesPresenter.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import Foundation

protocol ListOfEmployeesPresenterProtocol: AnyObject {
    func viewDidLoad()
    func didLoad(data: [Employee])
    func obtainError()
    func selectedEmployee(employee: Employee)
    func selectedSortedButton()
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
    func selectedSortedButton() {
        router.openSortedController()
    }
    
    func selectedEmployee(employee: Employee) {
        router.openDetailVC(employee: employee)
    }
    
    func obtainError() {
        router.openErrorVC()
    }
    
    func didLoad(data: [Employee]) {
        view?.showData(data: data)
    }
    
    func viewDidLoad() {
        interactor.loadData()
    }
}
