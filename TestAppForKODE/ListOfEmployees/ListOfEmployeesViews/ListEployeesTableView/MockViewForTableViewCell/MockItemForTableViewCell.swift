//
//  MockItemForTableViewCell.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import BaseUIComponents

class MockItemForTableViewCell: BaseView {
    enum ViewStyle {
        case title
        case avatar
    }
    
    let gradient: CAGradientLayer = {
        let gradient = CAGradientLayer()
        gradient.colors = [UIColor(hexString: "#F3F3F6").cgColor, UIColor(hexString: "#FAFAFA").cgColor]
        gradient.locations = [0, 1]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        return gradient
    }()
    
    let styleView: ViewStyle
    
    init(styleView: ViewStyle) {
        self.styleView = styleView
        super.init(frame: .zero)
    }
}

extension MockItemForTableViewCell {
    override func setupViews() {
        super.setupViews()
        layer.addSublayer(gradient)
        clipsToBounds = true
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: topAnchor),
            leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    
    override func configureAppearance() {
        super.configureAppearance()
        UIView.animate(withDuration: 1, delay: 0, options: [.repeat, .curveLinear, .autoreverse]) {
            self.alpha = 0
        }

    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradient.frame = bounds
        
        switch styleView {
        case .title:
            layer.cornerRadius = frame.height / 2
        case .avatar:
            layer.cornerRadius = frame.width / 2
        }
    }
}
