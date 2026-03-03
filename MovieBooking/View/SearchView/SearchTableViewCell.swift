//
//  SearchTableViewCell.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/27/26.
//


import UIKit
import SnapKit
import Kingfisher

protocol SearchTableViewCellDelegate: AnyObject {
    func didTapDetailButton(cell: SearchTableViewCell)
}

class SearchTableViewCell: UITableViewCell {
    
    static let id = "SearchTableViewCell"
    
    weak var delegate: SearchTableViewCellDelegate?
    
    private let containerView = UIView()
    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let stackView = UIStackView()
    private let scoreLabel = UILabel()
    private let dateLabel = UILabel()
    private let detailButton = CustomButton(title: "정보 보기")
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none // 클릭 음영 제거
        setAttributes()
        setLayout()
        setAction()
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
        
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = .secondaryLabel
        
    }
    private func setLayout() {
        contentView.addSubview(containerView)
        [titleLabel, dateLabel, detailButton].forEach { stackView.addArrangedSubview($0) }
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
        stackView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.top).offset(10)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().offset(-10)
            $0.bottom.equalTo(posterImageView.snp.bottom).offset(-10)
        }
        detailButton.snp.makeConstraints {
            $0.width.equalTo(stackView.snp.width)
            $0.height.equalTo(40)
        }
    }
}

extension SearchTableViewCell {
    func config(posterURL: URL?, score: Double, title: String, date: String) {
        if let url = posterURL {
            posterImageView.kf.setImage(with: url)
        } else {
            posterImageView.image = UIImage(systemName: "movieclapper")
        }
        scoreLabel.text = String(format: "%.1f", score)
        titleLabel.text = title
        dateLabel.text = "개봉일: \(date)"
    }
}

extension SearchTableViewCell {
    private func setAction() {
        detailButton.addTarget(self, action: #selector(detailButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func detailButtonTapped() {
        delegate?.didTapDetailButton(cell: self)
    }
}
