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
        [infoLabel, watchDateLael].forEach {
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .darkGray
        }
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        
    }
    private func setLayout() {
        contentView.addSubview(containerView)
        [titleLabel, infoLabel, watchDateLael].forEach { stackView.addArrangedSubview($0) }
        [posterImageView, stackView, writeButton].forEach { containerView.addSubview($0) }
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview().inset(10)
            $0.width.equalTo(100)
            $0.height.equalTo(150)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(10)
            $0.trailing.equalTo(writeButton.snp.leading).offset(-10)
            $0.bottom.equalTo(posterImageView.snp.bottom)
        }
        
        writeButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-10)
            $0.width.equalTo(80)
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
