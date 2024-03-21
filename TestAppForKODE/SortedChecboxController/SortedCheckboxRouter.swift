//
//  SortedCheckboxRouter.swift
//  TestAppForKODE
//
//  Created by Kirill on 15.03.2024.
//

import Foundation

//MARK: - протокол с помощью которого с Роутером общается Презентер
protocol SortedCheckboxRouterProtocol: AnyObject {
    
    /// Description: метод закрытия текущего контроллера
    func closeСurrentController()
}

final class SortedCheckboxRouter {
    weak var view: SortedCheckBoxController?
}

extension SortedCheckboxRouter: SortedCheckboxRouterProtocol {
    func closeСurrentController() {
        view?.dismiss(animated: true)
    }
}
