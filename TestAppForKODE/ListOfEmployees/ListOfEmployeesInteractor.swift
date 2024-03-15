//
//  ListOfEmployeesInteractor.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import Foundation

protocol ListOfEmployeesInteractorProtocol: AnyObject {
    func loadData()
}

class ListOfEmployeesInteractor {
    weak var presenter: ListOfEmployeesPresenterProtocol?
    
    let networkManager = BuilderNetworkLayer()
    let managerProcessingData = ManagerProcessingdData()
    
}

extension ListOfEmployeesInteractor: ListOfEmployeesInteractorProtocol {
    func loadData() {
        let task = networkManager.createTaskManagerr()
        task.eployeeListGetTask(state: .code200) { result in
            switch result {
                
            case .success(let data):
                
                var employees = self.managerProcessingData.processingDecoderJSONData(data: data, task: task)
                
                DispatchQueue.main.async {
                    self.presenter?.didLoad(data: employees)
                    
                }
                
            case .failure(let error):
                print(error.description)
                DispatchQueue.main.async {
                    self.presenter?.obtainError()
                }
            }
        }
    }
}
