//
//  BookingCell.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 3/4/26.
//
import UIKit
import SnapKit

final class BookingCell: UICollectionViewCell {
    
    static let identifier = "BookingCell"
    
    // 예매하기
    var onTapBooking: (() -> Void)?
    
    private let containerView = UIView()
    private let leftStackView = UIStackView()
    private let guideLabel = UILabel()
    private let priceLabel = UILabel()
    
    private let bookingButton = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureLayout()
        
        // 버튼 액션 등록하기
        bookingButton.addAction(UIAction { [weak self] _ in
            self?.onTapBooking?()
        }, for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension BookingCell {
    
    func configureUI() {
        contentView.backgroundColor = .systemBackground
        
        contentView.addSubview(containerView)
        
        // 왼쪽 스택뷰
        leftStackView.axis = .vertical
        leftStackView.spacing = 6
        leftStackView.alignment = .leading
        
        guideLabel.text = "인원을 선택해주세요"
        guideLabel.font = .systemFont(ofSize: 14)
        guideLabel.textColor = .secondaryLabel
        
        priceLabel.text = "0원"
        priceLabel.font = .systemFont(ofSize: 28, weight: .bold)
        priceLabel.textColor = .label
        
        leftStackView.addArrangedSubview(guideLabel)
        leftStackView.addArrangedSubview(priceLabel)
        
        // 예매 버튼
        bookingButton.setTitle("예매하기", for: .normal)
        bookingButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        bookingButton.backgroundColor = .systemGray5
        bookingButton.setTitleColor(.systemGray, for: .normal)
        bookingButton.layer.cornerRadius = 14
        
        containerView.addSubview(leftStackView)
        containerView.addSubview(bookingButton)
    }
    
    func configureLayout() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
        
        leftStackView.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
        
        bookingButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.width.equalTo(120)
            $0.height.equalTo(48)
        }
        
        leftStackView.snp.makeConstraints {
            $0.trailing.lessThanOrEqualTo(bookingButton.snp.leading).offset(-12)
        }
    }
}

extension BookingCell {
    func configure(guideText: String, priceText: String) {
        guideLabel.text = guideText
        priceLabel.text = priceText
    }
}
