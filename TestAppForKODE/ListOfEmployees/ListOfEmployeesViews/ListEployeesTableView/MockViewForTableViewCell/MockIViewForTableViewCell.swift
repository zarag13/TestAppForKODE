//
//  MockIViewForTableViewCell.swift
//  TestAppForKODE
//
//  Created by Kirill on 18.03.2024.
//

import BaseUIComponents

// MARK: - view для ячейки первоначального отображения таблицы
final class MockIViewForTableViewCell: BaseView {
    let avatarImage = MockItemForTableViewCell(styleView: .avatar)
    let titleLabel = MockItemForTableViewCell(styleView: .title)
    let subTitleLabel = MockItemForTableViewCell(styleView: .title)
}

extension MockIViewForTableViewCell {
    override func setupViews() {
        super.setupViews()
        [avatarImage, titleLabel, subTitleLabel].forEach { view in
            addView(view)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = Resources.Colors.empliyeeProfileBacground
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            avatarImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatarImage.widthAnchor.constraint(equalTo: avatarImage.heightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: avatarImage.topAnchor, constant: 19),
            titleLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 16),
            titleLabel.widthAnchor.constraint(equalToConstant: 144),
            titleLabel.heightAnchor.constraint(equalToConstant: 16),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subTitleLabel.widthAnchor.constraint(equalToConstant: 80),
            subTitleLabel.heightAnchor.constraint(equalToConstant: 12),
        ])
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
