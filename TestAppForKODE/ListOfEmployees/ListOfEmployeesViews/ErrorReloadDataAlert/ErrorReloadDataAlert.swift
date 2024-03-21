//
//  ErrorReloadDataAlert.swift
//  TestAppForKODE
//
//  Created by Kirill on 21.03.2024.
//

import BaseUIComponents

enum ErrorReloadDataAlertState {
    case networkConnectionError
    case errorFromServer
}

protocol ErrorReloadDataAlertProtocol: AnyObject {
    func closeAlert()
}

class ErrorReloadDataAlert: BaseView {
    
    let message: UITextView = {
        let textView = UITextView()
        textView.textAlignment = .left
        textView.isSelectable = false
        textView.isEditable = false
        textView.font = Resources.Founts.interMedium(with: 13)
        textView.textColor = Resources.Colors.empliyeeProfileBacground
        textView.backgroundColor = UIColor(hexString: "#F44336")
        textView.textContainerInset = .zero
        return textView
        
    }()
    
    var state: ErrorReloadDataAlertState {
        didSet {
            setNeedsLayout()
        }
    }
    
    weak var delegaate: ErrorReloadDataAlertProtocol?
    
    init(state: ErrorReloadDataAlertState) {
        self.state = state
        super.init(frame: .zero)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        switch state {
        case .networkConnectionError:
            message.text = "Не могу обновить данные. \nПроверь соединение с интернетом"
        case .errorFromServer:
            message.text = "Не могу обновить данные. \nЧто-то пошло не так"
        }
    }
    
    lazy var affineTransform = CGAffineTransform.init(translationX: 0, y: self.frame.height)
    
    
    private enum StateShow {
        case open
        case cloase
    }
    private var stateShow: StateShow = .cloase
}

extension ErrorReloadDataAlert {
    override func setupViews() {
        super.setupViews()
        addView(message)
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = UIColor(hexString: "#F44336")
        
        let gesture = UITapGestureRecognizer()
        addGestureRecognizer(gesture)
        gesture.addTarget(self, action: #selector(tupGesture))
    }
    
    func setupLayaoutForSuperView() {
        let height = (Resources.Size.sizeStatusBar?.height ?? 44) + 52
        print(height)
        
        guard let superView = superview else { return }
        NSLayoutConstraint.activate([
            bottomAnchor.constraint(equalTo: superView.topAnchor),
            leadingAnchor.constraint(equalTo: superView.leadingAnchor),
            trailingAnchor.constraint(equalTo: superView.trailingAnchor),
            heightAnchor.constraint(equalToConstant: height),
            
            message.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
            message.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            message.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -24),
            message.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        self.layoutIfNeeded()
    }
    
    func openAlert() {
        self.stateShow = .open
        UIView.animate(withDuration: 0.5) {
            self.transform = self.affineTransform
        } completion: { _ in
            if self.stateShow == .open {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.closeAlert()
                }
            }
        }
    }
    
    @objc func tupGesture() {
        closeAlert()
    }
    
    private func closeAlert() {
        delegaate?.closeAlert()
        if stateShow == .open {
            self.stateShow = .cloase
            UIView.animate(withDuration: 0.5) {
                self.transform = self.affineTransform.inverted()
            } completion: { _ in
                self.removeFromSuperview()
            }
        }
    }
}
