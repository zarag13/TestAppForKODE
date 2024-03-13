//
//  ErrorInteractor.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import Foundation

protocol ErrorInteractorProtocol: AnyObject {
    func loadData()
}

class ErrorInteractor {
    weak var presenter: ErrorPresenterProtocol?
    
    var data: ErrorData?
}

extension ErrorInteractor: ErrorInteractorProtocol {
    func loadData() {
        data = ErrorData.createData()
        guard let returnData = data else { return }
        presenter?.getData(data: returnData)
    }
}
