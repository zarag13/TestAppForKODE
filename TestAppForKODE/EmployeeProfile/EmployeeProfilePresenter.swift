//
//  EmployeeProfilePresenter.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import Foundation

//MARK: - протокол по которому view заправшивает у презентера данные - что view загружено и можешь передавать нам данные
protocol DetailEmployeeProfilePresenterProtocol: AnyObject {
    func viewDidLoad()
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
    func viewDidLoad() {
        //Здесь получаем данные от iteractor и передаем их в view
        let employe = iteractor.gettingData()
        //view?.showDetailInfo(employee: employe)
    }
}
