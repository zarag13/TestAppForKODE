//
//  ListOfEmployeeVCSearchDelegate.swift
//  TestAppForKODE
//
//  Created by Kirill on 17.03.2024.
//

import UIKit

//MARK: - получение данных от navigationBar == SearchController
extension ListOfEmployeesViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        navigationBar.didBeginEditing = .begun
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

//MARK: - действие при нажатии на правую кнопку navigationBar == searchBar
extension ListOfEmployeesViewController: SearchSortedButtonDelegate {
    func selectLeftButton() {
        presenter?.selectedSortedButton(sortedState: self.sortedState)
    }
}

extension ListOfEmployeesViewController: NavigationBarTableListDelegate {
    func cancelEditing() {
        self.searchText = ""
    }
    
    func searchText(text: String) {
        self.searchText = text
    }
}
