//
//  ListOfEmployeesInteractor.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import Foundation

protocol ListOfEmployeesInteractorProtocol: AnyObject {
    //MARK: - первая загрузка данных + перезагрузка данных - здесь используем обращение в сеть
    #warning("Реализовать сохранение состояния в UserDefault - и хранить их здесь - сейчас реализую такой способ получения- но потом удаляем входные параметры и берем их из UserDefault")
    func loadData()
    //MARK: - метод сортировки
    func loadFilteredData(selectedDepartament: Department, sortedState: CheckBoxState, searchText: String)
    //MARK: - метод перезагрузки данных
    func reloadData(selectedDepartament: Department, sortedState: CheckBoxState, searchText: String)
}

class ListOfEmployeesInteractor {
    weak var presenter: ListOfEmployeesPresenterProtocol?
    
    let networkManager = BuilderNetworkLayer.createTaskManagerr()
    let managerProcessingData = ManagerProcessingdData()
    let filteringManager = FilteredDataManager()
    
    var employees = [Employee]()
    var filteredEmployees = [Employee]()
}

extension ListOfEmployeesInteractor: ListOfEmployeesInteractorProtocol {
    //MARK: -перезагрузка данных - без открытия окна ошибки
    func reloadData(selectedDepartament: Department, sortedState: CheckBoxState, searchText: String) {
        networkManager.eployeeListGetTask(state: .code500) {[weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let data):
                //MARK: - приводим список к нужному виду
                self.employees = self.managerProcessingData.processingDecoderJSONData(data: data, task: networkManager)
                DispatchQueue.main.async {
                    //MARK: -здесь возвращаем отвильтрованный тип данных
                    self.loadFilteredData(selectedDepartament: selectedDepartament, sortedState: sortedState, searchText: searchText)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    //MARK: -здесь возвращаем отвильтрованный тип данных
                    self.loadFilteredData(selectedDepartament: selectedDepartament, sortedState: sortedState, searchText: searchText)
                }
            }
        }
    }
    
    
    //MARK: - первая загрузка данных - c открытием окна ошибки
    func loadData() {
        networkManager.eployeeListGetTask(state: .code200) {[weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let data):
                //MARK: - приводим список к нужному виду
                self.employees = self.managerProcessingData.processingDecoderJSONData(data: data, task: networkManager)
                DispatchQueue.main.async {
                    self.presenter?.didLoad(data: self.employees)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.presenter?.obtainError()
                }
            }
        }
    }
    
    //
    func loadFilteredData(selectedDepartament: Department, sortedState: CheckBoxState, searchText: String) {
        //1. если приешл все по стандарту без поисковых слов
        let state = employees.count != 0
        guard selectedDepartament == .all && sortedState == .none && searchText.isEmpty else {
            
            //2. Есть ли текст
            guard !searchText.isEmpty else {
                //3. Здесь обработка всех остальных кейсов без текста
                filteredEmployees = filteringManager.filteringBy(departament: selectedDepartament, sortedCheckBoxFiltered: sortedState, data: employees)
                self.presenter?.didLoadFilteredData(data: self.filteredEmployees, state: state)
                return
            }
            //2. Есть ли текст + все остальные кейсы
            filteredEmployees = filteringManager.filteringBy(departament: selectedDepartament, sortedCheckBoxFiltered: sortedState, data: employees)
            filteredEmployees = filteringManager.filteringBySearchText(searchText: searchText, employees: filteredEmployees)
            self.presenter?.didLoadFilteredData(data: self.filteredEmployees, state: state)
            return
        }
        //1. если приешл все по стандарту без поисковых слов
        self.filteredEmployees = self.employees
        self.presenter?.didLoadFilteredData(data: self.filteredEmployees, state: state)
        return
    }
}
