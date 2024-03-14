//
//  MockViewForTableViewCell.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import BaseUIComponents

class MockViewForTableViewCell: BaseView {
    let avatarImage: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
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

extension MockViewForTableViewCell {
    override func setupViews() {
        layer.addSublayer(gradient)
    }
    
    override func configureAppearance() {
        #warning("хорошая анимация но нужно сделать градиент отдельным view и менять у него alpa - что бы было не важно в какой момент остановится анимация - и что будет с его alpha - иначе потом текст будет прозранчый, при неудачной остановке, а может вообще ее убрать??")
        var animator: UIViewPropertyAnimator!

        func start(_ reversed: Bool = false) {
            animator = UIViewPropertyAnimator(duration: 1.5, curve: .easeInOut)
            animator.addAnimations {
                if reversed == true {
                    self.alpha = 0
                } else {
                    self.alpha = 1
                }
            }
            animator.addCompletion { _ in
                start(!reversed)
            }
            animator.startAnimation()
        }

        func stop() {
            animator.stopAnimation(true)
        }
        
        start(true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            stop()
        }
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradient.frame = bounds
        switch styleView {
        case .title:
            gradient.cornerRadius = frame.height / 2
        case .avatar:
            gradient.cornerRadius = frame.width / 2
        }
    }
}

extension MockViewForTableViewCell {
    
    enum ViewStyle {
        
        enum TitleStile {
            case name
            case position
        }
        
        case title
        case avatar
    }
    
    func configureViewWithTitle(title: String, style: ViewStyle.TitleStile) {
        addView(titleLabel)
        gradient.removeFromSuperlayer()
        titleLabel.text = title
        switch style {
        case .name:
            titleLabel.textColor = Resources.Colors.titleTextColor
            titleLabel.font = Resources.Founts.interMedium(with: 16)
        case .position:
            titleLabel.textColor = Resources.Colors.metaTextColor
            titleLabel.font = Resources.Founts.interRegular(with: 13)
        }
        setupLayout(view: titleLabel)
        
    }
    func configureViewWithAvatarImage(image: UIImage) {
        addView(avatarImage)
        gradient.removeFromSuperlayer()
        avatarImage.image = image
        setupLayout(view: avatarImage)
    }
}

extension MockViewForTableViewCell {
    func setupLayout(view: UIView) {
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
