//
//  ErrorSearchView.swift
//  TestAppForKODE
//
//  Created by Kirill on 18.03.2024.
//

import BaseUIComponents

class ErrorSearchView: BaseView {
    
    let image: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Resources.Image.magnifyingGlass
        return imageView
    }()
    
    let firstLable: UILabel = {
        let label = UILabel ()
        label.textAlignment = .center
        label.font = Resources.Founts.interBold(with: 17)
        label.textColor = Resources.Colors.titleTextColor
        label.text = "Мы никого не нашли"
        return label
    }()
    
    let secondLabel: UILabel = {
        let label = UILabel ()
        label.textAlignment = .center
        label.font = Resources.Founts.interRegular(with: 16)
        label.textColor = Resources.Colors.metaTextColor
        label.text = "Попробуй скорректировать запрос"
        return label
    }()
    
    let textStackView: UIStackView =  {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 12
        //stackView.distribution = .fillEqually
        //stackView.alignment = .fill
        return stackView
    }()
}

extension ErrorSearchView {
    override func setupViews() {
        super.setupViews()
        addView(image)
        addView(textStackView)
        [firstLable, secondLabel].forEach { view in
            textStackView.addArrangedSubview(view)
        }
    }
    
    override func setupLayoutViews() {
        super.setupLayoutViews()
        NSLayoutConstraint.activate([
            //image
            image.centerXAnchor.constraint(equalTo: centerXAnchor),
            image.topAnchor.constraint(equalTo: topAnchor),
            image.widthAnchor.constraint(equalToConstant: 56),
            image.heightAnchor.constraint(equalToConstant: 56),
            
            //textStackView
            textStackView.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 8),
            textStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            textStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            textStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
        
    }
    
    override func configureAppearance() {
        super.configureAppearance()
        backgroundColor = .clear
    }
}
