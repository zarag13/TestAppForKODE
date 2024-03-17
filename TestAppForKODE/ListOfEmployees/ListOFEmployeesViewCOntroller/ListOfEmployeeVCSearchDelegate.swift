//
//  ListOfEmployeeVCSearchDelegate.swift
//  TestAppForKODE
//
//  Created by Kirill on 17.03.2024.
//

import UIKit

extension ListOfEmployeesViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        navigationBar.didBeginEditing = .begun
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return textField.resignFirstResponder()
    }
}

extension ListOfEmployeesViewController: SearchSortedButtonDelegate {
    func selectLeftButton() {
        presenter?.selectedSortedButton()
    }
}
