//
//  SortedCheckBoxController.swift
//  TestAppForKODE
//
//  Created by Kirill on 15.03.2024.
//

import BaseUIComponents

protocol SortedCheckBoxControllerProtocol: AnyObject {
    func downloadStateForCheckBoxItem()
}

class SortedCheckBoxController: BaseController {
    var presenter: SortedCheckBoxPresenterProtocol?
    
    var checkBoxState: ((CheckBoxState)->Void)?
}


extension SortedCheckBoxController {
    override func setupViews() {
        super.setupViews()
        
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        
    }
}

extension SortedCheckBoxController: SortedCheckBoxControllerProtocol {
    func downloadStateForCheckBoxItem() {
        
    }
}
