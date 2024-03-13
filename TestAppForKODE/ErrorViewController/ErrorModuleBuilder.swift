//
//  ErrorModuleBuilder.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import Foundation

//MARK: - сборка экрана с ошибкой
class ErrorModuleBuilder {
    static func builder() -> ErrorViewController {
        let interactor = ErrorInteractor()
        let router = ErrorRouter()
        let view = ErrorViewController()
        let presenter = ErrorPresenter(interactor: interactor, router: router)
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter

        return view
    }
}
