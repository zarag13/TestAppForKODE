//
//  SortedCheckBoxBuilder.swift
//  TestAppForKODE
//
//  Created by Kirill on 15.03.2024.
//

import Foundation

class SortedCheckBoxBuilder {
    static func build() -> SortedCheckBoxController {
        let view = SortedCheckBoxController()
        let router = SortedCheckboxRouter()
        router.view = view
        let interactor = SortedCheckBoxInteractor()
        let presenter = SortedCheckBoxPresenter(interactor: interactor, router: router)
        presenter.view = view
        interactor.presenter = presenter
        
        return view
    }
}
