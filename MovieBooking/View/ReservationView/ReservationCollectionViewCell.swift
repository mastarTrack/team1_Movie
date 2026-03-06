//
//  ReservationCollectionViewCell.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/5/26.
//

import UIKit
import SnapKit
import Kingfisher

class ReservationCollectionViewCell: UICollectionViewCell {
    
    static let id = "ReservationCollectionViewCell"
    
    private let containerView = UIView()
    private let idLabel = UILabel()
    
    private let seperateView = UIView()
    private let posterImageView = UIImageView()
    
    private let infoStackView = UIStackView()
    private let titleLabel = UILabel()
//    private let genreLabel = UILabel()
    
    private let locationLabel = UILabel()
    private let dateLabel = UILabel()
    private let timeLabel = UILabel()
    private let peopleLabel = UILabel()
    private let seatLabel = UILabel()
    
    private let priceTitleLabel = UILabel()
    private let priceValueLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAttributes()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ReservationCollectionViewCell {
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
        
        [locationLabel, dateLabel, timeLabel, peopleLabel, seatLabel].forEach {
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .darkGray
        }
        
        infoStackView.axis = .vertical
        infoStackView.alignment = .leading
        infoStackView.distribution = .fillEqually
        
        priceTitleLabel.text = "결제 금액"
        priceTitleLabel.font = .systemFont(ofSize: 14)
        priceTitleLabel.textColor = .systemGray
        
        priceValueLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
    }
    
    private func setLayout() {
        contentView.addSubview(containerView)
        [titleLabel, locationLabel, dateLabel, timeLabel, peopleLabel, seatLabel].forEach { infoStackView.addArrangedSubview($0) }
        [posterImageView, infoStackView].forEach { seperateView.addSubview($0) }
        [idLabel, seperateView, priceTitleLabel, priceValueLabel].forEach { containerView.addSubview($0) }
        
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
        
        priceTitleLabel.snp.makeConstraints {
            $0.top.equalTo(seperateView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
        }
        
        priceValueLabel.snp.makeConstraints {
            $0.top.equalTo(priceTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(10)
            $0.bottom.equalToSuperview().inset(20)
        }
    }
}

extension ReservationCollectionViewCell {
    func config(data: Reservation) {
        idLabel.text = data.safeId.uuidString.prefix(12).uppercased()
        
        if let url = URL(string: data.safePosterPath) {
            posterImageView.kf.setImage(with: url)
        } else {
            posterImageView.image = UIImage(systemName: "movieclapper")
        }
        
        titleLabel.text = data.safeTitle
        locationLabel.text = data.safeTheaterName
        dateLabel.text = data.safeWatchDate
        timeLabel.text = data.safeWatchTime
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        if let formattedPrice = formatter.string(from: NSNumber(value: data.intPrice)) {
            priceValueLabel.text = "\(formattedPrice)원"
        } else {
            priceValueLabel.text = "\(data.intPrice)원"
        }
        
        let adultCount = data.intAdult
        let childCount = data.intChild
        let totalCount = adultCount + childCount
        let adultText = adultCount > 0 ? "성인 \(adultCount)명" : ""
        let childText = childCount > 0 ? "어린이 \(childCount)명" : ""
        
        peopleLabel.text = "\(totalCount)명 (\(adultText) \(childText))"
        
        seatLabel.text = "좌석: \(data.safeSeat)"
        
    }
}
