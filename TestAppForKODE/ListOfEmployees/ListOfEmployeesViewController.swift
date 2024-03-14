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
    
    let categoriesMenu = NavigationBarTableList()
    let tableListOfEmployees = ListOfEmployeesTableView()
}

extension ListOfEmployeesViewController {
    override func setupViews() {
        
    }
    
    override func setupLayoutViews() {
        NSLayoutConstraint.activate([
            categoriesMenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoriesMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoriesMenu.heightAnchor.constraint(equalToConstant: 96),
            
            tableListOfEmployees.topAnchor.constraint(equalTo: categoriesMenu.bottomAnchor, constant: 16),
            tableListOfEmployees.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableListOfEmployees.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableListOfEmployees.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func configureAppearance() {
        view.addView(categoriesMenu)
        view.addView(tableListOfEmployees)
        view.backgroundColor = .white
    }
}

extension ListOfEmployeesViewController: ListOfEmployeesViewControllerProtocol {
    
}
