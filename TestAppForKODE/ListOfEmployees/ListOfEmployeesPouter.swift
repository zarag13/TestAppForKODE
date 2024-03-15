//
//  ListOfEmployeesPouter.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import Foundation

protocol ListOfEmployeesPouterProtocol: AnyObject {
    func openErrorVC()
    func openDetailVC(employee: Employee)
}

class ListOfEmployeesPouter {
    weak var view: ListOfEmployeesViewController?
}

extension ListOfEmployeesPouter: ListOfEmployeesPouterProtocol {
    func openErrorVC() {
        let vc = ErrorModuleBuilder.builder()
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openDetailVC(employee: Employee) {
        let vc = EmployeeProfileBuilder.builder(employe: employee)
        view?.navigationController?.pushViewController(vc, animated: true)
    }
}
