//
//  MyPageProfileCell.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/3/26.
//

import UIKit
import SnapKit

class MyPageProfileCell: UICollectionViewCell {
    
    static let id = "MyPageProfileCell"
    
    private let containerView = UIView()
    private let profileImageView = UIImageView()
    private let stackView = UIStackView()
    private let nameLabel = UILabel()
    private let emailLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAttributes()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageProfileCell {
    private func setAttributes() {
        
        containerView.backgroundColor = .systemOrange
        containerView.layer.cornerRadius = 20
        
        profileImageView.image = UIImage(systemName: "person.crop.circle.fill")
        profileImageView.tintColor = .white
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 40
        profileImageView.clipsToBounds = true
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        
        nameLabel.font = .systemFont(ofSize: 25, weight: .bold)
        nameLabel.textColor = .white
        
        emailLabel.font = .systemFont(ofSize: 18)
        emailLabel.textColor = .white
        
    }
    private func setLayout() {
        
        contentView.addSubview(containerView)
        [nameLabel, emailLabel].forEach { stackView.addArrangedSubview($0) }
        [profileImageView, stackView].forEach { containerView.addSubview($0) }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(80)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
        }
        
    }
}

extension MyPageProfileCell {
    func config(name: String, email: String) {
        nameLabel.text = name
        emailLabel.text = email
    }
}
