//
//  DetailEmployeeProfileView.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import UIKit
import BaseUIComponents


class DetailProfileView: BaseTableView{
    
    var employee: Employee? {
        didSet {
            self.reloadData()
        }
    }
}

extension DetailProfileView {
    override func registerCell() {
        super.registerCell()
        self.register(DetailEmployeProfileCell.self, forCellReuseIdentifier: DetailEmployeProfileCell.reuseIdentifier)
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        delegate = self
        dataSource = self
        separatorColor = .black
        backgroundColor = Resources.Colors.empliyeeProfileBacground
        
        if contentSize.height < frame.size.height {
            isScrollEnabled = true
        } else {
            isScrollEnabled = false
        }
    }
}

extension DetailProfileView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var returnCell = BaseTableViewCell()
        
        guard let employee = employee else { return UITableViewCell() }
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailEmployeProfileCell.reuseIdentifier, for: indexPath) as! DetailEmployeProfileCell
            cell.configure(employee: employee, state: .one)
            cell.selectionStyle = .none
            returnCell = cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: DetailEmployeProfileCell.reuseIdentifier, for: indexPath) as! DetailEmployeProfileCell
            cell.configure(employee: employee, state: .two)
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: tableView.bounds.width)
            returnCell = cell
        }
        return returnCell
    }
}

extension DetailProfileView {
    
    func configureDataSourceee(employee: Employee) {
        self.employee = employee
    }
}

extension DetailProfileView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let cell = tableView.cellForRow(at: indexPath) as? DetailEmployeProfileCell else { return }
        
        if cell.state == .two {
            callNumber(phoneNumber: employee?.phone)
        }
    }
    
    private func callNumber(phoneNumber: String?) {
        guard let phoneNumber = phoneNumber else { return }
        if let url = URL(string: "tel://\(phoneNumber)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                print("Can't open url on this device")
            }
        }
    }
}
