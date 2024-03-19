//
//  SearchBar.swift
//  TestAppForKODE
//
//  Created by Kirill on 16.03.2024.
//

import BaseUIComponents

enum DidBeginEditingSearchBar {
    case begun
    case end
}

class SearchBar: BaseView {
    let textField: SearchBarTextField = {
        let textField = SearchBarTextField()
        return textField
    }()
    
    var didBeginEditing: DidBeginEditingSearchBar? {
        didSet {
            textField.leftSearchBarItem.changeState = didBeginEditing == .begun ? .selected : .deselected
            self.textField.rightView = self.didBeginEditing == .begun ? nil : self.textField.rightSearchBarItem
            UIView.animate(withDuration: 0.3, delay: 0.2) {
                self.layoutIfNeeded()
            }
        }
    }
}

extension SearchBar {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.height / 2.5
    }
}

extension SearchBar {
    override func setupViews() {
        super.setupViews()
        addView(textField)
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = UIColor(hexString: "#F7F7F8")
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        NSLayoutConstraint.activate([
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            textField.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            textField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
