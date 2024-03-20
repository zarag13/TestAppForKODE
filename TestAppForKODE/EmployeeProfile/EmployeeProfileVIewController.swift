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
    let navigationBar = SimpleNavigationBar()
    
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
    
    func showDetailInfo(employee: Employee) {
        profileView.configureView(employee: employee)
        detailProfileView.configureDataSourceee(employee: employee)
    }
}

extension EmployeeProfileVIewController: BackButtonViewProtocol {
    func goBack() {
        presenter?.popToViewController()
    }
}

extension EmployeeProfileVIewController: DetailProfileTableViewDelegate {
    func showAlertCallPhone() {
        let alert = AlertForCallPhone(superView: self.view)
        self.view.addSubview(alert)
        alert.showAlert()
    }
}
