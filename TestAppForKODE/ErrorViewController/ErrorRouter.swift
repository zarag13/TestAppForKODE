//
//  ErrorRouter.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import Foundation

protocol ErrorRouterProtocol: AnyObject {
    func openStartVC()
}

class ErrorRouter {
    weak var view: ErrorViewController?
}

extension ErrorRouter: ErrorRouterProtocol {
    func openStartVC() {
        view?.navigationController?.popViewController(animated: true)
    }
}
