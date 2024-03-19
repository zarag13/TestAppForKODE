//
//  FilteredDataManager.swift
//  TestAppForKODE
//
//  Created by Kirill on 17.03.2024.
//

import Foundation


class FilteredDataManager {
    func filteringBy(departament: Department, sortedCheckBoxFiltered: CheckBoxState, data: [Employee]) -> [Employee] {
        let filteredByDepartament = filteringByDepartament(departament: departament, employees: data)
        let filteredByCheckBox = filteringByCheckBox(sortedCheckBoxFiltered: sortedCheckBoxFiltered, employees: filteredByDepartament)
        return filteredByCheckBox
    }
    
    //фильтрация поиска - полнсотью готова - здесь не важно какой придет массив(с уже ранее примененными фильтрами или нет) - все будет четко работать
    func filteringBySearchText(searchText: String, employees: [Employee]) -> [Employee] {
        var filteredEmployee = [Employee]()
        
        if Int(searchText) != nil {
            //обработка номера
            filteredEmployee = employees.filter({ employee in
                employee.phone.contains(searchText)
            })
        } else {
            //обработка текста
            if searchText.count == 2 {
                filteredEmployee = employees.filter({ employee in
                    if employee.userTag.lowercased().contains(searchText.lowercased()) {
                        return true
                    }
                    return false
                })
                if filteredEmployee.count == 0 {
                    filteredEmployee = searchNameFiltered(searchText: searchText, employees: employees)
                }
            } else {
                filteredEmployee = searchNameFiltered(searchText: searchText, employees: employees)
            }
        }
        return filteredEmployee
    }
}


private extension FilteredDataManager {
    //фильтрация по имени и фамилии (поиск)
    private func searchNameFiltered(searchText: String, employees: [Employee]) -> [Employee] {
        var filteredEmployee = [Employee]()
        let lowerSearch = searchText.lowercased()
        filteredEmployee = employees.filter({ employee in
            if employee.firstName.lowercased().contains(lowerSearch) {
                return true
            } else if employee.lastName.lowercased().contains(lowerSearch) {
                return true
            } else if "\(employee.firstName) \(employee.lastName)".lowercased().contains(lowerSearch) {
                print("\(employee.firstName) \(employee.lastName)".lowercased())
                print(lowerSearch)
                return true
            }
            return false
        })
        return filteredEmployee
    }
    
    //Возвращает данные отфильтрованные по departament
    private func filteringByDepartament(departament: Department, employees: [Employee]) -> [Employee] {
        let filteredEmployee = employees.filter { eployee in
            if departament == .all {
                return true
            } else {
                return eployee.department == "\(departament)"
            }
        }
        return filteredEmployee
    }
    
    
    //фильтрация по чекбоксу
    private func filteringByCheckBox(sortedCheckBoxFiltered: CheckBoxState, employees: [Employee]) -> [Employee] {
        switch sortedCheckBoxFiltered {
        case .none:
            return employees
        case .alphabet:
            return  employees.sorted { $0.firstName.lowercased() < $1.firstName.lowercased() }
        case .birthday:
            let filteredBirthdayEmployee = filteredBirthday(employees: employees)
            return self.filteredBirzdayYear(employees: filteredBirthdayEmployee)
        }
    }
    
    //фильтруем по дате рождения от меньшего к большему - по числу + месяцу
    private func filteredBirthday(employees: [Employee]) -> [Employee] {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        
        let sortedEmployee = employees.sorted { employe1, employe2 in
            //переводим строку в дату
            let dateEmployee1 = dateFormatter.date(from: employe1.birthday)
            let dateEmployee2 = dateFormatter.date(from: employe2.birthday)
            //извлекаем компоненты
            let employeeDateComponent1 = calendar.dateComponents([.day, .month], from: dateEmployee1!)
            let employeeDateComponent2 = calendar.dateComponents([.day, .month], from: dateEmployee2!)
            // на основе компонента создаем новые даты (где все одинакоеове будет кроме нужных компонентов, что позволит сравнить месяц и день)
            let newDataEmployee1 = calendar.date(from: employeeDateComponent1)
            let newDataEmployee2 = calendar.date(from: employeeDateComponent2)
            
            switch newDataEmployee1!.compare(newDataEmployee2!) {
            case .orderedAscending:
                //дата 1 меньше дата 2 - от меньшего к большему
                return true
            case .orderedSame:
                return false
            case .orderedDescending:
                //дата 1 больше дата 2 - от большего к меньшему
                return false
            }
        }
        return sortedEmployee
    }
    
    
    //здесь сразу две фильтрации в одной из массива находим тех у кого др в этом году - второй у к кого в следующем
    //в теории елси придет массив уже отфильтрованный по дате - то этот метод вернет так же все отфильтрованное по порядку
    #warning("Здесь мы получили два массива с разными данными - у кого в этом году др, у кого в следующем")
    private func filteredBirzdayYear(employees: [Employee]) -> [Employee] {
        //1. Приходит массив отфильтрованных данных по дате рождения
        
        var birzdayCurrentYear = [Employee]()
        var birzdaySecondYear = [Employee]()
        
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let dateNow = Date.now
        
        
        //Получаем даты текущего года
        birzdayCurrentYear = employees.filter({ employee in
            //преобразуем дату работнику
            let dateEmployee = dateFormatter.date(from: employee.birthday)
            //достаем компоненты из текущей даты и даты пользователя
            let employeeDateComponent = calendar.dateComponents([.day, .month], from: dateEmployee!)
            let nowDateComponent = calendar.dateComponents([.day, .month], from: dateNow)
            //создаем новые пустые даты, с компонентами, что бы можно было сравнить
            let newDateEmployee = calendar.date(from: employeeDateComponent)
            let newNowDate = calendar.date(from: nowDateComponent)
            //
            switch newNowDate!.compare(newDateEmployee!) {
            case .orderedAscending:
                //дата сейчас меньше чем дата пользователя
                return true
            case .orderedSame:
                return true
            case .orderedDescending:
                //дата сейчас больше чем дата пользователя
                return false
            }
        })
        
        birzdayCurrentYear = birzdayCurrentYear.map { employee in
            var newEmployee = employee
            newEmployee.birzdayYear = "2024"
            return newEmployee
        }
        
        
        birzdaySecondYear = employees.filter({ employee in
            //преобразуем дату работнику
            let dateEmployee = dateFormatter.date(from: employee.birthday)
            //достаем компоненты из текущей даты и даты пользователя
            let employeeDateComponent = calendar.dateComponents([.day, .month], from: dateEmployee!)
            let nowDateComponent = calendar.dateComponents([.day, .month], from: dateNow)
            //создаем новые пустые даты, с компонентами, что бы можно было сравнить
            let newDateEmployee = calendar.date(from: employeeDateComponent)
            let newNowDate = calendar.date(from: nowDateComponent)
            //
            switch newNowDate!.compare(newDateEmployee!) {
            case .orderedAscending:
                //дата сейчас меньше чем дата пользователя
                return false
            case .orderedSame:
                return false
            case .orderedDescending:
                //дата сейчас больше чем дата пользователя
                return true
            }
        })
        
        birzdaySecondYear = birzdaySecondYear.map { employee in
            var newEmployee = employee
            newEmployee.birzdayYear = "2025"
            return newEmployee
        }
        
        return birzdayCurrentYear + birzdaySecondYear
    }
}
