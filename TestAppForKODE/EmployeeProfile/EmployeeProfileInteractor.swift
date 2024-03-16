//
//  EmployeeProfileInteractor.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import Foundation

//MARK: - протокол по которому презентер - запрашивает конкретные данные у Iteractor (Iteractor их получит при своем создании)
protocol DetailEmployeeProfileIteractorProtocol: AnyObject {
    func gettingData()
}

class DetailEmployeeProfileIteractor {
    weak var presenter: DetailEmployeeProfilePresenterProtocol?
    let employe: Employee
    
    init( employe: Employee) {
        self.employe = employe
    }
}

//MARK: - обрабатываем полученные данные при создании
extension DetailEmployeeProfileIteractor: DetailEmployeeProfileIteractorProtocol {
    func gettingData() {
        presenter?.returnDataFromInteractor(employee: employe)
    }
}
