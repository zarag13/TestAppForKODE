//
//  BackButtonView.swift
//  TestAppForKODE
//
//  Created by Kirill on 15.03.2024.
//

import BaseUIComponents

protocol BackButtonViewProtocol: AnyObject {
    func goBack()
}


class BackButtonView: BaseView {
    weak var backButtonViewDelegate: BackButtonViewProtocol?
}

extension BackButtonView {
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .clear
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(tapGesture))
        addGestureRecognizer(gesture)
    }
    
    @objc func tapGesture() {
        backButtonViewDelegate?.goBack()
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        
    }
    
    override func setupViews() {
        super.setupViews()
        
    }
}

extension BackButtonView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawBackButtonImage()
        
    }
    func drawBackButtonImage() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: frame.size.width - (frame.size.width / 100 * 17), y: frame.size.height - (frame.size.height / 100 * 10)))
        path.addLine(to: CGPoint(x: 0 + (frame.size.width / 100 * 20), y: frame.size.height / 2))
        path.addLine(to: CGPoint(x: frame.size.width - (frame.size.width / 100 * 17), y: 0 + (frame.size.height / 100 * 10)))
        path.lineWidth = frame.size.width / 3
        path.lineCapStyle = .round
        path.lineJoinStyle = .round
        let strokeColor = UIColor(hexString: "#050510")
        strokeColor.setStroke()
        path.stroke()
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
            return bounds.insetBy(dx: -50, dy: -50).contains(point)
    }
}
