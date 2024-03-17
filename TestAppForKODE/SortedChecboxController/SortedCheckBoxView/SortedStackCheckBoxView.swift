//
//  SortedStackCheckBoxView.swift
//  TestAppForKODE
//
//  Created by Kirill on 17.03.2024.
//

import BaseUIComponents

class SortedStackCheckBoxView: BaseView {
    let stackCheckBoxView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    weak var delegate: SortedCheckBoxButtonProtocol? {
        didSet {
            stackCheckBoxView.arrangedSubviews.forEach { view in
                guard let sortedView = view as? SortedCheckBoxView else { return }
                sortedView.checkBoxButton.delegate = delegate
            }
        }
    }
    
    var sortedCheckBoxValue = [String]() {
        didSet {
            sortedCheckBoxValue.forEach { value in
                let checkBoxView = SortedCheckBoxView()
                checkBoxView.descriptionForButton.text = value
                checkBoxView.checkBoxButton.sotredCheckBoxState = CheckBoxState(rawValue: value)!
                checkBoxView.checkBoxButton.delegate = self.delegate
                stackCheckBoxView.addArrangedSubview(checkBoxView)
            }
        }
    }
}

extension SortedStackCheckBoxView {
    override func setupViews() {
        super.setupViews()
        addView(stackCheckBoxView)
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        NSLayoutConstraint.activate([
            stackCheckBoxView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackCheckBoxView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackCheckBoxView.topAnchor.constraint(equalTo: topAnchor),
            stackCheckBoxView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
