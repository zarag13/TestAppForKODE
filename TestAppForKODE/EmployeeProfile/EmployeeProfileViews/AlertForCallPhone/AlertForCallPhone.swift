//
//  AlertForCallPhone.swift
//  TestAppForKODE
//
//  Created by Kirill on 20.03.2024.
//

import BaseUIComponents


/// Description: Алерт при нажатии на телефон - вызов номера
final class AlertForCallPhone: BaseView {
    let phoneButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hexString: "#CACACA")
        button.setTitleColor(UIColor(hexString: "#323232"), for: .normal)
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отмена", for: .normal)
        button.setTitleColor(UIColor(hexString: "#323232"), for: .normal)
        button.backgroundColor = UIColor(hexString: "#FFFFFF")
        return button
    }()
    
    let blureView = BlurEffectView()
    
    let superView: UIView
    
    init(superView: UIView, phone: String) {
        self.superView = superView
        phoneButton.setTitle(phone, for: .normal)
        super.init(frame: .zero)
    }
    
    var affine: CGAffineTransform?
}

extension AlertForCallPhone {
    override func setupViews() {
        super.setupViews()
        insertSubview(blureView, at: 0)
        blureView.translatesAutoresizingMaskIntoConstraints = false
        
        addView(cancelButton)
        addView(phoneButton)
        phoneButton.makeSystemButtonAnimation()
        cancelButton.makeSystemButtonAnimation()
        
        phoneButton.addTarget(self, action: #selector(callPhone), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(closeAlert), for: .touchUpInside)
    }
    
    @objc func callPhone() {
        guard let phoneNumber = phoneButton.title(for: .normal) else { return }
        
        if let url = URL(string: "tel://\(phoneNumber)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                print("Can't open url on this device")
            }
        }
    }
    
    @objc func closeAlert() {
        
        UIView.animate(withDuration: 2) {
            self.transform = self.affine!.inverted()
        } completion: { state in
            self.removeFromSuperview()
        }
    }
    
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = UIColor(hexString: "#000000").withAlphaComponent(0.6)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        phoneButton.layer.cornerRadius =  13
        cancelButton.layer.cornerRadius =  13   
    }
}

extension AlertForCallPhone {
    func addConstraintForSuperView() {
        print(superView.frame.height)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.bottomAnchor),
            centerXAnchor.constraint(equalTo: superView.centerXAnchor),
            widthAnchor.constraint(equalToConstant: superView.frame.width),
            heightAnchor.constraint(equalToConstant: superView.frame.height),
        ])
        
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
        self.layoutIfNeeded()
    }
    
    func showAlert() {
        UIView.animate(withDuration: 0.8) {
            self.affine = CGAffineTransform.init(translationX: 0, y: -self.superView.frame.height)
            self.transform = self.affine!
        }
    }
}
