//
//  NavigationBarTableList.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import BaseUIComponents

class NavigationBarTableList: BaseView {
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundColor = .white
        searchBar.placeholder = "Ведите имя, тег, почту..."
        searchBar.searchBarStyle = .minimal
        searchBar.searchTextField.backgroundColor = UIColor(hexString: "#F7F7F8")
        searchBar.searchTextField.borderStyle = .roundedRect
        return searchBar
    }()
    
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
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 52),
            
            departamentMenu.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            departamentMenu.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            departamentMenu.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            departamentMenu.heightAnchor.constraint(equalToConstant: 44),
            
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.5),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    override func configureAppearance() {
    }
}
