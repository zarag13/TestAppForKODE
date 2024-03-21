//
//  ErrorStackSubview.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import Foundation
import BaseUIComponents

//MARK: - протокол делегирования действия о нажатии на кнопку
protocol ButtonForReloadDataProtocol: AnyObject {
    func reloadData()
}

final class ErrorStackSubview: BaseStackView {
    
    weak var delegate: ButtonForReloadDataProtocol?
    
    private let firstLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.titleTextColor
        label.font = Resources.Founts.interBold(with: 17)
        label.textAlignment = .center
        return label
    }()
    
    private let secondLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.metaTextColor
        label.font = Resources.Founts.interRegular(with: 17)
        label.textAlignment = .center
        return label
    }()
    
    private let reloadButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = Resources.Founts.interBold(with: 16)
        button.setTitleColor(Resources.Colors.titleErrorTextColor, for: .normal)
        return button
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
}

extension ErrorStackSubview {
    override func setupViews() {
        super.setupViews()
        [imageView, firstLabel, secondLabel, reloadButton].forEach { item in
            item.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview(item)
        }
        reloadButton.makeSystemButtonAnimation()
        reloadButton.addTarget(self, action: #selector(repeatDownloadDataForTable), for: .touchUpInside)
    }
    
    @objc func repeatDownloadDataForTable() {
        delegate?.reloadData()
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        alignment = .center
        axis = .vertical
        spacing = 12
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame.size = CGSize(width: 56, height: 56)
        guard let size = reloadButton.titleLabel?.intrinsicContentSize else { return }
        reloadButton.frame.size = size
    }
}

extension ErrorStackSubview {
    //MARK: - заполнения данными эту view
    func congigurationSTackView(data: ErrorData, controller: ButtonForReloadDataProtocol?) {
        firstLabel.text = data.fisrtTitle
        secondLabel.text = data.secondTitle
        imageView.image = UIImage(named: data.imageName)
        reloadButton.setTitle(data.buttonText, for: .normal)
        delegate = controller
    }
}
