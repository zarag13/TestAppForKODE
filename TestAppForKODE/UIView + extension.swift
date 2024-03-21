//
//  UIView + extension.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import UIKit

extension UIView {
    
    
    /// Description: объеденяет в себе добавление view и отключение translatesAutoresizingMaskIntoConstraints
    func addView(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
