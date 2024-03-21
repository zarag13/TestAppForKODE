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
    func showDetailInfo(employee: Employee, avatar: UIImage)
}


final class EmployeeProfileVIewController: BaseController {
    
    var presenter: DetailEmployeeProfilePresenterProtocol?
    
    private let profileView = ProfileView()
    private let detailProfileView = DetailProfileView(frame: .zero, style: .grouped)
    private let navigationBar = SimpleNavigationBar()
}

extension EmployeeProfileVIewController {
    override func setupViews() {
        super.setupViews()
        presenter?.viewDidLoad()
        view.addView(profileView)
        view.addView(detailProfileView)
        view.addView(navigationBar)
        navigationBar.leftBurButtomItemDelegate = self
        detailProfileView.delegateAction = self
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor, constant: Resources.Size.sizeStatusBar?.height ?? 44),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 52),
            
            profileView.topAnchor.constraint(equalTo: view.topAnchor),
            profileView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            detailProfileView.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 8),
            detailProfileView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            detailProfileView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            detailProfileView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        view.backgroundColor = Resources.Colors.empliyeeProfileBacground
    }
}


//MARK: - распределяем данные по view
extension EmployeeProfileVIewController: DetailEmployeeProfileVIewControllerProtocol {
    //получаем картинку и текстовые данные пользователя
    func showDetailInfo(employee: Employee, avatar: UIImage) {
        profileView.configureView(employee: employee, avatar: avatar)
        detailProfileView.configureDataSourceee(employee: employee)
    }
}

//MARK: - закрытие контроллера
extension EmployeeProfileVIewController: BackButtonViewProtocol {
    func goBack() {
        presenter?.popToViewController()
    }
}

//MARK: - открытие алерта с вызовом номера
extension EmployeeProfileVIewController: DetailProfileTableViewDelegate {
    func showAlertCallPhone(phone: String) {
        let alert = AlertForCallPhone(superView: self.view, phone: phone)
        self.view.addView(alert)
        alert.addConstraintForSuperView()
        alert.showAlert()
    }
}
