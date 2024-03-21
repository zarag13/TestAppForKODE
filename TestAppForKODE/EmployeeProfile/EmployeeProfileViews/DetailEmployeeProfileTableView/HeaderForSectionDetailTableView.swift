//
//  HeaderForSectionDetailTableView.swift
//  TestAppForKODE
//
//  Created by Kirill on 19.03.2024.
//

import UIKit

class HeaderForSectionDetailTableView: UITableViewHeaderFooterView {
    
    static let reuseIdentifier = String(describing: HeaderForSectionDetailTableView.self)
    
    let lineView = UIView()
    
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

extension HeaderForSectionDetailTableView {
    func setupViews() {
        contentView.addView(lineView)
        lineView.backgroundColor = Resources.Colors.employeeProfileView
    }
    func setupLayoutViews() {
        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }
}
