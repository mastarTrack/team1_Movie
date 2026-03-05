//
//  CenterLabelCell.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 3/4/26.
//
import UIKit
import SnapKit

final class CenterLabelCell: UICollectionViewCell {
    static let identifier = "CenterLabelCell"

    private let titleLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true

        titleLabel.textAlignment = .center
        titleLabel.textColor = .label
        titleLabel.font = .systemFont(ofSize: 16, weight: .medium)

        contentView.addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(text: String) {
        titleLabel.text = text
    }
    
    func applySelectedStyle(_ isSelected: Bool) {
        if isSelected {
            contentView.backgroundColor = .systemOrange
        } else {
            contentView.backgroundColor = .systemGray6
        }
    }
}
