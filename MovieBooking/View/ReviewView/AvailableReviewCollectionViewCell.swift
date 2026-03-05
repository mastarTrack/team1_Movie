//
//  AvailableReviewCollectionViewCell.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/5/26.
//

import UIKit
import SnapKit
import Kingfisher

protocol AvailableReviewCollectionViewCellDelegate: AnyObject {
    func didTapWriteButton(cell: AvailableReviewCollectionViewCell)
}

class AvailableReviewCollectionViewCell: UICollectionViewCell {
    static let id = "AvailableReviewCollectionViewCell"
    
    weak var delegate: AvailableReviewCollectionViewCellDelegate?
    
    private let containerView = UIView()
    private let posterImageView = UIImageView()
    
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let infoLabel = UILabel()
    private let watchDateLael = UILabel()
    private let peopleLabel = UILabel()
    
    private let writeButton = CustomButton(title: "작성")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAttributes()
        setLayout()
        setAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AvailableReviewCollectionViewCell {
    private func setAttributes() {
        containerView.backgroundColor = .systemGray6
        containerView.layer.cornerRadius = 20
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.systemGray5.cgColor
        
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 10
        posterImageView.clipsToBounds = true
        posterImageView.backgroundColor = .white
        
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        [infoLabel, watchDateLael, peopleLabel].forEach {
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .darkGray
        }
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 8
        
    }
    private func setLayout() {
        contentView.addSubview(containerView)
        [titleLabel, infoLabel, watchDateLael, peopleLabel, writeButton].forEach { stackView.addArrangedSubview($0) }
        [posterImageView, stackView].forEach { containerView.addSubview($0) }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(100)
            $0.height.equalTo(150)
        }
        
        stackView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(10)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(10)
            $0.bottom.equalTo(posterImageView.snp.bottom)
        }
        
        writeButton.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
            $0.height.equalTo(40)
        }
    }
}

extension AvailableReviewCollectionViewCell {
    func config(data: Reservation) {
        
        if let url = URL(string: data.safePosterPath) {
            posterImageView.kf.setImage(with: url)
        } else {
            posterImageView.image = UIImage(systemName: "movieclapper")
        }
        
        titleLabel.text = data.safeTitle
        infoLabel.text = data.safeTheaterName
        watchDateLael.text = "\(data.safeWatchDate) 관람"
        
        let adultCount = data.intAdult
        let childCount = data.intChild
        let totalCount = adultCount + childCount
        let adultText = adultCount > 0 ? "성인 \(adultCount)명" : ""
        let childText = childCount > 0 ? "어린이 \(childCount)명" : ""
        
        peopleLabel.text = "\(totalCount)명 ( \(adultText) \(childText))"
        
    }
}

extension AvailableReviewCollectionViewCell {
    private func setAction() {
        writeButton.addTarget(self, action: #selector(writeButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func writeButtonTapped() {
        delegate?.didTapWriteButton(cell: self)
    }
}
