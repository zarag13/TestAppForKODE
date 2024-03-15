//
//  ListOfEmployeesTableViewCell.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import BaseUIComponents

class ListOfEmployeesTableViewCell: BaseTableViewCell {
    let avatarImage = MockViewForTableViewCell(styleView: .avatar)
    let nameTitleLabel = MockViewForTableViewCell(styleView: .title)
    let positionTitleLabel = MockViewForTableViewCell(styleView: .title)
    
    static let reuseIdentifier = String(describing: ListOfEmployeesTableViewCell.self)
}
extension ListOfEmployeesTableViewCell {
    override func setupViews() {
        [avatarImage, nameTitleLabel, positionTitleLabel].forEach { view in
            contentView.addView(view)
        }
    }
    
    override func setupLayoutViews() {
        NSLayoutConstraint.activate([
            //avatarImage
            avatarImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 6),
            avatarImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -6),
            avatarImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            avatarImage.widthAnchor.constraint(equalToConstant: 72),
            avatarImage.heightAnchor.constraint(equalToConstant: 72), //84
            
            //nameTitleLabel
            nameTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            nameTitleLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 16),
            nameTitleLabel.widthAnchor.constraint(equalToConstant: 144),
            nameTitleLabel.heightAnchor.constraint(equalToConstant: 16),
            
            //positionTitleLabel
            positionTitleLabel.topAnchor.constraint(equalTo: nameTitleLabel.bottomAnchor, constant: 6),
            positionTitleLabel.leadingAnchor.constraint(equalTo: nameTitleLabel.leadingAnchor),
            positionTitleLabel.widthAnchor.constraint(equalToConstant: 80),
            positionTitleLabel.heightAnchor.constraint(equalToConstant: 12),
        ])
    }
    
    override func configureAppearance() {
    }
}

extension ListOfEmployeesTableViewCell {
    func configurationCell(employee: Employee) {
        avatarImage.configureViewWithAvatarImage(image: employee.avatarImage)
        let fullName = "\(employee.firstName) \(employee.firstName)"
        nameTitleLabel.configureViewWithTitle(title: fullName, style: .name)
        positionTitleLabel.configureViewWithTitle(title: employee.position, style: .position)
    }
}
