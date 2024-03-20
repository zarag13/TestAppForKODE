//
//  AlertForCallPhone.swift
//  TestAppForKODE
//
//  Created by Kirill on 20.03.2024.
//

import BaseUIComponents

class AlertForCallPhone: BaseView {
    let phoneButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexString: "#F5F5F5")
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отмена", for: .normal)
        button.backgroundColor = UIColor(hexString: "#FFFFFF")
        return button
    }()
    
    let blureView: UIVisualEffectView = {
        let view = UIVisualEffectView()
        let blureEffect = UIBlurEffect(style: .regular)
        view.effect = blureEffect
        return view
    }()
    
    let superView: UIView
    
    init(superView: UIView) {
        self.superView = superView
        let frame = CGRect(x: superView.frame.origin.x, y: superView.frame.maxY, width: superView.frame.width, height: superView.frame.height)
        super.init(frame: frame)
    }
    
    var topActorForAnimate: NSLayoutConstraint?
    
}

extension AlertForCallPhone {
    override func setupViews() {
        super.setupViews()
        addView(blureView)
        blureView.contentView.addView(cancelButton)
        blureView.contentView.addView(phoneButton)
        
        phoneButton.addTarget(self, action: #selector(callPhone), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(closeAlert), for: .touchUpInside)
    }
    
    @objc func callPhone() {
        
    }
    
    @objc func closeAlert() {
        topActorForAnimate = topAnchor.constraint(equalTo: superView.bottomAnchor)
        topActorForAnimate?.isActive = true
        
        UIView.animate(withDuration: 2) {
            self.alpha = 0
            self.layoutIfNeeded()
        } completion: { state in
            self.removeFromSuperview()
        }
    }
    
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        
        NSLayoutConstraint.activate([
            blureView.topAnchor.constraint(equalTo: topAnchor),
            blureView.leadingAnchor.constraint(equalTo: leadingAnchor),
            blureView.trailingAnchor.constraint(equalTo: trailingAnchor),
            blureView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            
            //cancelButton
            cancelButton.bottomAnchor.constraint(equalTo: blureView.contentView.bottomAnchor, constant: -32),
            cancelButton.leadingAnchor.constraint(equalTo: blureView.contentView.leadingAnchor, constant: 8),
            cancelButton.trailingAnchor.constraint(equalTo: blureView.contentView.trailingAnchor, constant: -8),
            cancelButton.heightAnchor.constraint(equalToConstant: 60),
            //phoneButton
            
            phoneButton.bottomAnchor.constraint(equalTo: cancelButton.topAnchor, constant: -8),
            phoneButton.leadingAnchor.constraint(equalTo: blureView.contentView.leadingAnchor, constant: 8),
            phoneButton.trailingAnchor.constraint(equalTo: blureView.contentView.trailingAnchor, constant: -8),
            phoneButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .clear
        alpha = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        phoneButton.layer.cornerRadius = phoneButton.frame.height / 13
        cancelButton.layer.cornerRadius = phoneButton.frame.height / 13
    }
}

extension AlertForCallPhone {
    func showAlert() {
        print(superView.frame)
        
        self.setNeedsLayout()
        UIView.animate(withDuration: 2) {
            self.transform = CGAffineTransform.init(translationX: self.frame.origin.x, y: super.frame.origin.y)
            self.alpha = 1
            self.setNeedsLayout()
        }

        
//        topActorForAnimate = topAnchor.constraint(equalTo: superView.bottomAnchor, constant: -20)
//        print(superView.frame.height)
//        NSLayoutConstraint.activate([
//            topActorForAnimate!,
//            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
//            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
//            centerYAnchor.constraint(equalTo: superView.centerYAnchor),
//            heightAnchor.constraint(equalToConstant: superView.frame.height)
//        ])
//        
//        
//        topActorForAnimate?.isActive = false
//        topActorForAnimate = topAnchor.constraint(equalTo: superView.topAnchor)
//        topActorForAnimate?.isActive = true
//        self.layoutIfNeeded()
//        UIView.animate(withDuration: 2) {
//            self.alpha = 1
//            self.layoutIfNeeded()
//        }
    }
}
