//
//  MockCellForTableView.swift
//  TestAppForKODE
//
//  Created by Kirill on 19.03.2024.
//

import BaseUIComponents

// MARK: - ячейки первоначального отображения таблицы во время ожидания загрузки данных из интернета
final class MockCellForTableView: BaseTableViewCell {
    static let reuseIdentifier = String(describing: MockCellForTableView.self)
    
    var mockViewCell = MockIViewForTableViewCell()
}
extension MockCellForTableView {
    
    override func setupViews() {
        super.setupViews()
        contentView.addView(mockViewCell)
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        NSLayoutConstraint.activate([
            mockViewCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            mockViewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            mockViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mockViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mockViewCell.heightAnchor.constraint(equalToConstant: 84),
            
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        selectionStyle = .none
        backgroundColor = Resources.Colors.empliyeeProfileBacground
    }
}
