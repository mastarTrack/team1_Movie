//
//  ReviewCollectionViewCell.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/5/26.
//

import UIKit
import SnapKit
import Kingfisher

class ReviewCollectionViewCell: UICollectionViewCell {
    
    static let id = "ReviewCollectionViewCell"
    
    private let containerView = UIView()
    private let idLabel = UILabel()
    
    private let seperateView = UIView()
    private let posterImageView = UIImageView()
    
    private let infoStackView = UIStackView()
    private let titleLabel = UILabel()
//    private let genreLabel = UILabel()
    
    private let locationLabel = UILabel()
    private let dateLabel = UILabel()
    private let peopleLabel = UILabel()
    private let starLabel = UILabel()
    
    
    private let reviewTitleLabel = UILabel()
    private let reviewContentLabel = UILabel()
    private let writtenDateLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAttributes()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ReviewCollectionViewCell {
    private func setAttributes() {
        containerView.backgroundColor = .systemGray6
        containerView.layer.cornerRadius = 20
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.systemGray5.cgColor
        
        seperateView.backgroundColor = .systemBackground
        seperateView.layer.borderWidth = 1
        seperateView.layer.borderColor = UIColor.systemGray5.cgColor
        
        idLabel.font = .systemFont(ofSize: 12)
        idLabel.textColor = .systemGray
        
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 10
        posterImageView.clipsToBounds = true
        posterImageView.backgroundColor = .white
        
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
//        genreLabel.font = .systemFont(ofSize: 12)
//        genreLabel.textColor = .systemGray
        
        [locationLabel, dateLabel, peopleLabel].forEach {
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .darkGray
        }
        
        infoStackView.axis = .vertical
        infoStackView.alignment = .leading
        infoStackView.distribution = .fillEqually
        
        starLabel.font = .systemFont(ofSize: 14)
        starLabel.textColor = .systemOrange
        
        reviewTitleLabel.text = "리뷰 내용"
        reviewTitleLabel.font = .systemFont(ofSize: 14)
        reviewTitleLabel.textColor = .systemGray
        
        reviewContentLabel.font = .systemFont(ofSize: 14)
        reviewContentLabel.numberOfLines = 0
        reviewContentLabel.textColor = .label
        
        writtenDateLabel.font = .boldSystemFont(ofSize: 12)
        writtenDateLabel.textColor = .systemGray
        
    }
    
    private func setLayout() {
        contentView.addSubview(containerView)
        [titleLabel, locationLabel, dateLabel, peopleLabel, starLabel].forEach { infoStackView.addArrangedSubview($0) }
        [posterImageView, infoStackView].forEach { seperateView.addSubview($0) }
        [idLabel, seperateView, reviewTitleLabel, reviewContentLabel, writtenDateLabel].forEach { containerView.addSubview($0) }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        idLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
        }
        
        seperateView.snp.makeConstraints {
            $0.top.equalTo(idLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(10)
            $0.width.equalTo(100)
            $0.height.equalTo(150)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
        infoStackView.snp.makeConstraints {
            $0.top.equalTo(posterImageView)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalTo(posterImageView.snp.bottom)
        }
        
        reviewTitleLabel.snp.makeConstraints {
            $0.top.equalTo(seperateView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().offset(10)
        }
        
        reviewContentLabel.snp.makeConstraints {
            $0.top.equalTo(reviewTitleLabel.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview().inset(10)
        }
        
        writtenDateLabel.snp.makeConstraints {
            $0.top.equalTo(reviewContentLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().offset(-10)
        }
        
    }
}

extension ReviewCollectionViewCell {
    func config(data: Review) {
        
        guard let reservation = data.reservation else { return }
        
        idLabel.text = reservation.safeId.uuidString.prefix(12).uppercased()
        
        if let url = URL(string: reservation.safePosterPath) {
            posterImageView.kf.setImage(with: url)
        } else {
            posterImageView.image = UIImage(systemName: "movieclapper")
        }
        
        titleLabel.text = reservation.safeTitle
        locationLabel.text = reservation.safeTheaterName
        dateLabel.text = "\(reservation.safeWatchDate) \(reservation.safeWatchTime)"
        
        
        let adultCount = reservation.intAdult
        let childCount = reservation.intChild
        let totalCount = adultCount + childCount
        let adultText = adultCount > 0 ? "성인 \(adultCount)명" : ""
        let childText = childCount > 0 ? "어린이 \(childCount)명" : ""
        
        peopleLabel.text = "\(totalCount)명 ( \(adultText) \(childText))"
        
        let stars = String(repeating: "⭐️", count: Int(data.rating))
        starLabel.text = "\(stars)"
        
        reviewContentLabel.text = data.content ?? "내용 없음"
        
        if let writeDate = data.date {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy. MM. dd HH:mm"
            writtenDateLabel.text = "\(formatter.string(from: writeDate)) 작성"
        }
        
    }
}

