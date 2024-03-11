//
//  Resources.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import UIKit

enum Resources {
    
    //MARK: - lits of color for progect
    enum Colors {
        static var titleTextColor = UIColor(hexString: "#050510")
        static var metaTextColor = UIColor(hexString: "#97979B")
        static var subtittleTextColor = UIColor(hexString: "#55555C")
        static var titleErrorTextColor = UIColor(hexString: "#6534FF")
        
        
        
        
    }
    
    //MARK: - lits of fonts for progect
    enum Founts {
        static func internalMedium(with size: CGFloat) -> UIFont {
            UIFont(name: "Inter-Medium", size: size) ?? UIFont()
        }
        static func internalRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Inter-Regular", size: size) ?? UIFont()
        }
    }
    
    
}
