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
        
        profileImageView.image = UIImage(systemName: "person.crop.circle")
        profileImageView.tintColor = .white
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        
        nameLabel.font = .systemFont(ofSize: 30, weight: .bold)
        nameLabel.textColor = .white
        
        emailLabel.font = .systemFont(ofSize: 21)
        emailLabel.textColor = .white
        
    }
    private func setLayout() {
        
        contentView.addSubview(containerView)
        [profileImageView, nameLabel, emailLabel].forEach { containerView.addSubview($0) }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(20)
            $0.top.equalTo(profileImageView.snp.top).offset(10)
        }
        
        emailLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.leading)
            $0.top.equalTo(nameLabel.snp.bottom).offset(10)
        }
        
    }
}

extension MyPageProfileCell {
    func config(name: String, email: String) {
        nameLabel.text = name
        emailLabel.text = email
    }
}
