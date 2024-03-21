//
//  ListOfEmployeesTableView.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import BaseUIComponents

//MARK: - Протокол таблицы о передаче данных
protocol ListOfEmployeesTableViewDelegate: AnyObject {
    //MARK: - просит перезагрузить данные при refresh скролинге (здесь мы передаем самого себя(таблицу) - что бы была возмождность остановить refreshControll)
    func reloadData(callback: ListOfEmployeesViewControllerCallBackProtocol)
    //MARK: - сообщает о том какая ячейка была нажата
    func selectedEmployee(employee: Employee)
}


//MARK: - таблица которая отображает данные или моку во время ожидания получения данных
final class ListOfEmployeesTableView: BaseTableView {
    var employees: [Employee]? {
        didSet {
            reloadData()
            isScrollEnabled = true
        }
    }
    
    var sortedBirthDay = false
    
    weak var tableViewdelegate: ListOfEmployeesTableViewDelegate?
}

extension ListOfEmployeesTableView {
    override func registerCell() {
        register(ListOfEmployeesTableViewCell.self, forCellReuseIdentifier: ListOfEmployeesTableViewCell.reuseIdentifier)
        register(MockCellForTableView.self, forCellReuseIdentifier: MockCellForTableView.reuseIdentifier)
        register(HeaderCellForBirthdaySorted.self, forHeaderFooterViewReuseIdentifier: HeaderCellForBirthdaySorted.reuseIdentifier)
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        delegate = self
        dataSource = self
        separatorStyle = .none
        
        isScrollEnabled = false
        showsVerticalScrollIndicator = false
        
        backgroundColor = Resources.Colors.empliyeeProfileBacground
        
        
        self.refreshControl = UIRefreshControl()
        
        refreshControl?.tintColor = .red
        refreshControl?.addTarget(self, action: #selector(refreshReloadData(sender:)), for: .valueChanged)
    }
    
    
    @objc func refreshReloadData(sender: UIRefreshControl) {
        refreshControl?.beginRefreshing()
        tableViewdelegate?.reloadData(callback: self)
    }
}

extension ListOfEmployeesTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deselectRow(at: indexPath, animated: true)
        guard let employe = employees?[indexPath.section] else { return }
        tableViewdelegate?.selectedEmployee(employee: employe)
    }
}
extension ListOfEmployeesTableView: UITableViewDataSource {
    
    //MARK: - cекций столько сколько ячеек
    func numberOfSections(in tableView: UITableView) -> Int {
        employees?.count ?? 8
    }
    
    //MARK: - в одной секции 1 ячейка
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //MARK: - высота заголовка
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        guard employees != nil else { return 12 }
        
        let index = employees?.firstIndex(where: { employee in
            employee.birzdayYear == "2025"
        })
        
        if section == index {
            return 68
        }
        
        return 4
    }
    
    
    //MARK: - убираем отступы между секциями
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }
    
    
    
    //MARK: - обычные пустые заголовки == отступы между ячейками
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = Resources.Colors.empliyeeProfileBacground
        guard let employee = employees?[section] else {
            return view
        }
        
        let index = employees?.firstIndex(where: { employee in
            employee.birzdayYear == "2025"
        })
        
        if section == index {
            let header = dequeueReusableHeaderFooterView(withIdentifier: HeaderCellForBirthdaySorted.reuseIdentifier)
            return header
        }
        return view
    }
    
    
    //MARK: - создание ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let employee = employees?[indexPath.section] else {
            guard let cell = dequeueReusableCell(withIdentifier: MockCellForTableView.reuseIdentifier, for: indexPath) as? MockCellForTableView else {
                return UITableViewCell()
            }
            return cell
        }
        
        guard let cell = dequeueReusableCell(withIdentifier: ListOfEmployeesTableViewCell.reuseIdentifier, for: indexPath) as? ListOfEmployeesTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configurationCell(employee: employee, birthday: sortedBirthDay)
        return cell
    }
}

//MARK: - метод который будет тригерить контроллер что бы таблица остановила refresh
extension ListOfEmployeesTableView: ListOfEmployeesViewControllerCallBackProtocol {
    func reloadDataDone() {
        refreshControl?.endRefreshing()
    }
}
