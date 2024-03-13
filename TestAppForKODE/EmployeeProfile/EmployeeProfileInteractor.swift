//
//  EmployeeProfileInteractor.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import Foundation

//MARK: - протокол по которому презентер - запрашивает конкретные данные у Iteractor (Iteractor их получит при своем создании)
protocol DetailEmployeeProfileIteractorProtocol: AnyObject {
    func gettingData() -> Employer
}

class DetailEmployeeProfileIteractor {
    weak var presenter: DetailEmployeeProfilePresenterProtocol?
    let employe: Employer
    
    init( employe: Employer) {
        self.employe = employe
    }
}

//MARK: - обрабатываем полученные данные при создании
extension DetailEmployeeProfileIteractor: DetailEmployeeProfileIteractorProtocol {
    func gettingData() -> Employer {
        #warning("Здесь нужно будет изменить формат номера и получить из даты возраст(типа 24 года)")
#warning("еще переделать так, что бы презентор вызывая этот метод - получал данные в своем методе - не зря же интерактор знает о презентере, мы тут обрабатываем данные - передаем их в свое свойство - а уже потом вызываем метод презентера - передевая ему наше свойство с данными")
        return employe
    }
}
