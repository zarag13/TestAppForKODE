//
//  ErrorRouter.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import Foundation

protocol ErrorRouterProtocol: AnyObject {
    
}

class ErrorRouter {
    weak var view: ErrorViewControllerProtocol?
}

extension ErrorRouter: ErrorRouterProtocol {
    
}
