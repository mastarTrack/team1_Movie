//
//  MyPageMenuCell.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/3/26.
//

import UIKit
import SnapKit

class MyPageMenuCell: UICollectionViewCell {
    
    static let id = "MyPageMenuCell"
    
    private let containerView = UIView()
    private let iconImageView = UIImageView()
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let subTitleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAttributes()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageMenuCell {
    private func setAttributes() {
        containerView.backgroundColor = .systemGray6
        containerView.layer.cornerRadius = 10
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.tintColor = .systemOrange
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .leading
        
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        subTitleLabel.font = .systemFont(ofSize: 16)
        subTitleLabel.textColor = .secondaryLabel
        
    }
    private func setLayout() {
        contentView.addSubview(containerView)
        [titleLabel, subTitleLabel].forEach { stackView.addArrangedSubview($0) }
        [iconImageView,stackView].forEach { containerView.addSubview($0)}
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        iconImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(30)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
        }
        
    }
}

extension MyPageMenuCell {
    func config(title: String, subTitle: String, iconName: String, isLogout: Bool = false) {
        titleLabel.text = title
        subTitleLabel.text = subTitle
        iconImageView.image = UIImage(systemName: iconName)
        
        if isLogout {
            iconImageView.tintColor = .systemRed
            titleLabel.textColor = .systemRed
            subTitleLabel.textColor = .systemRed
        } else {
            iconImageView.tintColor = .systemOrange
            titleLabel.textColor = .label
            subTitleLabel.textColor = .secondaryLabel
        }
    }
}
