//
//  SortedCheckBoxButton.swift
//  TestAppForKODE
//
//  Created by Kirill on 16.03.2024.
//

import BaseUIComponents

enum CheckBoxButtonState {
    case selected
    case deselected
}

protocol SortedCheckBoxButtonProtocol: AnyObject {
    func selectCheckBox(sortedCeckBoox: CheckBoxState)
}

class SortedCheckBoxButton: BaseView {
    
    let circleLayer = CAShapeLayer()
    
    private var noSotredCheckBoxState: CheckBoxState = .none
    var sotredCheckBoxState : CheckBoxState = .none
    
    var changeState: CheckBoxButtonState = .deselected {
        didSet {
            switch changeState {
            case .selected:
                delegate?.selectCheckBox(sortedCeckBoox: sotredCheckBoxState)
            case .deselected:
                delegate?.selectCheckBox(sortedCeckBoox: noSotredCheckBoxState)
            }
            circleLayer.removeFromSuperlayer()
            setNeedsLayout()
        }
    }
    
    weak var delegate: SortedCheckBoxButtonProtocol?
    
}

extension SortedCheckBoxButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.width / 2
        
        switch changeState {
        case .selected:
            createCircleImage(width: 12)
        case .deselected:
            createCircleImage(width: 2)
        }
    }
    
    func createCircleImage(width: CGFloat) {
        let offset: CGFloat = 2
        let newFrame = CGRect(origin: CGPoint(x: bounds.origin.y + offset, y: bounds.origin.x + offset),
                              size: CGSize(width: frame.width - (offset * 2), height: frame.height - (offset * 2)))
        
        let path = UIBezierPath(ovalIn: newFrame)
        circleLayer.strokeColor = Resources.Colors.titleErrorTextColor.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.path = path.cgPath
        circleLayer.lineWidth = width
        self.layer.addSublayer(circleLayer)
    }
}

extension SortedCheckBoxButton {
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .clear
        clipsToBounds = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(selectCheckBox))
        addGestureRecognizer(gesture)
    }
    
    @objc func selectCheckBox() {
        let newValue: CheckBoxButtonState = changeState == .deselected ? .selected : .deselected
        changeState = newValue
        print(changeState)
    }
}
