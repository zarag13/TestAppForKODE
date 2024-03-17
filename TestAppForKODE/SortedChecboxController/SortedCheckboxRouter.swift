//
//  SortedCheckboxRouter.swift
//  TestAppForKODE
//
//  Created by Kirill on 15.03.2024.
//

import Foundation

protocol SortedCheckboxRouterProtocol: AnyObject {
    func closeСurrentController()
}

class SortedCheckboxRouter {
    weak var view: SortedCheckBoxController?
}

extension SortedCheckboxRouter: SortedCheckboxRouterProtocol {
    func closeСurrentController() {
        view?.dismiss(animated: true)
    }
}
