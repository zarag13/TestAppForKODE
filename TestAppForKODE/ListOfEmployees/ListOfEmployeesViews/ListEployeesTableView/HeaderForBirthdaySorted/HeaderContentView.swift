//
//  HeaderContentView.swift
//  TestAppForKODE
//
//  Created by Kirill on 19.03.2024.
//

import BaseUIComponents

// MARK: - view для заголовка который будем использовать при фильтрации по дню рождения
final class HeaderContentView: BaseView {
    
    let leftLineView: UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.birthdayHeader
        return view
    }()
    let rightLineView: UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.birthdayHeader
        return view
    }()
    
    let titleLable: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "2025"
        label.textColor = Resources.Colors.birthdayHeader
        label.font = Resources.Founts.interMedium(with: 16)
        return label
    }()
    
}

extension HeaderContentView {
    override func setupViews() {
        super.setupViews()
        addView(titleLable)
        addView(leftLineView)
        addView(rightLineView)
    }
    
    override func configureAppearance() {
        super.configureAppearance()
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        NSLayoutConstraint.activate([
            //leftLineView
            leftLineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            leftLineView.centerYAnchor.constraint(equalTo: centerYAnchor),
            leftLineView.heightAnchor.constraint(equalToConstant: 1),
            leftLineView.trailingAnchor.constraint(equalTo: titleLable.leadingAnchor, constant: -12),
            //titleLable
            //titleLable.heightAnchor.constraint(equalToConstant: 20),
            titleLable.widthAnchor.constraint(equalToConstant: 160),
            titleLable.topAnchor.constraint(equalTo: topAnchor),
            titleLable.bottomAnchor.constraint(equalTo: bottomAnchor),
            titleLable.centerXAnchor.constraint(equalTo: centerXAnchor),
            //rightLineView
            rightLineView.centerYAnchor.constraint(equalTo: centerYAnchor),
            rightLineView.trailingAnchor.constraint(equalTo: trailingAnchor),
            rightLineView.heightAnchor.constraint(equalToConstant: 1),
            rightLineView.leadingAnchor.constraint(equalTo: titleLable.trailingAnchor, constant: 12)
        ])
    }
}
