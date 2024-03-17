//
//  SortedCheckBoxView.swift
//  TestAppForKODE
//
//  Created by Kirill on 16.03.2024.
//

import BaseUIComponents

class SortedCheckBoxView: BaseView {
    let checkBoxButton = SortedCheckBoxButton()
    let descriptionForButton: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Resources.Founts.interMedium(with: 16)
        label.textColor = Resources.Colors.titleTextColor
        return label
    }()
}

extension SortedCheckBoxView {
    override func setupViews() {
        super.setupViews()
        addView(checkBoxButton)
        addView(descriptionForButton)
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .clear
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        NSLayoutConstraint.activate([
            checkBoxButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 2),
            checkBoxButton.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            checkBoxButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18),
            checkBoxButton.widthAnchor.constraint(equalToConstant: 24),
            checkBoxButton.heightAnchor.constraint(equalToConstant: 24),
            
            descriptionForButton.leadingAnchor.constraint(equalTo: checkBoxButton.trailingAnchor, constant: 12),
            descriptionForButton.centerYAnchor.constraint(equalTo: checkBoxButton.centerYAnchor)
        ])
    }
}
