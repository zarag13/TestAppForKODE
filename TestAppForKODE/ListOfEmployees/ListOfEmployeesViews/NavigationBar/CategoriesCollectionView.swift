//
//  CategoriesCollectionView.swift
//  TestAppForKODE
//
//  Created by Kirill on 13.03.2024.
//

import UIKit
import BaseUIComponents

protocol CategoriesProtocol: AnyObject {
    func move(departamen: Department)
}

class CategoriesCollectionView: BaseCollectionView {
    weak var categoriesDelegate: CategoriesProtocol?
}

extension CategoriesCollectionView {
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
        register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.reuseIdentifier)
        selectItem(at: [0, 0], animated: false, scrollPosition: [])
    }
}


extension CategoriesCollectionView {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        let departament = Department.allCases[indexPath.row]
        categoriesDelegate?.move(departamen: departament)
        
    }
}



extension CategoriesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        Department.allDepartments.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.reuseIdentifier, for: indexPath) as! CategoriesCollectionViewCell
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
