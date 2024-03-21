//
//  EmployeeProfileView.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import UIKit
import BaseUIComponents


/// Description: первая view с аватаркой и именем
final class ProfileView: BaseView {
    
    //MARK: - crate uiComponents
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Founts.interBold(with: 24)
        label.textColor = Resources.Colors.titleTextColor
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.textAlignment = .center
        return label
    }()
    lazy var markingLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Founts.interRegular(with: 17)
        label.textColor = Resources.Colors.metaTextColor
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        label.textAlignment = .left
        return label
    }()

    lazy var professionLabel: UILabel = {
        let label = UILabel()
        label.font = Resources.Founts.interRegular(with: 13)
        label.textColor = Resources.Colors.subtittleTextColor
        label.textAlignment = .center
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    lazy var avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
}


//MARK: - extension -> override base functions
extension ProfileView {
    
    override func setupViews() {
        super.setupViews()
        
        [avatarImage, nameLabel, markingLabel, professionLabel].forEach { item in
            addView(item)
        }
        
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: topAnchor, constant: 72),
            avatarImage.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarImage.widthAnchor.constraint(equalToConstant: 104),
            avatarImage.heightAnchor.constraint(equalToConstant: 104),
            
            nameLabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor, constant: 24),
            nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            markingLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 5),
            markingLabel.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            
            professionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 11),
            professionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            professionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
        ])
        
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = Resources.Colors.employeeProfileView
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImage.layer.cornerRadius = avatarImage.frame.width / 2
    }
}


//MARK: - func configure contents for View
extension ProfileView {
    
    func configureView(employee: Employee, avatar: UIImage) {
        self.avatarImage.image = avatar
        self.nameLabel.text = "\(employee.firstName) \(employee.lastName)"
        self.markingLabel.text = employee.userTag
        self.professionLabel.text = employee.position
    }
}
