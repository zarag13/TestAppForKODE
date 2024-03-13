//
//  ListOfEmployeesViewController.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import Foundation
import BaseUIComponents

protocol ListOfEmployeesViewControllerProtocol: AnyObject {
    
}

class ListOfEmployeesViewController : BaseController {
    var presenter: ListOfEmployeesPresenter?
}

extension ListOfEmployeesViewController: ListOfEmployeesViewControllerProtocol {
    
}
