//
//  HeaderCellForBirthdaySorted.swift
//  TestAppForKODE
//
//  Created by Kirill on 19.03.2024.
//

import UIKit

// MARK: - заголовок который будем использовать при фильтрации по дню рождения
final class HeaderCellForBirthdaySorted: UITableViewHeaderFooterView {
    static let reuseIdentifier = String(describing: HeaderCellForBirthdaySorted.self)
    
    let contentHeaderView = HeaderContentView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayoutViews()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HeaderCellForBirthdaySorted {
    func setupViews() {
        contentView.addView(contentHeaderView)
        contentView.backgroundColor = Resources.Colors.empliyeeProfileBacground
    }
    
    func setupLayoutViews() {
        NSLayoutConstraint.activate([
            contentHeaderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            contentHeaderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            contentHeaderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -24),
            contentHeaderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 24),
        ])
    }
}
