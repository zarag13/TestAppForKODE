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

class ListOfEmployeesViewController : BaseController {
    var presenter: ListOfEmployeesPresenter?
    
    let categoriesMenu = NavigationBarTableList()
    let tableListOfEmployees = ListOfEmployeesTableView()
    
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
    
    var refresh = UIRefreshControl()
}

extension ListOfEmployeesViewController {
    override func setupViews() {
        print("viewDidLoad")
        view.addView(categoriesMenu)
        view.addView(tableListOfEmployees)
        navigationController?.navigationBar.isHidden = true
        categoriesMenu.categoriesMenu.categoriesDelegate = self
        tableListOfEmployees.tableViewdelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewDidLoad()
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
        view.backgroundColor = .white
    }
}

extension ListOfEmployeesViewController: ListOfEmployeesViewControllerProtocol {
    func showData(data: [Employee]) {
        employees = data
        refresh.endRefreshing()
    }
}

extension ListOfEmployeesViewController: ListOfEmployeesTableViewDelegate {
    func reloadData(sender: UIRefreshControl) {
        refresh = sender
        presenter?.viewDidLoad()
    }
}

extension ListOfEmployeesViewController: CategoriesProtocol {
    
    func move(departamen: Department) {
        filteredEmployee = employees.filter { eployee in
            if departamen.rawValue == "Все" {
                return true
            }else {
                return eployee.department == "\(departamen)"
            }
        }
    }
}
