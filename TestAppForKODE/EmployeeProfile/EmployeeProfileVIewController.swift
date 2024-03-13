//
//  EmployeeProfileVIewController.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import UIKit
import BaseUIComponents

//MARK: - протокол по которому view получит данные
protocol DetailEmployeeProfileVIewControllerProtocol: AnyObject {
    func showDetailInfo(employee: Employee)
}


class EmployeeProfileVIewController: BaseController {
    
    var presenter: DetailEmployeeProfilePresenterProtocol?
    
    let profileView = ProfileView()
    let detailProfileView = DetailProfileView(frame: .zero, style: .grouped)
    
    override func setupViews() {
        super.setupViews()
        
        presenter?.viewDidLoad()
        
        //let image = UIImage(named: " Avatar")!
        
        
#warning("Мока для профиля - исправить при парсинге данных и конкретной разрабтки арихтектуры")
        //profileView.configureView(avatarImage: image, nameLabel: "Алиса Иванова", markingLabel: "al", professionLabel: "Designer")
        view.addView(profileView)
        view.addView(detailProfileView)
        //view.addView(detailProfileView)
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            detailProfileView.topAnchor.constraint(equalTo: profileView.bottomAnchor),
            detailProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            detailProfileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            detailProfileView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        view.backgroundColor = Resources.Colors.empliyeeProfileBacground
        
        
        
        
        #warning("Смена цвета статус бара - скорее всего придется избавиться при добавлении в naviggation")
        guard let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate else { return }
        let windowScene = sceneDelegate.window?.windowScene
        let frameStatus = (windowScene?.statusBarManager?.statusBarFrame)!
        let statusBarView = UIView(frame: frameStatus)
        statusBarView.backgroundColor = Resources.Colors.employeeProfileView
        view.addSubview(statusBarView)
        
    }
}


//MARK: - распределяем данные по view
extension EmployeeProfileVIewController: DetailEmployeeProfileVIewControllerProtocol {
    
    #warning("здесь нужно будет обработать полученные данные передав их в конфигураторы наших view")
    func showDetailInfo(employee: Employee) {
        guard let image = UIImage(data: employee) else { return }
        profileView.configureView(avatarImage: image,
                                  nameLabel: employee.firstName,
                                  markingLabel: employee.userTag,
                                  professionLabel: employee.department)
        
        
        detailProfileView.configureDiffableDataSourceee(employee: <#T##Employer#>)
    }
}
