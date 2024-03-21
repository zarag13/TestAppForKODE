//
//  ListOfEmployeesInteractor.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import Foundation

protocol ListOfEmployeesInteractorProtocol: AnyObject {
    //MARK: - первая загрузка данных + перезагрузка данных - здесь используем обращение в сеть
    func loadData()
    //MARK: - метод сортировки
    func loadFilteredData(selectedDepartament: Department, sortedState: CheckBoxState, searchText: String)
    //MARK: - метод перезагрузки данных
    func reloadData(selectedDepartament: Department, sortedState: CheckBoxState, searchText: String)
}

final class ListOfEmployeesInteractor {
    weak var presenter: ListOfEmployeesPresenterProtocol?
    
    let networkManager = BuilderNetworkLayer.createTaskManagerr()
    let managerProcessingData = ManagerProcessingdData()
    let filteringManager = FilteredDataManager()
    
    var employees = [Employee]()
    var filteredEmployees = [Employee]()
}

extension ListOfEmployeesInteractor: ListOfEmployeesInteractorProtocol {
    //MARK: -перезагрузка данных - с открытие алерта об ошибке
    func reloadData(selectedDepartament: Department, sortedState: CheckBoxState, searchText: String) {
        networkManager.eployeeListGetTask(state: .code500) {[weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let data):
                //MARK: - приводим список к нужному виду
                self.employees = self.managerProcessingData.processingDecoderJSONData(data: data, task: networkManager)
                DispatchQueue.main.async {
                    //MARK: -здесь возвращаем отфильтрованный тип данных
                    self.loadFilteredData(selectedDepartament: selectedDepartament, sortedState: sortedState, searchText: searchText)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    //MARK: -здесь возвращаем отфильтрованный тип данных
                    print(error.description)
                    switch error {
                    case .statusCode400before500, .errorDecodeData :
                        self.presenter?.didLoadFilteredDataWithError(error: .errorFromServer)
                    case .statusCode500AndMore:
                        self.presenter?.didLoadFilteredDataWithError(error: .networkConnectionError)
                    default: break
                    }
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
            case .failure(_):
                DispatchQueue.main.async {
                    self.presenter?.obtainError()
                }
            }
        }
    }
    
    //MARK: - метод фильтрации данных
    func loadFilteredData(selectedDepartament: Department, sortedState: CheckBoxState, searchText: String) {
        //защита при первой загрузке данных - если данные еще не были загружены - что бы не пропали mockViewCell и не обновлялась таблица
        let state = employees.count != 0
        //1. если приешл все по стандарту без поисковых слов
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
