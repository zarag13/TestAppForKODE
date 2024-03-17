//
//  ListOfEmployeesPouter.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import Foundation
import UIKit

protocol ListOfEmployeesPouterProtocol: AnyObject {
    func openErrorVC()
    func openDetailVC(employee: Employee)
    func openSortedController()
}

class ListOfEmployeesPouter {
    weak var view: ListOfEmployeesViewController?
}

extension ListOfEmployeesPouter: ListOfEmployeesPouterProtocol {
    func openSortedController() {
        let vc = SortedCheckBoxBuilder.build()
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.largestUndimmedDetentIdentifier = .medium
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
            sheet.prefersScrollingExpandsWhenScrolledToEdge = false
            sheet.prefersEdgeAttachedInCompactHeight = true
            sheet.widthFollowsPreferredContentSizeWhenEdgeAttached = true
        }
        
        vc.checkBoxState = { [weak self] state in
            #warning("обработать полученные состояния фильтрации - передатьих в view и там уже потом решить что делать")
            self?.view?.sortedState = state
        }
        
        view?.present(vc, animated: true)
    }
    
    func openErrorVC() {
        let vc = ErrorModuleBuilder.builder()
        view?.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openDetailVC(employee: Employee) {
        let vc = EmployeeProfileBuilder.builder(employee: employee)
        view?.navigationController?.pushViewController(vc, animated: true)
    }
}
