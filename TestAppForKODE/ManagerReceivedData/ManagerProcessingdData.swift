//
//  ManagerProcessingdData.swift
//  TestAppForKODE
//
//  Created by Kirill on 14.03.2024.
//

import UIKit


/// Description: Класс который приводит начальные данные полученные при парсинге JSON к тем которые будут использовать в проекте
final class ManagerProcessingdData {
    //Логика
    //Iteractor обращается к NetworkNagare - он отдает Result
    //В Result мы обращаемся к этому менеджеру, он будет принимать дефолтный массив данных - обрабаотываеть их и возращать уже необходимые данные
    
    
    private var taskForDownloadAvatarImage: CreaterTaskForSession?
    
    private let semaf = DispatchSemaphore(value: 0)
    
    
    
    /// Description: Основной метод в котором и происходит сборка новго массива данных
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
                            userTag: lowerTag(tag: user.userTag),
                            phone: processingPhoneNumber(phone: user.phone),
                            avatarImage: user.avatarUrl ,
                            birthday: processingBirthday(date: user.birthday),
                            currentAge: createCurrentAgefromBirthday(date: user.birthday))
        })
        return newData
        
    }
    
    
    /// Description: приводим userTag - к нижнему регистру - так как в основном только он для всего и будет использоваться
    private func lowerTag(tag: String) -> String {
        return tag.lowercased()
    }
    
    
    /// Description: приводит получаемые телефонные данные к формату - +79969593262
    private func processingPhoneNumber(phone: String) -> String {
        let result = phone.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        return "+7\(result)"
    }
    
    
    
    /// Description: Метод который использовал для получения сразу аватарки сотрудника - при создании - так как они весят очень мало и все происходит асинхронно главному потоку - подождать секунду и получить уже полностью готовый массив данных - удобно, но если данные будут весить много - займет много времени - поэтому его не использую переделав на другую систему загрузки аватарки
    private func downloadImage(url: String) -> UIImage {
        
        var image = UIImage()
        
        
        self.taskForDownloadAvatarImage?.employeeDownloadAvatarImageTask(url: url, completion: { [weak self] result in
            guard let strSelf = self else { return }
            switch result {
            case .success(let data):
                image = UIImage(data: data)!
                strSelf.semaf.signal()
            case .failure(_):
                image = UIImage(named: Resources.Image.mockAvatarImage)!
                strSelf.semaf.signal()
            }
        })
        semaf.wait()
        
        
        return image
    }
    
    
    
    /// Description: Метод который преобразует формат номера телефона из +79969593262 к +7 (999) 900 90 90 - который будет использоваться в UI
    static func processingPhoneNumberWithSeparate(phone: String) -> String {
        var result = phone
        let next = result.index(after: result.firstIndex(of: "7")!)
        result.insert("(", at: next)
        result.insert(" ", at: next)
        let next2 = result.index(next, offsetBy: 5)
        result.insert(" ", at: next2)
        result.insert(")", at: next2)
        let end1 = result.index(result.endIndex, offsetBy: -2)
        result.insert(" ", at: end1)
        let end2 = result.index(result.endIndex, offsetBy: -5)
        result.insert(" ", at: end2)
        return result
    }
    
    
    
    /// Description: метод который преобразует получаем формат даты - к тому который будет использовать в проекте
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
        let endIndex = dateString.endIndex
        let startIndexOffset = dateString.index(endIndex, offsetBy: -2)
        let range = Range(uncheckedBounds: (lower: startIndexOffset, upper: endIndex)) // г.
        dateString.removeSubrange(range)
        
        
        //убираем первый 0 елси он есть
        let startCharacter = dateString[dateString.startIndex]
        if startCharacter == "0" {
            dateString.remove(at: dateString.startIndex)
        }
        
        
        return dateString
    }
    
    
    /// Description: метод который позволяет узнать возраст пользователя
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

