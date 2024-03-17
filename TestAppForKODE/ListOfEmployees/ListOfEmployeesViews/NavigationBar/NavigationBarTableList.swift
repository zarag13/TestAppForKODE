//
//  NavigationBarTableList.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import BaseUIComponents

class NavigationBarTableList: BaseView {
    
    let searchBar = SearchBar()
    
    let departamentMenu = DepartamentsCollectionView()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#C3C3C6")
        return view
    }()
}

extension NavigationBarTableList {
    override func setupViews() {
        addView(searchBar)
        addView(departamentMenu)
        addView(lineView)
    }
    
    override func setupLayoutViews() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            departamentMenu.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 14),
            departamentMenu.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            departamentMenu.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            departamentMenu.heightAnchor.constraint(equalToConstant: 36),
            
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.5),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    override func configureAppearance() {
    }
}
