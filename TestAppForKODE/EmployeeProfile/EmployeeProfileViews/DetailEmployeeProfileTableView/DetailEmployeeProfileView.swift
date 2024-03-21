//
//  DetailEmployeeProfileView.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import BaseUIComponents

//MARK: - протокол который делегирует действие по нажатию на номер
protocol DetailProfileTableViewDelegate: AnyObject {
    func showAlertCallPhone(phone: String)
}

final class DetailProfileView: BaseTableView{
    
    var employee: Employee? {
        didSet {
            self.reloadData()
        }
    }
    
    weak var delegateAction: DetailProfileTableViewDelegate?
}

extension DetailProfileView {
    override func registerCell() {
        super.registerCell()
        self.register(DetailEmployeProfileCell.self, forCellReuseIdentifier: DetailEmployeProfileCell.reuseIdentifier)
        self.register(HeaderForSectionDetailTableView.self, forHeaderFooterViewReuseIdentifier: HeaderForSectionDetailTableView.reuseIdentifier)
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        delegate = self
        dataSource = self
        backgroundColor = Resources.Colors.empliyeeProfileBacground
        separatorStyle = .none
        
        if contentSize.height < frame.size.height {
            isScrollEnabled = true
        } else {
            isScrollEnabled = false
        }
    }
}

extension DetailProfileView: UITableViewDataSource {
    //MARK: - создание ячеек / секций
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var returnCell = BaseTableViewCell()
        
        guard let employee = employee else { return UITableViewCell() }
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailEmployeProfileCell.reuseIdentifier, for: indexPath) as! DetailEmployeProfileCell
            cell.configure(image: Resources.Image.starIcon!, firstTitle: employee.birthday, secondTitle: employee.currentAge)
            cell.selectionStyle = .none
            returnCell = cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailEmployeProfileCell.reuseIdentifier, for: indexPath) as! DetailEmployeProfileCell
            let phone = ManagerProcessingdData.processingPhoneNumberWithSeparate(phone: employee.phone)
            cell.configure(image: Resources.Image.phoneIcon!, firstTitle: phone, secondTitle: nil)
            returnCell = cell
        }
        return returnCell
    }
    
    
    //MARK: - высота заголовка
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 1 {
            return 6
        }
        
        return 0
    }
    
    //MARK: - обычные пустые заголовки == отступы между ячейками
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let header = dequeueReusableHeaderFooterView(withIdentifier: HeaderForSectionDetailTableView.reuseIdentifier)
            return header
        }
        return nil
    }
    
    //MARK: - убираем нижние отступы междлу секциями
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
}

extension DetailProfileView {
    //MARK: - передача данных в таблицу на основе которой создаются потом ячейки
    func configureDataSourceee(employee: Employee) {
        self.employee = employee
    }
}

extension DetailProfileView: UITableViewDelegate {
    
    //MARK: - нажатие на ячейку где мы определяем что за ячейка и делегируем действие
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deselectRow(at: indexPath, animated: true)
        guard let cell = tableView.cellForRow(at: indexPath) as? DetailEmployeProfileCell else { return }
        if cell.conentViewForCell.firstTitle.text!.contains("+7") {
            guard let phone = employee?.phone else { return }
            delegateAction?.showAlertCallPhone(phone: phone)
        }
    }
}
