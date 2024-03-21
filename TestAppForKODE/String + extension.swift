//
//  String + extension.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import UIKit

extension String {
    
    /// Description: узнать ширину строки на основе шрифта 
    func defiendWith(font: UIFont) -> CGFloat {
        let atributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: atributes).width
    }
}
