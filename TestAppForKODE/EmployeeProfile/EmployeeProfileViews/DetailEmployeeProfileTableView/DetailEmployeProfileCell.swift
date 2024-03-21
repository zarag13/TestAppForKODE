//
//  DetailEmployeProfileCell.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import BaseUIComponents


class DetailEmployeProfileCell: BaseTableViewCell {
    
    static let reuseIdentifier = String(describing: DetailEmployeProfileCell.self)
    
    var conentViewForCell = ContentViewForDetailTableViewCell()
}


extension DetailEmployeProfileCell {
    
    override func setupViews() {
        super.setupViews()
        contentView.addView(conentViewForCell)
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        NSLayoutConstraint.activate([
            conentViewForCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            conentViewForCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            conentViewForCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            conentViewForCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = Resources.Colors.empliyeeProfileBacground
    }
}


extension DetailEmployeProfileCell {
    func configure(image: UIImage, firstTitle: String, secondTitle: String?) {
        conentViewForCell.iconView.image = image
        conentViewForCell.firstTitle.text = firstTitle
        guard let secondText = secondTitle else { return }
        conentViewForCell.secondaryTitle.text = secondText
    }
}

