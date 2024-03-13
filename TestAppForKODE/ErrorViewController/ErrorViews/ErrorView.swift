//
//  ErrorView.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import Foundation
import BaseUIComponents


class ErrorView : BaseView {
    
    let stackView = ErrorStackSubview()
    
}

extension ErrorView {
    override func setupViews() {
        super.setupViews()
        addView(stackView)
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor,constant: 22)
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = Resources.Colors.empliyeeProfileBacground
    }
}

extension ErrorView {
    func congigurationView(data: ErrorData, controller: ButtonForReloadDataProtocol?) {
        stackView.congigurationSTackView(data: data, controller: controller)
    }
}
