//
//  HomeViewController.swift
//  NedbankClone
//
//  Created by Nagarro on 2024/08/05.
//
//

import UIKit
import WebKit

class HomeViewController: UIViewController {
    
    var loginName: String?

    // MARK: - UI Components
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.backgroundColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .black : .white
        }
        return sv
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .black : .white
        }
        return view
    }()
    
    private let featuredCard: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .systemGray6 : .white
        }
        view.layer.cornerRadius = 8
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.1
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        return view
    }()
    
    private let longTextLabel: UILabel = {
        let label = UILabel()
        label.text = "Greenbacks level 3 rewards just keep on coming ,Earn up to 1% cash back when you spend on your Greenbacks-linked card, and get exclusive deals and extra discounts from our partners."
        label.numberOfLines = 0 // Allows the label to have multiple lines
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .white : .black
        }
        return label
    }()
    
    private let linkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Visit The NedBank Site for more", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.addTarget(self, action: #selector(linkButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let widgetsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    // MARK: - Properties
    private let widgets = ["Applications", "Insure", "Shop", "Discs and fines", "Latest", "Offers for you", "Quick Pay", "Pay me", "Get cash", "Home loans", "Statements"]
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupCollectionViews()
        
        if let name = loginName {
            title = "Welcome, \(name)"
        } else {
            title = "Welcome"
        }
    }
    
    // MARK: - Setup Methods
    private func setupUI() {
        view.backgroundColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .black : .white
        }

        // Create a custom title view with logo and title
        let titleView = UIView()

        let logoImageView = UIImageView(image: UIImage(named: "logo")) // Replace "your_logo_image" with your logo image name
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false

        let titleLabel = UILabel()
        titleLabel.text = "NEDBANK"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20) // Customize as needed
        titleLabel.textColor = UIColor { traitCollection in
            return traitCollection.userInterfaceStyle == .dark ? .white : .black
        }
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        titleView.addSubview(logoImageView)
        titleView.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            logoImageView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            logoImageView.centerYAnchor.constraint(equalTo: titleView.centerYAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 30), // Adjust size as needed
            logoImageView.heightAnchor.constraint(equalToConstant: 30), // Adjust size as needed

            titleLabel.leadingAnchor.constraint(equalTo: logoImageView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: titleView.centerYAnchor)
        ])

        navigationItem.titleView = titleView

        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "bell"), style: .plain, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "message"), style: .plain, target: self, action: nil)
        ]

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        [featuredCard, widgetsCollectionView].forEach { contentView.addSubview($0) }
        [longTextLabel, linkButton].forEach { featuredCard.addSubview($0) }
    }

    private func setupConstraints() {
        [scrollView, contentView, featuredCard, longTextLabel, linkButton, widgetsCollectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            featuredCard.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            featuredCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            featuredCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            featuredCard.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            
            longTextLabel.topAnchor.constraint(equalTo: featuredCard.topAnchor, constant: 10),
            longTextLabel.leadingAnchor.constraint(equalTo: featuredCard.leadingAnchor, constant: 10),
            longTextLabel.trailingAnchor.constraint(equalTo: featuredCard.trailingAnchor, constant: -10),
            
            linkButton.topAnchor.constraint(equalTo: longTextLabel.bottomAnchor, constant: 10),
            linkButton.leadingAnchor.constraint(equalTo: featuredCard.leadingAnchor, constant: 10),
            linkButton.trailingAnchor.constraint(equalTo: featuredCard.trailingAnchor, constant: -10),
            linkButton.bottomAnchor.constraint(equalTo: featuredCard.bottomAnchor, constant: -10),
            
            widgetsCollectionView.topAnchor.constraint(equalTo: featuredCard.bottomAnchor, constant: 20),
            widgetsCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            widgetsCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            widgetsCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            widgetsCollectionView.heightAnchor.constraint(equalToConstant: 400) // Adjust height as needed
        ])
    }
    
    private func setupCollectionViews() {
        widgetsCollectionView.register(WidgetCell.self, forCellWithReuseIdentifier: "WidgetCell")
        widgetsCollectionView.dataSource = self
        widgetsCollectionView.delegate = self
    }
    
    @objc private func linkButtonTapped() {
        if let url = URL(string: "https://personal.nedbank.co.za/bank/greenbacks/level3.html") {
            UIApplication.shared.open(url)
        }
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return widgets.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WidgetCell", for: indexPath) as! WidgetCell
        cell.configure(with: widgets[indexPath.item])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 40) / 3
        return CGSize(width: width, height: width)
    }
}

