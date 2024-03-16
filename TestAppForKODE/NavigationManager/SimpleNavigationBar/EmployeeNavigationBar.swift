//
//  EmployeeNavigationBar.swift
//  TestAppForKODE
//
//  Created by Kirill on 15.03.2024.
//

import BaseUIComponents

class SimpleNavigationBar: BaseView {
    let leftBarButtomItem = BackBarButtonView()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Resources.Founts.interBold(with: 20)
        label.textColor = Resources.Colors.titleTextColor
        return label
    }()
    
    weak var leftBurButtomItemDelegate: BackButtonViewProtocol? {
        didSet {
            leftBarButtomItem.view.backButtonViewDelegate = leftBurButtomItemDelegate
        }
    }
}

extension SimpleNavigationBar {
    override func setupViews() {
        super.setupViews()
        addView(leftBarButtomItem)
        addView(titleLabel)
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .clear
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        NSLayoutConstraint.activate([
            leftBarButtomItem.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            leftBarButtomItem.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4),
            leftBarButtomItem.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4),
            leftBarButtomItem.widthAnchor.constraint(equalToConstant: 96),
            
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
