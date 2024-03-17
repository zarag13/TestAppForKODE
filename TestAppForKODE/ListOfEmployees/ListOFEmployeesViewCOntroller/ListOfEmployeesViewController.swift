//
//  ListOfEmployeesViewController.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import Foundation
import BaseUIComponents

protocol ListOfEmployeesViewControllerProtocol: AnyObject {
    func showData(data: [Employee])
}

protocol ListOfEmployeesViewControllerCallBackProtocol: AnyObject {
    func reloadDataDone()
}

class ListOfEmployeesViewController : BaseController {
    var presenter: ListOfEmployeesPresenter?
    
    let navigationBar = NavigationBarTableList()
    let tableListOfEmployees = ListOfEmployeesTableView()
    
    weak var callBackDelegate: ListOfEmployeesViewControllerCallBackProtocol?
    
    var employees = [Employee]() {
        didSet {
            tableListOfEmployees.employees = employees
        }
    }
    
    var filteredEmployee = [Employee]() {
        didSet {
            tableListOfEmployees.employees = filteredEmployee
        }
    }
    
    var selectedDepartament: Department?
}

extension ListOfEmployeesViewController {
    override func setupViews() {
        print("viewDidLoad")
        view.addView(navigationBar)
        view.addView(tableListOfEmployees)
        navigationController?.navigationBar.isHidden = true
        navigationBar.departamentMenu.departamentsDelegate = self
        tableListOfEmployees.tableViewdelegate = self
        
        #warning("Отключил запрос в сеть")
        //presenter?.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //presenter?.viewDidLoad()
    }
    
    override func setupLayoutViews() {
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor, constant: Resources.Size.sizeStatusBar?.height ?? 44),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 96),
            
            tableListOfEmployees.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 16),
            tableListOfEmployees.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableListOfEmployees.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableListOfEmployees.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func configureAppearance() {
        view.backgroundColor = .white
        navigationBar.searchBar.textField.delegate = self
    }
}

extension ListOfEmployeesViewController: ListOfEmployeesViewControllerProtocol {
    func showData(data: [Employee]) {
        if selectedDepartament == nil || selectedDepartament?.rawValue == "Все" {
            employees = data
        } else {
            filteredEmployee = data.filter { employee in
                return employee.department == "\(selectedDepartament!)"
            }
        }
        callBackDelegate?.reloadDataDone()
    }
}

extension ListOfEmployeesViewController: ListOfEmployeesTableViewDelegate {
    func selectedEmployee(employee: Employee) {
        presenter?.selectedEmployee(employee: employee)
    }
    
    func reloadData(callback: any ListOfEmployeesViewControllerCallBackProtocol) {
        callBackDelegate = callback
        presenter?.viewDidLoad()
    }
}

extension ListOfEmployeesViewController: DepartamentsProtocol {
    
    func move(departamen: Department) {
        selectedDepartament = departamen
        filteredEmployee = employees.filter { eployee in
            if departamen.rawValue == "Все" {
                return true
            }else {
                return eployee.department == "\(departamen)"
            }
        }
    }
}
