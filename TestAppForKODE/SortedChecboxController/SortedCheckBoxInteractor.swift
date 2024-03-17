//
//  SortedCheckBoxInteractor.swift
//  TestAppForKODE
//
//  Created by Kirill on 15.03.2024.
//

import Foundation

protocol SortedCheckBoxInteractorProtocol: AnyObject {
    func getData()
}

class SortedCheckBoxInteractor {
    weak var presenter: SortedCheckBoxPresenterProtocol?
    
    let sortedValue = ["По алфавиту", "По дню рождения"]
}

extension SortedCheckBoxInteractor: SortedCheckBoxInteractorProtocol {
    func getData() {
        presenter?.returnData(value: sortedValue)
    }
}
