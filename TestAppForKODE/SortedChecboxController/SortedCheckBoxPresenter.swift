//
//  SortedCheckBoxPresenter.swift
//  TestAppForKODE
//
//  Created by Kirill on 15.03.2024.
//

import Foundation

protocol SortedCheckBoxPresenterProtocol: AnyObject {
    
}

class SortedCheckBoxPresenter {
    weak var view: SortedCheckBoxControllerProtocol?
    var interactor: SortedCheckBoxInteractorProtocol
    var router: SortedCheckboxRouterProtocol
    init(interactor: SortedCheckBoxInteractorProtocol, router: SortedCheckboxRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
}

extension SortedCheckBoxPresenter: SortedCheckBoxPresenterProtocol{
    
}
