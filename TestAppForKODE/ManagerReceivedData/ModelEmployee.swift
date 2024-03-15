//
//  ModelEmployee.swift
//  TestAppForKODE
//
//  Created by Kirill on 14.03.2024.
//

import UIKit

struct Employee {
    var id: String
    var firstName: String
    var lastName: String
    var department: String
    var position: String
    
    //зделать его lowercased()
    var userTag: String
    //Переделать номер(phone) телефона c 802-623-1785 -> к для UI +7 (999) 900 90 90  -> для вызова tel://\(+79969593262)
    var phone: String
    //Переделать ссылку картинки String в UIIMage (avatarUrl)
    var avatarImage: UIImage
    // "birthday": "2004-08-02", - переделать в 5 июня 1996
    var birthday: String
    // 24 года
    var currentAge: String
}
