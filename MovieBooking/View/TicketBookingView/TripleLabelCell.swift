//
//  TripleLabelCell.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 3/4/26.
//
import UIKit
import SnapKit

final class TripleLabelCell: UICollectionViewCell {
    static let identifier = "TripleLabelCell"

    private let stackView = UIStackView()
    private let firstLabel = UILabel()
    private let secondLabel = UILabel()
    private let thirdLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true

        configureLabels()
        configureStackView()
        configureLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configureLabels() {
        [firstLabel, secondLabel, thirdLabel].forEach {
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 14, weight: .medium)
            $0.textColor = .label
        }
    }

    private func configureStackView() {
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .fillEqually

        stackView.addArrangedSubview(firstLabel)
        stackView.addArrangedSubview(secondLabel)
        stackView.addArrangedSubview(thirdLabel)

        contentView.addSubview(stackView)
    }

    private func configureLayout() {
        stackView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }

    func configure(first: String, second: String, third: String) {
        firstLabel.text = first
        secondLabel.text = second
        thirdLabel.text = third
    }
}
