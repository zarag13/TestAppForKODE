//
//  CategoriesViewController.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    let categoriesMenu = NavigationBarTableList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addView(categoriesMenu)
        
        view.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            categoriesMenu.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            categoriesMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            categoriesMenu.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            categoriesMenu.heightAnchor.constraint(equalToConstant: 96)
        ])
    }
}
