//
//  EmployeeProfileInteractor.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import UIKit

//MARK: - протокол по которому презентер - запрашивает конкретные данные у Iteractor (Iteractor их получит при своем создании)
protocol DetailEmployeeProfileIteractorProtocol: AnyObject {
    func gettingData()
}

class DetailEmployeeProfileIteractor {
    weak var presenter: DetailEmployeeProfilePresenterProtocol?
    let employe: Employee
    
    let networkManager = BuilderNetworkLayer.createTaskManagerr()
    
    init( employe: Employee) {
        self.employe = employe
    }
}

//MARK: - обрабатываем полученные данные при создании
extension DetailEmployeeProfileIteractor: DetailEmployeeProfileIteractorProtocol {
    func gettingData() {
        networkManager.employeeDownloadAvatarImageTask(url: employe.avatarImage) { [weak self] result in
            guard let strSelf = self else { return }
            var avatar = UIImage()
            switch result {
            case .success(let data):
                avatar = UIImage(data: data)!
                DispatchQueue.main.async {
                    strSelf.presenter?.returnDataFromInteractor(employee: strSelf.employe, avatar: avatar)
                }
            case .failure(_):
                avatar = UIImage(named: Resources.Image.mockAvatarImage)!
                DispatchQueue.main.async {
                    strSelf.presenter?.returnDataFromInteractor(employee: strSelf.employe, avatar: avatar)
                }
            }
        }
    }
}
