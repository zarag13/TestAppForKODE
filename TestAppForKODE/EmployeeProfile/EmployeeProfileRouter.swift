//
//  EmployeeProfileRouter.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import Foundation

protocol DetailEmployeeProfileRouterProtocol: AnyObject {
    func loadBackView()
}


class DetailEmployeeProfileRouter {
    weak var view: EmployeeProfileVIewController?
}

extension DetailEmployeeProfileRouter: DetailEmployeeProfileRouterProtocol {
    func loadBackView() {
        view?.navigationController?.popViewController(animated: true)
    }
}
