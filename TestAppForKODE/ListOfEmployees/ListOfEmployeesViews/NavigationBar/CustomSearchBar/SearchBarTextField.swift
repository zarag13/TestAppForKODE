//
//  SearchBarTextField.swift
//  TestAppForKODE
//
//  Created by Kirill on 16.03.2024.
//

import UIKit

#warning("донастроить")
final class SearchBarTextField: UITextField {
    
    var rightSearchBarItem = SearchSortedButton(configure: .moved, image: UIImage(named: "list.ui.alt")!)
    var leftSearchBarItem = SearchSortedButton(configure: .unmoved, image: UIImage(systemName: "magnifyingglass")!)
    
    private var padding = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextField()
        
    }
    
    
    override var delegate: (any UITextFieldDelegate)? {
        didSet {
            rightSearchBarItem.delegate = delegate as? any SearchSortedButtonDelegate
            leftSearchBarItem.delegate = delegate as? any SearchSortedButtonDelegate
        }
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTextField() {
        
        leftView = leftSearchBarItem
        leftViewMode = .always
        rightView = rightSearchBarItem
        rightViewMode = .always
        backgroundColor = .clear
        SearchBarTextField.appearance().tintColor = Resources.Colors.titleErrorTextColor
        
        //удалить доп панель с подсказками над клавиатурой
        spellCheckingType = .no
        autocorrectionType = .no
        
        defaultTextAttributes = [.font: Resources.Founts.interMedium(with: 15), .foregroundColor: Resources.Colors.titleTextColor]
        attributedPlaceholder = NSAttributedString(string: "Ведите имя, тег, почту...", attributes: [.font: Resources.Founts.interMedium(with: 15), .foregroundColor: Resources.Colors.metaTextColor])
    }
}

extension SearchBarTextField {
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
}
