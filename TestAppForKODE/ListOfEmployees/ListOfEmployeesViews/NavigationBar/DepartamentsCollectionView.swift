//
//  CategoriesCollectionView.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import UIKit
import BaseUIComponents

protocol DepartamentsProtocol: AnyObject {
    func move(departamen: Department)
}

//MARK: - горизонтальная коллекция с ячейками - по нажатию на которые будет фильтрация данных
final class DepartamentsCollectionView: BaseCollectionView {
    weak var departamentsDelegate: DepartamentsProtocol?
}

extension DepartamentsCollectionView {
    override func setupViews() {
        
    }
    
    override func setupLayoutViews() {
        flowLayout.minimumLineSpacing = 5
        flowLayout.scrollDirection = .horizontal
    }
    
    override func configureAppearance() {
        delegate = self
        dataSource = self
        backgroundColor = .white
        bounces = false
        showsHorizontalScrollIndicator = false
        register(DepartamentCollectionViewCell.self, forCellWithReuseIdentifier: DepartamentCollectionViewCell.reuseIdentifier)
        selectItem(at: [0, 0], animated: false, scrollPosition: [])
    }
}


extension DepartamentsCollectionView {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        let departament = Department.allCases[indexPath.row]
        departamentsDelegate?.move(departamen: departament)
        
    }
}



extension DepartamentsCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Department.allDepartments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DepartamentCollectionViewCell.reuseIdentifier, for: indexPath) as! DepartamentCollectionViewCell
        let name = Department.allCases[indexPath.row].rawValue
        cell.configure(title: name)
        return cell
        
    }
}

extension UICollectionView: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = Department.allCases[indexPath.row].rawValue.defiendWith(font: Resources.Founts.interMedium(with: 15))
        return CGSize(width: width + 20, height: collectionView.frame.height)
        
    }
}
