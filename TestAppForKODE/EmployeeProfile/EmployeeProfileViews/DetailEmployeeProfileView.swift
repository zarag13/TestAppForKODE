//
//  DetailEmployeeProfileView.swift
//  TestAppForKODE
//
//  Created by Kirill on 11.03.2024.
//

import UIKit
import BaseUIComponents


class DetailProfileView: BaseTableView{
    
    lazy var dpDataSource: UITableViewDiffableDataSource<DetailSection, Employer> = self.configureDiffableDataSource()
    
}

extension DetailProfileView {
    override func registerCell() {
        super.registerCell()
        self.register(DetailEmployeProfileCell.self, forCellReuseIdentifier: DetailEmployeProfileCell.reuseIdentifier)
        configureDiffableDataSourceee()
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        delegate = self
        separatorStyle = .none
        backgroundColor = Resources.Colors.empliyeeProfileBacground
        
        if contentSize.height < frame.size.height {
            isScrollEnabled = true
        } else {
            isScrollEnabled = false
        }
        
    }
}



//MARK: - configureDifableDataSource
extension DetailProfileView {
    //1. Метод создания UICollectionViewDiffableDataSource
    func configureDiffableDataSource() -> UITableViewDiffableDataSource<DetailSection, Employer> {
        
        
        //3. Создаем UICollectionViewDiffableDataSource
        let dataSource = UITableViewDiffableDataSource<DetailSection, Employer>(tableView: self) { tableView, indexPath, item in
            
            
            //4. Из UICollectionViewDiffableDataSource достаем snapshot + данные по indexPath
            let sectionType = self.dpDataSource.snapshot().sectionIdentifiers[indexPath.section]
            
            
            //5. В зависимости от того, какие придут данные - распределяем их по ячейкам
            switch sectionType {
            case .dateSection(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: DetailEmployeProfileCell.reuseIdentifier, for: indexPath) as! DetailEmployeProfileCell
                cell.configure(user: user, state: .one)
                return cell
            case .phoneSection(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: DetailEmployeProfileCell.reuseIdentifier, for: indexPath) as! DetailEmployeProfileCell
                cell.configure(user: user, state: .two)
                return cell
            }
        }
        return dataSource
    }
}

extension DetailProfileView {
    
    
    func configureDiffableDataSourceee() {
        
#warning("Мока для таблицы - исправить при парсинге данных и конкретной разрабтки арихтектуры")
        let sections = MockData.shared.pageDta
        
        var snapshot = NSDiffableDataSourceSnapshot<DetailSection, Employer>()
        snapshot.appendSections(sections)
        
        sections.forEach { section in
            switch section {
            case .dateSection(let user), .phoneSection(let user):
                snapshot.appendItems([user], toSection: section)
            }
        }

        //2. Передаем snapshot с данными в DiffableDataSource
        dpDataSource.apply(snapshot, animatingDifferences: true, completion: nil)
    }
}

extension DetailProfileView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        
        if section == 0{
            headerView.backgroundColor = UIColor(hexString: "#F7F7F8")
        } else {
            headerView.backgroundColor = UIColor.clear
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let sectionType = self.dpDataSource.snapshot().sectionIdentifiers[indexPath.section]
        switch sectionType {
        case .dateSection(_):
            break
        case .phoneSection(let user):
            callNumber(phoneNumber: user.phoneNumber)
        }
        
        
    }
    
    private func callNumber(phoneNumber: String) {
        if let url = URL(string: "tel://\(phoneNumber)") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            } else {
                print("Can't open url on this device")
            }
        }
    }
}
