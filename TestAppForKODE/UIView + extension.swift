//
//  UIView + extension.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import UIKit

extension UIView {
    
    func addView(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
}
