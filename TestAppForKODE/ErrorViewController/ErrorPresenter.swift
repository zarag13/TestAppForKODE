//
//  ErrorPresenter.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import Foundation

protocol ErrorPresenterProtocol: AnyObject {
    func getData(data: ErrorData)
    func viewDidLoad()
    func reloadData()
}

final class ErrorPresenter {
    weak var view: ErrorViewControllerProtocol?
    let interactor: ErrorInteractorProtocol
    let router: ErrorRouterProtocol
    
    init(interactor: ErrorInteractorProtocol, router: ErrorRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
}

extension ErrorPresenter: ErrorPresenterProtocol {
    func reloadData() {
        router.openStartVC()
    }
    
    func viewDidLoad() {
        interactor.loadData()
    }
    
    func getData(data: ErrorData) {
        view?.showData(data: data)
    }
}
