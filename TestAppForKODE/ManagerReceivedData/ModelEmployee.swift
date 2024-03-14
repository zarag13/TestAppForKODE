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


class SafeArray<T> {
    //2. Приватный массив, для внутреннего использования
    private var _array = [T]()
    //3. Параллельная очередь, для внутреннего использования
    private let queue = DispatchQueue(label: "myQueue", attributes: .concurrent)

    //4. Метод записи данных в массив(2)
    func append(_ value: T) {
        //5. Асинхронно относительно той очереди где вызываем(например: Main) - записываем данные в массив(2), т.к тут Barrier - создается впечатление что у нас последовательная(serial) очередь
        queue.async(flags: .barrier) {
            self._array.append(value)
        }
    }

    //6. Копьютер проперти - которое синхронно(блокируя другую очредь - делает чтение данных)
    var valueArray: [T] {
        var result = [T]()
        queue.sync {
            result = self._array
        }
        return result
    }
}
