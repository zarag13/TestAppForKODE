//
//  ListOfEmployeesPouter.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import Foundation

protocol ListOfEmployeesPouterProtocol: AnyObject {
    
}

class ListOfEmployeesPouter {
    weak var view: ListOfEmployeesViewControllerProtocol?
}

extension ListOfEmployeesPouter: ListOfEmployeesPouterProtocol {
    
}