//
//  MovieSummaryView.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 3/4/26.
//
import UIKit
import SnapKit
import Kingfisher

class MovieSummaryView: UIView {
    private let containerView = UIView()
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    private let dateLabel = UILabel()
    private let genreLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setAttributes()
        setLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieSummaryView {
    private func setAttributes() {
        
        containerView.backgroundColor = .systemGray6
        
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 10
        posterImageView.clipsToBounds = true
        posterImageView.backgroundColor = .white
        
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .label
        
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = .secondaryLabel
        
        genreLabel.font = .systemFont(ofSize: 14)
        genreLabel.textColor = .secondaryLabel
    }
    
    private func setLayout() {
        addSubview(containerView)
        
        [titleLabel, genreLabel, dateLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        
        [posterImageView, stackView].forEach {
            containerView.addSubview($0)
        }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20)
            $0.leading.equalToSuperview().inset(20)
            $0.width.equalTo(75)
            $0.height.equalTo(posterImageView.snp.width).multipliedBy(1.5)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.top).offset(10)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalTo(posterImageView.snp.bottom).offset(-10)
        }
    }
    
    func config(posterURL: URL?, genre: String, title: String, date: String) {
        if let url = posterURL {
            posterImageView.kf.setImage(with: url)
        } else {
            posterImageView.image = UIImage(systemName: "movieclapper")
        }
        titleLabel.text = title
        dateLabel.text = "개봉일: \(date)"
        genreLabel.text = "장르: \(genre)"
    }
}
