//
//  ListOfEmployeesViewController.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import Foundation
import BaseUIComponents

//MARK: - получение ответ от Presentera
protocol ListOfEmployeesViewControllerProtocol: AnyObject {
    func showData(data: [Employee])
    func showFilteredData(data: [Employee], state: Bool)
    func showLoadFilteredDataWithError(error: ErrorReloadDataAlertState)
}


//MARK: - уведомление для tableView--RefreshControl
protocol ListOfEmployeesViewControllerCallBackProtocol: AnyObject {
    func reloadDataDone()
}

class ListOfEmployeesViewController : BaseController {
    var presenter: ListOfEmployeesPresenter?
    
    let navigationBar = NavigationBarTableList()
    let tableListOfEmployees = ListOfEmployeesTableView(frame: .zero, style: .grouped)
    let errorSearchView = ErrorSearchView()
    
    weak var callBackDelegate: ListOfEmployeesViewControllerCallBackProtocol?
    
    var employees = [Employee]() {
        didSet {
            animationMissDataOrPresentData(data: employees)
            tableListOfEmployees.employees = employees
        }
    }
    
    var showAlert: Bool = false {
        didSet {
            navigationController?.navigationBar.barStyle = showAlert == true ? .black : .default
        }
    }
    
    
    var searchText: String = "" {
        didSet {
            presenter?.loadFilteredData(selectedDepartament: selectedDepartament, sortedState: sortedState, searchText: searchText)
        }
    }
    
    var selectedDepartament = Department.all {
        didSet {
            presenter?.loadFilteredData(selectedDepartament: selectedDepartament, sortedState: sortedState, searchText: searchText)
        }
    }
    
    var sortedState: CheckBoxState = .none {
        didSet {
            print(sortedState.rawValue)
            tableListOfEmployees.sortedBirthDay = sortedState == .birthday ? true : false
            print(tableListOfEmployees.sortedBirthDay)
            //уведомление navigationBar - что бы сменился цвет кнопки которая отображает, что применялась сортировка
            navigationBar.sortedState = sortedState
            //далее нужно обратиться к Презентеру и
            presenter?.loadFilteredData(selectedDepartament: selectedDepartament, sortedState: sortedState, searchText: searchText)
        }
    }
    
    var reloadDataIfNeeds: Bool = true
}

extension ListOfEmployeesViewController {
    override func setupViews() {
        view.addView(navigationBar)
        view.addView(tableListOfEmployees)
        view.addView(errorSearchView)
        navigationController?.navigationBar.isHidden = true
        navigationBar.departamentMenu.departamentsDelegate = self
        navigationBar.delegate = self
        tableListOfEmployees.tableViewdelegate = self
        errorSearchView.isHidden = true
        
        //MARK: - первая загрузка приложения
        presenter?.viewDidLoad()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadDataIfNeeds = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //когда мы возвращаемся обратно с экрана ошибки - если данных не было - делаем повторную загрузки
        //защита стоит так как мы и с детальной информации возвращаемся - что бы оно не делало каждый раз запрос
        if reloadDataIfNeeds == true {
            presenter?.viewDidLoad()
        }
    }
    
    override func setupLayoutViews() {
        
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor, constant: Resources.Size.sizeStatusBar?.height ?? 44),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 96),
            
            tableListOfEmployees.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 16),
            tableListOfEmployees.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tableListOfEmployees.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableListOfEmployees.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            errorSearchView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 80),
            errorSearchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            errorSearchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    override func configureAppearance() {
        view.backgroundColor = .white
        navigationBar.searchBar.textField.delegate = self
    }
}


//MARK: - получение данных от Presentera
extension ListOfEmployeesViewController: ListOfEmployeesViewControllerProtocol {
    func showLoadFilteredDataWithError(error: ErrorReloadDataAlertState) {
        let alert = ErrorReloadDataAlert(state: error)
        self.view.addView(alert)
        alert.setupLayaoutForSuperView()
        alert.openAlert()
        showAlert = true
        alert.delegaate = self
        callBackDelegate?.reloadDataDone()
    }
    
    //защита от использования навигейшен контроллера при отстуствии первоночальных данных - позволяет сохранять mockCell - иначе таблица будет пытаться создать ячейки с данными - а так как они не пришли [] - еще и будет открываться view - что ничего не найдено
    func showFilteredData(data: [Employee], state: Bool) {
        if state {
            employees = data
            callBackDelegate?.reloadDataDone()
        }
    }
    
    func showData(data: [Employee]) {
        if data.count != 0 {
            employees = data
        }
        //MARK: - останавливаем анимацию рефреша
        callBackDelegate?.reloadDataDone()
    }
}

//MARK: - уведомления от tableView
extension ListOfEmployeesViewController: ListOfEmployeesTableViewDelegate {
    //MARK: - когда нажали на сотрудника
    func selectedEmployee(employee: Employee) {
        presenter?.selectedEmployee(employee: employee)
    }
    //MARK: - когда юзаем ревреш - он предает нам себя же - что бы мы потом ему отправили сигнал об остановке анимации рефреша
    func reloadData(callback: any ListOfEmployeesViewControllerCallBackProtocol) {
        callBackDelegate = callback
        presenter?.reloadData(selectedDepartament: selectedDepartament, sortedState: sortedState, searchText: searchText)
    }
}

//MARK: - уведомления от navigationBar - переключение фильтрации
extension ListOfEmployeesViewController: DepartamentsProtocol {
    func move(departamen: Department) {
        selectedDepartament = departamen
    }
}

extension ListOfEmployeesViewController {
    func animationMissDataOrPresentData(data: [Employee]) {
        if data.count == 0 {
            UIView.animate(withDuration: 1) {
                self.tableListOfEmployees.isHidden = true
                self.tableListOfEmployees.alpha = 0
                self.errorSearchView.isHidden = false
                self.errorSearchView.alpha = 1
            }
        } else {
            UIView.animate(withDuration: 1) {
                self.tableListOfEmployees.isHidden = false
                self.tableListOfEmployees.alpha = 1
                self.errorSearchView.isHidden = true
                self.errorSearchView.alpha = 0
            }
        }
        
    }
}

extension ListOfEmployeesViewController: ErrorReloadDataAlertProtocol {
    func closeAlert() {
        showAlert = false
    }
}
