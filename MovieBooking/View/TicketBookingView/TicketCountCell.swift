//
//  TicketCountCell.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 3/4/26.
//
import UIKit
import SnapKit

final class TicketCountCell: UICollectionViewCell {
    static let identifier = "TicketCountCell"

    private let containerView = UIView()

    private let leftStackView = UIStackView()
    private let titleLabel = UILabel()
    private let priceLabel = UILabel()

    private let rightStackView = UIStackView()
    private let minusButton = UIButton(type: .system)
    private let countLabel = UILabel()
    private let plusButton = UIButton(type: .system)

    // 값전달
    private(set) var count: Int = 0
    var onTapMinus: (() -> Void)?
    var onTapPlus: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
        setupActions()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String, priceText: String, count: Int, isMinusEnabled: Bool = true) {
        titleLabel.text = title
        priceLabel.text = priceText
        setCount(count)
        minusButton.isEnabled = isMinusEnabled
        //minusButton.alpha = isMinusEnabled ? 1.0 : 0.35
    }

    func setCount(_ newValue: Int) {
        count = max(0, newValue)
        countLabel.text = "\(count)"
    }

    private func setupUI() {
        backgroundColor = .clear
        contentView.backgroundColor = .clear


        containerView.backgroundColor = .systemGray6
        containerView.layer.cornerRadius = 16
        containerView.layer.masksToBounds = true
        contentView.addSubview(containerView)

        // 왼쪽 설명
        leftStackView.axis = .vertical
        leftStackView.spacing = 4
        leftStackView.alignment = .leading

        titleLabel.font = .systemFont(ofSize: 17, weight: .semibold)
        titleLabel.textColor = .label

        priceLabel.font = .systemFont(ofSize: 14, weight: .regular)
        priceLabel.textColor = .secondaryLabel

        leftStackView.addArrangedSubview(titleLabel)
        leftStackView.addArrangedSubview(priceLabel)

        // 오른쪽 count랑 버튼들
        rightStackView.axis = .horizontal
        rightStackView.spacing = 14
        rightStackView.alignment = .center
        rightStackView.distribution = .equalCentering

        // 버튼 디자인
        styleCircleButton(minusButton, title: "-")
        styleCircleButton(plusButton, title: "+")

        // 가운데 수량
        countLabel.font = .systemFont(ofSize: 20, weight: .semibold)
        countLabel.textColor = .label
        countLabel.textAlignment = .center
        countLabel.text = "0"
        countLabel.setContentHuggingPriority(.required, for: .horizontal)

        rightStackView.addArrangedSubview(minusButton)
        rightStackView.addArrangedSubview(countLabel)
        rightStackView.addArrangedSubview(plusButton)

        containerView.addSubview(leftStackView)
        containerView.addSubview(rightStackView)
    }

    private func styleCircleButton(_ button: UIButton, title: String) {
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.tintColor = .secondaryLabel

        button.backgroundColor = .clear
        button.layer.cornerRadius = 22
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.layer.masksToBounds = true

        button.snp.makeConstraints {
            $0.width.height.equalTo(44)
        }
    }

    private func setupLayout() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        leftStackView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }

        rightStackView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }

        // 왼쪽-오른쪽 안달라붙게
        leftStackView.snp.makeConstraints {
            $0.trailing.lessThanOrEqualTo(rightStackView.snp.leading).offset(-12)
        }
    }

    private func setupActions() {
        minusButton.addAction(UIAction { [weak self] _ in
            self?.onTapMinus?()
        }, for: .touchUpInside)

        plusButton.addAction(UIAction { [weak self] _ in
            self?.onTapPlus?()
        }, for: .touchUpInside)
    }
}
