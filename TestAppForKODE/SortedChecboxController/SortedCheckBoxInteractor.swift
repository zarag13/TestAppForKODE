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
    
    let checkBoxState: CheckBoxState
    
    let sortedValue = ["По алфавиту", "По дню рождения"]
    
    init(checkBoxState: CheckBoxState) {
        self.checkBoxState = checkBoxState
    }
}

extension SortedCheckBoxInteractor: SortedCheckBoxInteractorProtocol {
    func getData() {
        presenter?.returnData(value: sortedValue, checkBoxState: checkBoxState)
    }
}
