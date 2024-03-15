//
//  CategoriesCollectionViewCell.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import BaseUIComponents

class CategoriesCollectionViewCell: BaseCollectionViewCell{
    
    static let reuseIdentifier = String(describing: CategoriesCollectionViewCell.self)
    
    private let categoryNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Resources.Founts.interMedium(with: 15)
        label.textColor = Resources.Colors.metaTextColor
        return label
    }()
    
    
    ///11111
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.titleErrorTextColor
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            categoryNameLabel.textColor = isSelected ? Resources.Colors.titleTextColor : Resources.Colors.metaTextColor
            categoryNameLabel.font = isSelected ? Resources.Founts.interBold(with: 15): Resources.Founts.interMedium(with: 15)
            lineView.isHidden = isSelected ? false : true
        }
    }
}

extension CategoriesCollectionViewCell {
    override func setupViews() {
        contentView.addView(categoryNameLabel)
        contentView.addView(lineView)
        lineView.isHidden = true
    }
    
    override func setupLayoutViews() {
        print(contentView.frame.size.width)
        NSLayoutConstraint.activate([
            categoryNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            categoryNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 2),
            lineView.widthAnchor.constraint(equalToConstant: contentView.frame.width),
        ])
    }
    
    override func configureAppearance() {
        backgroundColor = .white
    }
}

extension CategoriesCollectionViewCell {
    func configure(title: String) {
        categoryNameLabel.text = title
    }
}
