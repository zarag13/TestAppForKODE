//
//  EmployeeProfilePresenter.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import UIKit

//MARK: - протокол по которому view заправшивает у презентера данные - что view загружено и можешь передавать нам данные
protocol DetailEmployeeProfilePresenterProtocol: AnyObject {
    func viewDidLoad()
    func returnDataFromInteractor(employee: Employee, avatar: UIImage)
    func popToViewController()
}

class DetailEmployeeProfilePresenter {
    weak var view: DetailEmployeeProfileVIewControllerProtocol?
    var router: DetailEmployeeProfileRouterProtocol
    var iteractor: DetailEmployeeProfileIteractorProtocol
    
    init(router: DetailEmployeeProfileRouterProtocol, iteractor: DetailEmployeeProfileIteractorProtocol) {
        self.router = router
        self.iteractor = iteractor
    }
    
}

extension DetailEmployeeProfilePresenter : DetailEmployeeProfilePresenterProtocol {
    func popToViewController() {
        router.loadBackView()
    }
    
    func returnDataFromInteractor(employee: Employee, avatar: UIImage) {
        view?.showDetailInfo(employee: employee, avatar: avatar)
    }
    
    func viewDidLoad() {
        iteractor.gettingData()
    }
}
