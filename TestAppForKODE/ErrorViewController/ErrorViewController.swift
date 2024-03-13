//
//  ErrorViewController.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import Foundation
import BaseUIComponents

protocol ErrorViewControllerProtocol: AnyObject {
    func showData(data: ErrorData)
}

class ErrorViewController : BaseController {
    var presenter: ErrorPresenterProtocol?
    
    let mainView = ErrorView()
    
    override func loadView() {
        view = mainView
    }
    
    
}

extension ErrorViewController {
    override func setupViews() {
        super.setupViews()
        presenter?.viewDidLoad()
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
    }
    
    override func configureAppearance() {
        super.configureAppearance()
    }
}

extension ErrorViewController: ErrorViewControllerProtocol {
    func showData(data: ErrorData) {
        mainView.congigurationView(data: data, controller: self)
    }
}

#warning("Доделать переход к стартовому контроллеру и вызов у него повтороной загрузки данных")
extension ErrorViewController: ButtonForReloadDataProtocol {
    func reloadData() {
        print("reloadData")
    }
}
