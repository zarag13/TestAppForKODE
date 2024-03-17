//
//  SearchBarItem.swift
//  TestAppForKODE
//
//  Created by Kirill on 16.03.2024.
//

import BaseUIComponents

enum StateSearchSortedButton {
    case selected
    case deselected
}

enum ActionSearchSortedButton {
    case unmoved
    case moved
}

protocol SearchSortedButtonDelegate: AnyObject {
    func selectLeftButton()
}

class SearchSortedButton: BaseView {
    
    let imageView = UIImageView()
    
    var config: ActionSearchSortedButton
    
    weak var delegate: SearchSortedButtonDelegate?
    
    var changeState: StateSearchSortedButton {
        didSet {
            setNeedsLayout()
        }
    }
    
    init(configure: ActionSearchSortedButton = .unmoved, image: UIImage, changeState: StateSearchSortedButton = .deselected) {
        self.config = configure
        self.imageView.image = image
        self.changeState = changeState
        super.init(frame: .zero)
    }
    
}

extension SearchSortedButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.width / 2
        
        switch changeState {
        case .selected:
            imageView.tintColor = UIColor.black
        case .deselected:
            imageView.tintColor = UIColor.red
        }
    }
}

extension SearchSortedButton {
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
        
        switch config {
        case .unmoved:
            break
        case .moved:
            let gesture = UITapGestureRecognizer(target: self, action: #selector(selectCheckBox))
            addGestureRecognizer(gesture)
        }
    }
    
    @objc func selectCheckBox() {
        let newValue: StateSearchSortedButton = changeState == .deselected ? .selected : .deselected
        changeState = newValue
        print(changeState)
        delegate?.selectLeftButton()
    }
    
    
    override func setupViews() {
        super.setupViews()
        addView(imageView)
        let symbolConfiguration1 = UIImage.SymbolConfiguration(scale: .medium)
        imageView.preferredSymbolConfiguration = symbolConfiguration1
        imageView.tintColor = UIColor.black
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        
        heightAnchor.constraint(equalToConstant: 24).isActive = true
        widthAnchor.constraint(equalToConstant: 24).isActive = true
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
}

