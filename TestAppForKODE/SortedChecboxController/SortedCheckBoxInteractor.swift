//
//  SortedCheckBoxInteractor.swift
//  TestAppForKODE
//
//  Created by Kirill on 15.03.2024.
//

import Foundation

//MARK: - протокол интерактора по которому с ним общается презентер
protocol SortedCheckBoxInteractorProtocol: AnyObject {
    
    /// Description: метод загрузки данных
    func getData()
}

final class SortedCheckBoxInteractor {
    weak var presenter: SortedCheckBoxPresenterProtocol?
    
    let checkBoxState: CheckBoxState
    
    let sortedValue = ["По алфавиту", "По дню рождения"]
    
    /// Description: принимает данные о том, какая кнопка должна быть нажата
    init(checkBoxState: CheckBoxState) {
        self.checkBoxState = checkBoxState
    }
}

extension SortedCheckBoxInteractor: SortedCheckBoxInteractorProtocol {
    func getData() {
        presenter?.returnData(value: sortedValue, checkBoxState: checkBoxState)
    }
}
