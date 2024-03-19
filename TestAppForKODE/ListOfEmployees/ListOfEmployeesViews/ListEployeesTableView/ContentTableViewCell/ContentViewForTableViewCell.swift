//
//  ContentViewForTableViewCell.swift
//  TestAppForKODE
//
//  Created by Kirill on 18.03.2024.
//

import BaseUIComponents

class ContentViewForTableViewCell: BaseView {
    let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.titleTextColor
        label.font = Resources.Founts.interMedium(with: 16)
        //не будет растягиваться( не создавая пустое место) - величина view == контенту
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.subtittleTextColor
        label.font = Resources.Founts.interRegular(with: 13)
        return label
    }()
    
    let metaTitle: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.metaTextColor
        label.textAlignment = .left
        label.font = Resources.Founts.interMedium(with: 15)
        //будет растягиваться(создавая пустое место)
        label.setContentHuggingPriority(.defaultLow, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    let birthdayTitle: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.subtittleTextColor
        label.font = Resources.Founts.interRegular(with: 15)
        //не будет растягиваться( не создавая пустое место)
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
}

extension ContentViewForTableViewCell {
    override func setupViews() {
        super.setupViews()
        [avatarImage, titleLabel, subTitleLabel, metaTitle, birthdayTitle].forEach { view in
            addView(view)
        }
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .clear
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            avatarImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            avatarImage.widthAnchor.constraint(equalTo: avatarImage.heightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: avatarImage.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 16),
            
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3),
            subTitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            
            
            metaTitle.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 4),
            metaTitle.trailingAnchor.constraint(equalTo: birthdayTitle.leadingAnchor, constant: -4),
            metaTitle.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            
            birthdayTitle.topAnchor.constraint(equalTo: topAnchor, constant: 28),
            //birthdayTitle.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            birthdayTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -4)
        ])
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImage.layer.cornerRadius = avatarImage.frame.width / 2
    }
}
