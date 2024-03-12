//
//  UIView + extension.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import UIKit

extension UIView {
    
    func makeSystem(_  button: UIButton) {
        button.addTarget(self, action: #selector(handeIn), for: [.touchDown, .touchDragInside])
        button.addTarget(self, action: #selector(handeOut), for: [.touchDragOutside, .touchUpInside, .touchUpOutside, .touchDragExit, .touchCancel])
    }
    
    @objc func handeIn() {
        UIView.animate(withDuration: 0.15) {
            self.alpha = 0.55
            
        }
    }
    @objc func handeOut() {
        UIView.animate(withDuration: 0.15) {
            self.alpha = 1
            
        }
    }
    
    func addView(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
