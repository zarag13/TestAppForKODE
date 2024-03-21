//
//  ErrorModuleBuilder.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import Foundation

//MARK: - сборка экрана с ошибкой
final class ErrorModuleBuilder {
    static func builder() -> ErrorViewController {
        let view = ErrorViewController()
        let interactor = ErrorInteractor()
        let router = ErrorRouter()
        router.view = view
        let presenter = ErrorPresenter(interactor: interactor, router: router)
        view.presenter = presenter
        presenter.view = view
        interactor.presenter = presenter

        return view
    }
}
