//
//  ListOfEmployeesTableViewCell.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import BaseUIComponents

class ListOfEmployeesTableViewCell: BaseTableViewCell {
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
    }
    
    override func prepareForReuse() {
        contentViewCell.avatarImage.image = UIImage(named: Resources.Image.mockAvatarImage) //Resources.Image.mockAvatarImage
    }
}

extension ListOfEmployeesTableViewCell {
    func configurationCell(employee: Employee, birthday: Bool) {
        self.path = employee.id
        
        let networkManager = BuilderNetworkLayer.createTaskManagerr()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
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
        }
        
        //contentViewCell.avatarImage.image = employee.avatarImage
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
