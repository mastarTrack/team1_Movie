//
//  SearchTableViewCell.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/27/26.
//

import UIKit
import SnapKit

class SearchTableViewCell: UITableViewCell {
    
    static let id = "SearchTableViewCell"
    
    private let containerView = UIView()
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    private let scoreLabel = UILabel()
    private let genreLabel = UILabel()
    private let reservationButton = CustomButton(title: "예매하기")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setAttributes()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchTableViewCell {
    private func setAttributes() {
        
        containerView.backgroundColor = .systemGray6
        containerView.layer.cornerRadius = 10
        containerView.clipsToBounds = true
        
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 10
        posterImageView.clipsToBounds = true
        posterImageView.backgroundColor = .white
        
        scoreLabel.backgroundColor = .systemGray5
        scoreLabel.textColor = .label
        scoreLabel.font = .systemFont(ofSize: 12, weight: .bold)
        scoreLabel.textAlignment = .center
        scoreLabel.layer.cornerRadius = 5
        scoreLabel.clipsToBounds = true
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
//        stackView.spacing = 10
        
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .label
        
        genreLabel.font = .systemFont(ofSize: 14)
        genreLabel.textColor = .secondaryLabel
        
    }
    private func setLayout() {
        contentView.addSubview(containerView)
        [titleLabel, genreLabel, reservationButton].forEach { stackView.addArrangedSubview($0) }
        [posterImageView, stackView].forEach { containerView.addSubview($0) }
        posterImageView.addSubview(scoreLabel)
        
        containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(10)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        posterImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(100)
            $0.height.equalTo(150)
        }
        scoreLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(5)
            $0.width.equalTo(40)
            $0.height.equalTo(20)
        }
//        titleLabel.snp.makeConstraints {
//            $0.top.equalTo(posterImageView.snp.top).offset(10)
//            $0.leading.equalTo(posterImageView.snp.trailing).offset(10)
//            $0.trailing.equalToSuperview().inset(10)
//        }
//        genreLabel.snp.makeConstraints {
//            $0.top.equalTo(titleLabel.snp.bottom).offset(10)
//            $0.leading.equalTo(titleLabel.snp.leading)
//            $0.trailing.equalTo(titleLabel.snp.trailing)
//        }
        stackView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.top).offset(10)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.lessThanOrEqualTo(posterImageView.snp.bottom)
        }
        reservationButton.snp.makeConstraints {
//            $0.top.equalTo(genreLabel.snp.bottom).offset(10)
//            $0.leading.equalTo(titleLabel.snp.leading)
//            $0.trailing.equalTo(titleLabel.snp.trailing)
            $0.width.equalTo(stackView.snp.width)
            $0.height.equalTo(40)
        }
    }
}

extension SearchTableViewCell {
    func config(imgae: UIImage?, score: Double, title: String, genre: String) {
        posterImageView.image = imgae
        scoreLabel.text = "\(score)"
        titleLabel.text = title
        genreLabel.text = genre
    }
}
