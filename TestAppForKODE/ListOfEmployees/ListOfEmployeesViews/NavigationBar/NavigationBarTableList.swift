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
        return searchBar
    }()
    
    let categoriesMenu = CategoriesCollectionView()
}

extension NavigationBarTableList {
    override func setupViews() {
        addView(searchBar)
        addView(categoriesMenu)
        categoriesMenu.categoriesDelegate = self
    }
    
    override func setupLayoutViews() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            searchBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 52),
            
            categoriesMenu.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            categoriesMenu.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            categoriesMenu.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            categoriesMenu.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    override func configureAppearance() {
    }
}


extension NavigationBarTableList: CategoriesProtocol {
    func move(originX: CGFloat, width: CGFloat) {
        print(originX)
    }
}
