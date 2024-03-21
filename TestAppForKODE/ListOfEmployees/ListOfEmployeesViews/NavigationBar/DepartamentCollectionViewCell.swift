//
//  DepartamenCollectionViewCell.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import BaseUIComponents

//MARK: - ячека которая отображает список объектов для фильтрации данных
final class DepartamentCollectionViewCell: BaseCollectionViewCell{
    
    static let reuseIdentifier = String(describing: DepartamentCollectionViewCell.self)
    
    private let departamentNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = Resources.Founts.interMedium(with: 15)
        label.textColor = Resources.Colors.metaTextColor
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = Resources.Colors.titleErrorTextColor
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            departamentNameLabel.textColor = isSelected ? Resources.Colors.titleTextColor : Resources.Colors.metaTextColor
            departamentNameLabel.font = isSelected ? Resources.Founts.interBold(with: 15): Resources.Founts.interMedium(with: 15)
            lineView.isHidden = isSelected ? false : true
        }
    }
}

extension DepartamentCollectionViewCell {
    override func setupViews() {
        contentView.addView(departamentNameLabel)
        contentView.addView(lineView)
        lineView.isHidden = true
    }
    
    override func setupLayoutViews() {
        NSLayoutConstraint.activate([
            departamentNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            departamentNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 2),
            lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    override func configureAppearance() {
        backgroundColor = .white
    }
}

extension DepartamentCollectionViewCell {
    func configure(title: String) {
        departamentNameLabel.text = title
    }
}
