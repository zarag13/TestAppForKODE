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
    
    private let selectColor: UIColor
    private let deselectColor: UIColor
    
    init(configure: ActionSearchSortedButton = .unmoved, image: UIImage, changeState: StateSearchSortedButton = .deselected, selectColor: UIColor, deselectColor: UIColor) {
        self.config = configure
        self.imageView.image = image
        self.changeState = changeState
        self.selectColor = selectColor
        self.deselectColor = deselectColor
        super.init(frame: .zero)
    }
    
}

extension SearchSortedButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.width / 2
        
        switch changeState {
        case .selected:
            imageView.tintColor = selectColor
        case .deselected:
            imageView.tintColor =  deselectColor
        }
    }
}

extension SearchSortedButton {
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .clear
        //translatesAutoresizingMaskIntoConstraints = false
        
        switch config {
        case .unmoved:
            break
        case .moved:
            let gesture = UITapGestureRecognizer(target: self, action: #selector(selectCheckBox))
            addGestureRecognizer(gesture)
        }
    }
    
    @objc func selectCheckBox() {
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
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
}

