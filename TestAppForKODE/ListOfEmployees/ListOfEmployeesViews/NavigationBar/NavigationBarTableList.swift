//
//  NavigationBarTableList.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import BaseUIComponents

protocol NavigationBarTableListDelegate: AnyObject {
    func searchText(text: String)
    func cancelEditing() 
}

class NavigationBarTableList: BaseView {
    
    let searchBar = SearchBar()
    
    let departamentMenu = DepartamentsCollectionView()
    
    weak var delegate: NavigationBarTableListDelegate?
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hexString: "#C3C3C6")
        return view
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        //button.setTitle("Отмена", for: .normal)
        let title = NSAttributedString(string: "Отмена", attributes: [.font: Resources.Founts.interBold(with: 14)])
        button.setAttributedTitle(title, for: .normal)
        button.setTitleColor(Resources.Colors.titleErrorTextColor, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var trailingAnchorSearchBar: NSLayoutConstraint = searchBar.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
    
    #warning("Началось редактирование")
    var didBeginEditing: DidBeginEditingSearchBar? = .end {
        didSet {
            searchBar.didBeginEditing = didBeginEditing
            trailingAnchorSearchBar.constant = didBeginEditing == .end ? -16: -90
            UIView.animate(withDuration: 0.5) {
                self.layoutIfNeeded()
            }
        }
    }
    
    var sortedState: CheckBoxState? {
        didSet {
            guard let noEmptyState = sortedState else { return }
            switch noEmptyState {
            case .none:
                searchBar.textField.rightSearchBarItem.changeState = .deselected
            case .alphabet:
                searchBar.textField.rightSearchBarItem.changeState = .selected
            case .birthday:
                searchBar.textField.rightSearchBarItem.changeState = .selected
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let state = didBeginEditing else { return }
        switch state {
        case .begun:
            cancelButton.isHidden = false
        case .end:
            cancelButton.isHidden = true
        }
    }
}



extension NavigationBarTableList {
    override func setupViews() {
        super.setupViews()
        addView(searchBar)
        addView(departamentMenu)
        addView(lineView)
        addView(cancelButton)
        cancelButton.makeSystemButtonAnimation()
        cancelButton.addTarget(self, action: #selector(tapCancelButton), for: .touchUpInside)
        searchBar.textField.addTarget(self, action: #selector(changeText(sender:)), for: .editingChanged)
    }
    
    @objc func changeText(sender: UITextField) {
        delegate?.searchText(text: sender.text!)
    }
    
    @objc func tapCancelButton() {
        searchBar.textField.text = ""
        searchBar.textField.resignFirstResponder()
        didBeginEditing = .end
        delegate?.cancelEditing()
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            searchBar.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            trailingAnchorSearchBar,
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            departamentMenu.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 14),
            departamentMenu.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            departamentMenu.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            departamentMenu.heightAnchor.constraint(equalToConstant: 36),
            
            lineView.bottomAnchor.constraint(equalTo: bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.5),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            cancelButton.topAnchor.constraint(equalTo: searchBar.topAnchor),
            cancelButton.bottomAnchor.constraint(equalTo: searchBar.bottomAnchor),
            cancelButton.leadingAnchor.constraint(equalTo: searchBar.trailingAnchor),
            cancelButton.widthAnchor.constraint(equalToConstant: 78),
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
    }
}
