//
//  ListOfEmployeesTableView.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import BaseUIComponents

protocol ListOfEmployeesTableViewDelegate: AnyObject {
    func reloadData(callback: ListOfEmployeesViewControllerCallBackProtocol)
}

class ListOfEmployeesTableView: BaseTableView {
    var employees: [Employee]? {
        didSet {
            reloadData()
            isScrollEnabled = true
        }
    }
    
    weak var tableViewdelegate: ListOfEmployeesTableViewDelegate?
}

extension ListOfEmployeesTableView {
    override func registerCell() {
        register(ListOfEmployeesTableViewCell.self, forCellReuseIdentifier: ListOfEmployeesTableViewCell.reuseIdentifier)
    }
    
    override func configureAppearance() {
        delegate = self
        dataSource = self
        separatorStyle = .none
        
        isScrollEnabled = false
        showsVerticalScrollIndicator = false
        
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
    
}
extension ListOfEmployeesTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        employees?.count ?? 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: ListOfEmployeesTableViewCell.reuseIdentifier, for: indexPath) as? ListOfEmployeesTableViewCell else {
            return UITableViewCell()
        }
        guard let employee = employees?[indexPath.row] else { return cell }
        
        cell.configurationCell(employee: employee)
        
        return cell
    }
}

extension ListOfEmployeesTableView: ListOfEmployeesViewControllerCallBackProtocol {
    func reloadDataDone() {
        refreshControl?.endRefreshing()
    }
}
