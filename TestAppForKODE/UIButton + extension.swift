//
//  UIButton + extension.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import UIKit

extension UIButton {
    
    /// Description: добавляет кнопке анимацию мигания
    func makeSystemButtonAnimation() {
        self.addTarget(self, action: #selector(handeIn), for: [.touchDown, .touchDragInside])
        self.addTarget(self, action: #selector(handeOut), for: [.touchDragOutside, .touchUpInside, .touchUpOutside, .touchDragExit, .touchCancel])
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
}
