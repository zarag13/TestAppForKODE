//
//  SortedCheckBoxBuilder.swift
//  TestAppForKODE
//
//  Created by Kirill on 15.03.2024.
//

import Foundation


/// Description: Класс который собирает все необходимые зависимости и возвращает SortedCheckBoxController
final class SortedCheckBoxBuilder {
    static func build(checkBoxState: CheckBoxState) -> SortedCheckBoxController {
        let view = SortedCheckBoxController()
        let router = SortedCheckboxRouter()
        router.view = view
        let interactor = SortedCheckBoxInteractor(checkBoxState: checkBoxState)
        let presenter = SortedCheckBoxPresenter(interactor: interactor, router: router)
        presenter.view = view
        interactor.presenter = presenter
        view.presenter = presenter
        return view
    }
}
