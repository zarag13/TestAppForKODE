//
//  SortedCheckBoxPresenter.swift
//  TestAppForKODE
//
//  Created by Kirill on 15.03.2024.
//

import Foundation

//MARK: - Протокол с помощью которого общаются с презентером
protocol SortedCheckBoxPresenterProtocol: AnyObject {
    
    /// Description: view - сообщила, что она загружена
    func viewDidLoad()
    /// Description: метод который вызывает итерактор для передачи данных в презентре
    func returnData(value: [String], checkBoxState: CheckBoxState)
    /// Description: метод который вызывает view -  что бы закрылся контроллер
    func tapBackBarItem()
}

final class SortedCheckBoxPresenter {
    weak var view: SortedCheckBoxControllerProtocol?
    var interactor: SortedCheckBoxInteractorProtocol
    var router: SortedCheckboxRouterProtocol
    init(interactor: SortedCheckBoxInteractorProtocol, router: SortedCheckboxRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
}

extension SortedCheckBoxPresenter: SortedCheckBoxPresenterProtocol{
    func tapBackBarItem() {
        router.closeСurrentController()
    }
    
    func returnData(value: [String], checkBoxState: CheckBoxState) {
        view?.showCheckBoxView(value: value, checkBoxState: checkBoxState)
    }
    
    func viewDidLoad() {
        interactor.getData()
    }
}
