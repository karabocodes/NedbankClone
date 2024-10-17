//
//  WidgetCell.swift
//  NedbankClone
//
//  Created by Nagarro on 2024/08/05.
//

import UIKit

class WidgetCell: UICollectionViewCell {
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .green
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        return label
    }()
    
    // Define a fixed mapping of widget titles to SF Symbols
    private let widgetIcons: [String: String] = [
        "Applications": "pencil.line",
        "Insure": "shield.fill",
        "Shop": "cart.fill",
        "Discs and fines": "exclamationmark.triangle.fill",
        "Latest": "clock.fill",
        "Offers for you": "star.fill",
        "Quick Pay": "creditcard.fill",
        "Pay me": "dollarsign.circle.fill",
        "Get cash": "banknote.fill",
        "Home loans": "house.fill",
        "Statements": "doc.fill"
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(iconImageView)
        addSubview(titleLabel)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            iconImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            
            titleLabel.topAnchor.constraint(equalTo: iconImageView.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    func configure(with title: String) {
        titleLabel.text = title
        
        let iconName = widgetIcons[title] ?? "square.fill" // Default icon if title is not found
        iconImageView.image = UIImage(systemName: iconName)
    }
}
