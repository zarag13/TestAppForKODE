//
//  DetailEmployeProfileCell.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import UIKit
import BaseUIComponents

enum State {
    case one
    case two
}

class DetailEmployeProfileCell: BaseTableViewCell {
    
    static let reuseIdentifier = String(describing: DetailEmployeProfileCell.self)
    
    let firstTitle: UILabel = {
        let label = UILabel()
        label.font = Resources.Founts.interMedium(with: 16)
        label.textColor = Resources.Colors.titleTextColor
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.textAlignment = .center
        return label
    }()
    
    let secondaryTitle: UILabel = {
        let label = UILabel()
        label.font = Resources.Founts.interMedium(with: 16)
        label.textColor = Resources.Colors.metaTextColor
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.textAlignment = .center
        return label
    }()
    
    let iconView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
}


extension DetailEmployeProfileCell {
    
    override func setupViews() {
        super.setupViews()
        [firstTitle, secondaryTitle, iconView].forEach { item in
            contentView.addView(item)
        }
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        NSLayoutConstraint.activate([
            //iconView
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 17),
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
            iconView.widthAnchor.constraint(equalToConstant: 24),
            iconView.heightAnchor.constraint(equalToConstant: 24),
            
            //firstTitle
            firstTitle.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 14),
            firstTitle.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            
            
            //secondaryTitle
            secondaryTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            secondaryTitle.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        contentView.backgroundColor = Resources.Colors.empliyeeProfileBacground
    }
}


extension DetailEmployeProfileCell {
    func configure(user: Employer, state: State) {
        
        switch state {
        case .one:
            self.firstTitle.text = user.date
            self.iconView.image = Resources.Image.starIcon
            self.secondaryTitle.text = user.years
        case .two:
            self.iconView.image = Resources.Image.phoneIcon
            firstTitle.text = user.phoneNumber
            secondaryTitle.text = ""

        }
    }
}
