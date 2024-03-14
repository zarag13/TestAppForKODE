//
//  ListOfEmployeesTableView.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import BaseUIComponents

class ListOfEmployeesTableView: BaseTableView {
    
}

extension ListOfEmployeesTableView {
    override func registerCell() {
        register(ListOfEmployeesTableViewCell.self, forCellReuseIdentifier: ListOfEmployeesTableViewCell.reuseIdentifier)
    }
    
    override func configureAppearance() {
        delegate = self
        dataSource = self
        separatorStyle = .none
        
        if contentSize.height < frame.size.height {
            isScrollEnabled = true
        } else {
            isScrollEnabled = false
        }
    }
}

extension ListOfEmployeesTableView: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 343
//    }
}
extension ListOfEmployeesTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = dequeueReusableCell(withIdentifier: ListOfEmployeesTableViewCell.reuseIdentifier, for: indexPath) as? ListOfEmployeesTableViewCell else {
            print("error")
            return UITableViewCell()
        }
        
        return cell
    }
}
