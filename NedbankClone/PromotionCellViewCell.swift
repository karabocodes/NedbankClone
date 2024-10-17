////
////  PromotionCellViewCell.swift
////  NedbankClone
////
////  Created by Nagarro on 2024/08/05.
////
//
//import UIKit
//
//class PromotionCell: UICollectionViewCell {
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.textColor = .white
//        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
//        label.numberOfLines = 0
//        return label
//    }()
//    
//    private let applyButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Apply", for: .normal)
//        button.setTitleColor(.green, for: .normal)
//        button.backgroundColor = .white
//        button.layer.cornerRadius = 4
//        return button
//    }()
//    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setupUI()
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    private func setupUI() {
//        backgroundColor = .green
//        layer.cornerRadius = 8
//        
//        addSubview(titleLabel)
//        addSubview(applyButton)
//        
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//        applyButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        NSLayoutConstraint.activate([
//            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
//            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
//            
//            applyButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
//            applyButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
//            applyButton.widthAnchor.constraint(equalToConstant: 80),
//            applyButton.heightAnchor.constraint(equalToConstant: 30)
//        ])
//    }
//    
//    func configure(with title: String) {
//        titleLabel.text = title
//    }
//}
