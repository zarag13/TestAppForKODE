//
//  ListOfEmployeesPresenter.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import Foundation

protocol ListOfEmployeesPresenterProtocol: AnyObject {
    //MARK: - первая загрузка данных
    func viewDidLoad()
    //MARK: - перезагрузка данных
    func reloadData(selectedDepartament: Department, sortedState: CheckBoxState, searchText: String)
    //MARK: - фильтрация данных
    func loadFilteredData(selectedDepartament: Department, sortedState: CheckBoxState, searchText: String)
    
    func didLoadFilteredData(data: [Employee], state: Bool)
    
    func didLoad(data: [Employee])
    func obtainError()
    func selectedEmployee(employee: Employee)
    func selectedSortedButton(sortedState: CheckBoxState)
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
    func didLoadFilteredData(data: [Employee], state: Bool) {
        view?.showFilteredData(data: data, state: state)
    }
    
    func loadFilteredData(selectedDepartament: Department, sortedState: CheckBoxState, searchText: String) {
        interactor.loadFilteredData(selectedDepartament: selectedDepartament, sortedState: sortedState, searchText: searchText)
    }
    
    func reloadData(selectedDepartament: Department, sortedState: CheckBoxState, searchText: String) {
        interactor.reloadData(selectedDepartament: selectedDepartament, sortedState: sortedState, searchText: searchText)
    }
    
    func selectedSortedButton(sortedState: CheckBoxState) {
        router.openSortedController(sortedState: sortedState)
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
    
    //MARK: - первая загрузка данных
    func viewDidLoad() {
        interactor.loadData()
    }
}
