//
//  BackBarButtonView.swift
//  TestAppForKODE
//
//  Created by Kirill on 15.03.2024.
//

import BaseUIComponents

class BackBarButtonView: BaseView {
    let view = BackButtonView()
}

extension BackBarButtonView {
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .clear
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20.87),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -68.88),
            
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.71),
            view.topAnchor.constraint(equalTo: topAnchor, constant: 16.75),
        ])
    }
    
    override func setupViews() {
        super.setupViews()
        addView(view)
    }
}
