//
//  SortedCheckBoxController.swift
//  TestAppForKODE
//
//  Created by Kirill on 15.03.2024.
//

import BaseUIComponents

protocol SortedCheckBoxControllerProtocol: AnyObject {
    func showCheckBoxView(value: [String])
}

class SortedCheckBoxController: BaseController {
    
    var presenter: SortedCheckBoxPresenterProtocol?
    
    var checkBoxState: ((CheckBoxState)->Void)?
    
    let stackCheckBoxView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    let navigationBar = SimpleNavigationBar()
    
    var sortedCheckBoxValue = [String]()
}


extension SortedCheckBoxController {
    override func setupViews() {
        super.setupViews()
        presenter?.viewDidLoad()
        view.addView(navigationBar)
        navigationBar.titleLabel.text = "Сортировка"
        navigationBar.leftBurButtomItemDelegate = self
        
        view.addView(stackCheckBoxView)
        sortedCheckBoxValue.forEach { value in
            print("1231321321231321231321231231231232312 \(value)")
            let checkBoxView = SortedCheckBoxView()
            checkBoxView.descriptionForButton.text = value
            print("1312313213213213212313213212313- \(checkBoxView.frame.height)")
            stackCheckBoxView.addArrangedSubview(checkBoxView)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        view.backgroundColor = .white
#warning("поставить наблюдателя, если получится, что бы отслеживать состояние и отображать или нет кастомную полоску - инидкатор")
        sheetPresentationController?.selectedDetentIdentifier = .large
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        print("asdsdaadsadadadadadadadadadad \(stackCheckBoxView.arrangedSubviews[0].frame.height)")
        NSLayoutConstraint.activate([
            navigationBar.topAnchor.constraint(equalTo: view.topAnchor),
            navigationBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationBar.heightAnchor.constraint(equalToConstant: 52),
            
            
            
            stackCheckBoxView.topAnchor.constraint(equalTo: navigationBar.bottomAnchor, constant: 8),
            stackCheckBoxView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            stackCheckBoxView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
        ])
    }
}

extension SortedCheckBoxController: SortedCheckBoxControllerProtocol {
    func showCheckBoxView(value: [String]) {
        sortedCheckBoxValue = value
    }
}

extension SortedCheckBoxController: BackButtonViewProtocol {
    func goBack() {
        presenter?.tapBackBarItem()
    }
}
