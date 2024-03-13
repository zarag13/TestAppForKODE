//
//  ListOfEmployeesInteractor.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import Foundation

protocol ListOfEmployeesInteractorProtocol: AnyObject {
    
}

class ListOfEmployeesInteractor {
    weak var presenter: ListOfEmployeesPresenterProtocol?
    
}

extension ListOfEmployeesInteractor: ListOfEmployeesInteractorProtocol {
    
}
