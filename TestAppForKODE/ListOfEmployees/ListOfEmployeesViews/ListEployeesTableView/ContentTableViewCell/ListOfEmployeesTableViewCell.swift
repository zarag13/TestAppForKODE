//
//  ListOfEmployeesTableViewCell.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import BaseUIComponents

//MARK: - ячейка которая отображается при успешной загрузке данных
final class ListOfEmployeesTableViewCell: BaseTableViewCell {
    static let reuseIdentifier = String(describing: ListOfEmployeesTableViewCell.self)
    var contentViewCell = ContentViewForTableViewCell()
    
    private var path: String?
}
extension ListOfEmployeesTableViewCell {
    
    override func setupViews() {
        super.setupViews()
        contentView.addView(contentViewCell)
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        NSLayoutConstraint.activate([
            contentViewCell.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentViewCell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            contentViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentViewCell.heightAnchor.constraint(equalToConstant: 84),
        ])
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = Resources.Colors.empliyeeProfileBacground
    }
    
    override func prepareForReuse() {
        contentViewCell.avatarImage.image = UIImage(named: Resources.Image.mockAvatarImage) //Resources.Image.mockAvatarImage
    }
}

extension ListOfEmployeesTableViewCell {
    func configurationCell(employee: Employee, birthday: Bool) {
        self.path = employee.id
        
        //MARK: - здесь реализована загрузка аватарки - но она должна быть в интеракторе - не успел придумать как ее туда вынести, что бы корректно работало
        let networkManager = BuilderNetworkLayer.createTaskManagerr()
        networkManager.employeeDownloadAvatarImageTask(url: employee.avatarImage) { result in
            switch result {
            case .success(let data):
                if employee.id == self.path {
                    DispatchQueue.main.async {
                        self.contentViewCell.avatarImage.image = UIImage(data: data)
                    }
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.contentViewCell.avatarImage.image = UIImage(named: Resources.Image.mockAvatarImage)
                }
            }
        }
        
        let fullName = "\(employee.firstName) \(employee.lastName)"
        contentViewCell.titleLabel.text = fullName
        contentViewCell.subTitleLabel.text = employee.position
        contentViewCell.metaTitle.text = employee.userTag
        if birthday {
            contentViewCell.birthdayTitle.text = createNewFormatBirthDay(birthday: employee.birthday)
        } else {
            contentViewCell.birthdayTitle.text = ""
        }
    }
    
    //MARK: - метод преобразования даты в тот формат который требуется для отображния - число + первые три буквы месяца
    func createNewFormatBirthDay(birthday: String) -> String {
        let array = birthday.components(separatedBy: .whitespaces)
        if array[0].count == 1 {
            let lstIndex = birthday.index(birthday.startIndex, offsetBy: 5)
            let range = birthday.startIndex ..< lstIndex
            return String(birthday[range])
        } else {
            let lstIndex = birthday.index(birthday.startIndex, offsetBy: 6)
            let range = birthday.startIndex ..< lstIndex
            return String(birthday[range])
        }
    }
}
