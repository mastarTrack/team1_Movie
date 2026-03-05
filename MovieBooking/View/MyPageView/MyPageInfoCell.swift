//
//  MyPageInfoCell.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/3/26.
//

import UIKit
import SnapKit

class MyPageInfoCell: UICollectionViewCell {
    static let id = "MyPageInfoCell"
    
    private let containerView = UIView()
    private let countLabel = UILabel()
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAttributes()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageInfoCell {
    private func setAttributes() {
        
        containerView.backgroundColor = .systemGray6
        containerView.layer.cornerRadius = 10
        
        countLabel.font = .systemFont(ofSize: 25, weight: .bold)
        countLabel.textColor = .systemOrange
        countLabel.textAlignment = .center
        
        titleLabel.font = .systemFont(ofSize: 16)
        titleLabel.textColor = .secondaryLabel
        titleLabel.textAlignment = .center
        
    }
    private func setLayout() {
        contentView.addSubview(containerView)
        [countLabel, titleLabel].forEach { containerView.addSubview($0) }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        countLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-10)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(countLabel.snp.bottom).offset(10)
        }
    }
}

extension MyPageInfoCell {
    func config(data: MyPageInfo) {
        countLabel.text = data.value
        titleLabel.text = data.title
    }
}
