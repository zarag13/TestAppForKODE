//
//  SortedCheckBoxController.swift
//  TestAppForKODE
//
//  Created by Kirill on 15.03.2024.
//

import BaseUIComponents

//MARK: - Протокол с помощью которого контроллер принимает данные от Презентера
protocol SortedCheckBoxControllerProtocol: AnyObject {
    func showCheckBoxView(value: [String], checkBoxState: CheckBoxState)
}

final class SortedCheckBoxController: BaseController {
    
    var presenter: SortedCheckBoxPresenterProtocol?
    
    //MARK: - Closure - с помошью которого мы будем передавать состояние выбранной кнопки в стартовый контроолер с таблицей сотрудников
    var checkBoxState: ((CheckBoxState)->Void)?
    
    let navigationBar = SimpleNavigationBar()
    let stackCheckBoxView = SortedStackCheckBoxView()

}


extension SortedCheckBoxController {
    override func setupViews() {
        super.setupViews()
        self.presenter?.viewDidLoad()
        view.addView(navigationBar)
        navigationBar.titleLabel.text = "Сортировка"
        navigationBar.leftBurButtomItemDelegate = self
        view.addView(stackCheckBoxView)
        stackCheckBoxView.delegate = self
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        view.backgroundColor = .white
        #warning("поставить наблюдателя, если получится, что бы отслеживать состояние и отображать или нет кастомную полоску - инидкатор для sheetPresentationController ")
        sheetPresentationController?.selectedDetentIdentifier = .large
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
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


//MARK: - Здесь получаем данные о первой загрузке контроллера и при необходимости делаем одну из кнопок активной
extension SortedCheckBoxController: SortedCheckBoxControllerProtocol {
    func showCheckBoxView(value: [String], checkBoxState: CheckBoxState) {
        stackCheckBoxView.sortedCheckBoxValue = value
        guard let views = stackCheckBoxView.stackCheckBoxView.arrangedSubviews as? [SortedCheckBoxView] else { return }
        views.forEach { view in
            if view.checkBoxButton.sotredCheckBoxState == checkBoxState {
                view.checkBoxButton.changeState = .selected
            }
        }
    }
}

//MARK: - когда нажали на кнопку вернуться назад у навигации
extension SortedCheckBoxController: BackButtonViewProtocol {
    func goBack() {
        presenter?.tapBackBarItem()
    }
}

//MARK: - метод который срабатывает при нажатии на кнопку - делаем возможность выборать только одну из кнопок ( вторая становится сразу неактивной)
extension SortedCheckBoxController: SortedCheckBoxButtonProtocol {
    func selectCheckBox(sortedCeckBoox: CheckBoxState) {
        guard let views = stackCheckBoxView.stackCheckBoxView.arrangedSubviews as? [SortedCheckBoxView] else { return }
        
        switch sortedCeckBoox {
        case .none:
            break
        case .alphabet:
            for checkBoxView in views {
                if checkBoxView.checkBoxButton.sotredCheckBoxState == .birthday {
                    if checkBoxView.checkBoxButton.changeState == .selected {
                        checkBoxView.checkBoxButton.changeState = .deselected
                    }
                }
            }
        case .birthday:
            for checkBoxView in views {
                if checkBoxView.checkBoxButton.sotredCheckBoxState == .alphabet {
                    if checkBoxView.checkBoxButton.changeState == .selected {
                        checkBoxView.checkBoxButton.changeState = .deselected
                    }
                }
            }
        }
        checkBoxState?(sortedCeckBoox)
    }
}
