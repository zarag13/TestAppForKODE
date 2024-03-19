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
        //MARK: - textColor
        static var titleTextColor = UIColor(hexString: "#050510")
        static var metaTextColor = UIColor(hexString: "#97979B")
        static var subtittleTextColor = UIColor(hexString: "#55555C")
        static var titleErrorTextColor = UIColor(hexString: "#6534FF")
        
        //MARK: - backgroundColor
        static var mainViewBackgroundColor = UIColor(hexString: "#E5E5E5")
        static var employeeProfileView = UIColor(hexString: "#F7F7F8")
        static var empliyeeProfileBacground = UIColor(hexString: "#FFFFFF")
        
        //MARK: -
        static var birthdayHeader = UIColor(hexString: "#C3C3C6")
    }
    
    enum Image {
        static var starIcon = UIImage(named: "star")
        static var phoneIcon = UIImage(named: "phone")
        static var magnifyingGlass = UIImage(named: "magnifying-glass")
        
        static var mockAvatarImage = "mockAvatarImage"
        static var flyingSaucer = "flyingSaucer"
    }
    
    //MARK: - lits of fonts for progect
    enum Founts {
        static func interMedium(with size: CGFloat) -> UIFont {
            UIFont(name: "Inter-Medium", size: size) ?? UIFont()
        }
        static func interRegular(with size: CGFloat) -> UIFont {
            UIFont(name: "Inter-Regular", size: size) ?? UIFont()
        }
        static func interBold(with size: CGFloat) -> UIFont {
            UIFont(name: "Inter-Bold", size: size) ?? UIFont()
        }
    }
    
    enum Size {
        static var sizeStatusBar: CGRect? {
            let appDelegate = (UIApplication.shared.connectedScenes.first as! UIWindowScene).windows.first
            let size = appDelegate?.windowScene?.statusBarManager?.statusBarFrame
            return size
        }
    }
    
    
}
