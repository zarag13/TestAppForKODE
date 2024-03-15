//
//  ManagerProcessingdData.swift
//  TestAppForKODE
//
//  Created by Kirill on 14.03.2024.
//

import UIKit

class ManagerProcessingdData {
    //Логика
    //Iteractor обращается к NetworkNagare - он отдает Result
    //В Result мы обращаемся к этому менеджеру, он будет принимать дефолтный массив данных - обрабаотываеть их и возращать уже необходимые данные
    
    //1. Основной метод в котором произойдет преобразование
    var taskForDownloadAvatarImage: CreaterTaskForSession?
    
    let semaf = DispatchSemaphore(value: 0)
    
    func processingDecoderJSONData(data: ModelEmployeeList, task: CreaterTaskForSession) -> [Employee] {
        taskForDownloadAvatarImage = task

        let jsonData = data.employee
        
        var newData = [Employee]()

        newData = jsonData.map({ user -> Employee in
            return Employee(id: user.id,
                           firstName: user.firstName,
                           lastName: user.lastName,
                           department: user.department,
                           position: user.position,
                           userTag: lowerTag(name: user.userTag),
                           phone: processingPhoneNumber(phone: user.phone), // +79969593262
                           avatarImage: downloadImage(url: user.avatarUrl),
                           birthday: processingBirthday(date: user.birthday),
                           currentAge: createCurrentAgefromBirthday(date: user.birthday))
        })
        return newData
        
    }
    
    
    private func lowerTag(name: String) -> String {
        return name.lowercased()
    }
    
    private func processingPhoneNumber(phone: String) -> String {
        let result = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        return "+7\(result)"
    }
    
    private func downloadImage(url: String) -> UIImage {
        //здесь делаем запрос к API
        //если sesess - возвращаем скаченную
        //если failure - возвращаем моку
        
        var image = UIImage()
        
        self.taskForDownloadAvatarImage?.employeeDownloadAvatarImageTask(url: url, completion: { result in
            switch result {
            case .success(let data):
                image = UIImage(data: data)!
                self.semaf.signal()
            case .failure(let error):
                image = UIImage(named: Resources.Image.mockAvatarImage)!
                self.semaf.signal()
            }
        })
        semaf.wait()
        
        
        return image
    }
    
    
    
    private func processingPhoneNumberWithSeparate(phone: String) -> String {
        //+79969593262
        //+7 (999) 900 90 90
        var result = phone
        let next = result.index(after: result.firstIndex(of: "7")!)
        result.insert("(", at: next)
        let next2 = result.index(next, offsetBy: 4)
        result.insert(" ", at: next2)
        result.insert(")", at: next2)
        let end1 = result.index(result.endIndex, offsetBy: -2)
        result.insert(" ", at: end1)
        let end2 = result.index(result.endIndex, offsetBy: -5)
        result.insert(" ", at: end2)
        return result
    }
    
    private func processingBirthday(date: String) -> String {
        
        //на основе строки создает дату
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: date)
        
        
        //на основе даты создаем строку - используя уже другой формат
        let dateFormatter2 = DateFormatter()
        //1. Локализация
        dateFormatter2.locale = Locale(identifier: "ru_RU")
        //2. тоже самое что и dateFormat
        dateFormatter2.setLocalizedDateFormatFromTemplate("dd MMMM YYYY")
        var dateString = dateFormatter2.string(from: date!)
        //02 августа 2004 г.
        
        
        //убираем лишнее из строки
        let tldEndIndex = dateString.endIndex
        let tldStartIndex = dateString.index(tldEndIndex, offsetBy: -2)
        let range = Range(uncheckedBounds: (lower: tldStartIndex, upper: tldEndIndex)) // г.
        dateString.removeSubrange(range)
        
        return dateString
    }
    
    private func createCurrentAgefromBirthday(date: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateBirthday = dateFormatter.date(from: date)
        
        let differencesDate = Calendar.current.dateComponents([.year], from: dateBirthday!, to: Date.now)
        
        let ageInt = differencesDate.year!

        //кейс год - закончен
        if ageInt % 10 == 1 && ageInt % 100 != 11 {
            //тут попадут только все числа которые заканчиваются на 1 при делении на 10 (1-11-21-31)
            //что бы защититься от 11 - это лет - мы еще делим на 100 - что бы исключить только 11
            //1-21-31
            return "\(ageInt) год"
        } else if ageInt % 10 >= 2 && ageInt % 10 <= 4  && (ageInt % 100 < 10 || ageInt % 100 >= 20) {
            //кейс года
            //все числа которые больше 1 (2-3-4)  ----  ageInt % 10 >= 2
            //все числа которые меньше 5 -> лет  ------ ageInt % 10 <= 4
            //и это число меньше 10 или больше 20 ------- (ageInt % 100 < 10 || ageInt % 100 >= 20) - что бы исключить 13-14-15
            return "\(ageInt) года"
        } else {
            return "\(ageInt) лет"
        }
    }
    
}

