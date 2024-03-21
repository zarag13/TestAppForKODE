//
//  ContentViewForDetailTableViewCell.swift
//  TestAppForKODE
//
//  Created by Kirill on 19.03.2024.
//

import BaseUIComponents


/// Description: view для ячейки которую будем наполнять контентом
final class ContentViewForDetailTableViewCell: BaseView {
    let firstTitle: UILabel = {
        let label = UILabel()
        label.font = Resources.Founts.interMedium(with: 16)
        label.textColor = Resources.Colors.titleTextColor
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.textAlignment = .left
        return label
    }()
    
    let secondaryTitle: UILabel = {
        let label = UILabel()
        label.font = Resources.Founts.interMedium(with: 16)
        label.textColor = Resources.Colors.metaTextColor
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.textAlignment = .right
        return label
    }()
    
    let iconView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
}

extension ContentViewForDetailTableViewCell {
    override func setupViews() {
        super.setupViews()
        [firstTitle, secondaryTitle, iconView].forEach { item in
            addView(item)
        }
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        NSLayoutConstraint.activate([
            //iconView
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor),
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            iconView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -18),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            
            //firstTitle
            firstTitle.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            firstTitle.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            
            
            //secondaryTitle
            secondaryTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4),
            secondaryTitle.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        
    }
}
