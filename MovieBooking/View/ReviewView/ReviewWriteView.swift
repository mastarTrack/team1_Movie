//
//  ReviewWriteView.swift
//  MovieBooking
//
//  Created by 손영빈 on 3/5/26.
//

import UIKit
import SnapKit
import Kingfisher

class ReviewWriteView: UIView {
    
    private var currentStar = 0
    private var starImageViews: [UIImageView] = []
    
    private let posterImageView = UIImageView()
    
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    
    private let starStackView = UIStackView()
    let textView = UITextView()
    let writeButton = CustomButton(title: "리뷰 등록")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAttributes()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ReviewWriteView {
    private func setAttributes() {
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.layer.cornerRadius = 10
        posterImageView.clipsToBounds = true
        posterImageView.backgroundColor = .white
        
        titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        
        dateLabel.font = .systemFont(ofSize: 14)
        dateLabel.textColor = .darkGray
        
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        
        starStackView.axis = .horizontal
        starStackView.spacing = 10
        starStackView.distribution = .fillEqually
        for i in 1...5 {
            let starImageView = UIImageView(image: UIImage(systemName: "star"))
            starImageView.tintColor = .systemOrange
            starImageView.contentMode = .scaleAspectFit
            starImageView.tag = i
            starImageView.isUserInteractionEnabled = true
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(starTapped(sender:)))
            starImageView.addGestureRecognizer(gesture)
            
            starStackView.addArrangedSubview(starImageView)
            starImageViews.append(starImageView)
        }
        
        textView.text = "영화에 대한 솔직한 리뷰를 남겨 주세요. (선택)"
        textView.textColor = .lightGray
        textView.backgroundColor = .systemGray6
        textView.layer.cornerRadius = 20
        textView.font = .boldSystemFont(ofSize: 16)
        textView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
    
    private func setLayout() {
        [titleLabel, dateLabel].forEach { stackView.addArrangedSubview($0) }
        [posterImageView, stackView, starStackView, textView, writeButton].forEach{ addSubview($0) }
        
        posterImageView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(40)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(100)
            $0.height.equalTo(150)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.top)
            $0.leading.equalTo(posterImageView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(posterImageView.snp.bottom)
        }
        
        starStackView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(40)
        }
        
        textView.snp.makeConstraints {
            $0.top.equalTo(starStackView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(200)
        }
        writeButton.snp.makeConstraints {
            $0.top.equalTo(textView.snp.bottom).offset(40)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(50)
        }
    }
}

extension ReviewWriteView {
    func config(data: Reservation) {
        
        if let url = URL(string: data.safePosterPath) {
            posterImageView.kf.setImage(with: url)
        } else {
            posterImageView.image = UIImage(systemName: "movieclapper")
        }
        
        titleLabel.text = data.safeTitle
        dateLabel.text = data.safeWatchDate
    }
}

extension ReviewWriteView {
    func updateStar(starCount: Int) {
        self.currentStar = starCount
        
        for (index, starImageView) in starImageViews.enumerated() {
            if index < starCount {
                starImageView.image = UIImage(systemName: "star.fill")
            } else {
                starImageView.image = UIImage(systemName: "star")
            }
        }
    }
    
    @objc
    private func starTapped(sender: UITapGestureRecognizer) {
        guard let tappedView = sender.view else { return }
        updateStar(starCount: tappedView.tag)
    }
}

