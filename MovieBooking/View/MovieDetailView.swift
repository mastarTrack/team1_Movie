//
//  MovieDetailView.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 3/2/26.
//
import UIKit
import SnapKit
import Then

class MovieDetailView: UIView {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let contentStackView = UIStackView()

    let posterImageView = UIImageView()
    let titleLabel = UILabel()
    let genreLabel = UILabel()
    let releaseDateLabel = UILabel()

    let voteAverageLabel = UILabel()

    let overviewLabel = UILabel()
    private let reservationButton = CustomButton(title: "예매하기")
    
    // 눌렸음을 알림
    var onTapReservation: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground

        configureView()
        configureLabel()
        configureLayout()
        
        // 버튼 액션 등록하기
        reservationButton.addAction(UIAction { [weak self] _ in
            self?.onTapReservation?()
        }, for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureView() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)
        contentView.addSubview(posterImageView)
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        posterImageView.contentMode = .scaleAspectFill
        posterImageView.clipsToBounds = true
        
        posterImageView.snp.makeConstraints {
            $0.height.equalTo(posterImageView.snp.width).multipliedBy(9.0/16.0)
            $0.leading.trailing.top.equalToSuperview()
        }

        contentStackView.snp.makeConstraints {
            $0.top.equalTo(posterImageView.snp.bottom).offset(25)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
        }

        reservationButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
    }

    func configureLabel() {
        titleLabel.apply(.descriptionText)
        genreLabel.apply(.descriptionText)
        releaseDateLabel.apply(.descriptionText)
        overviewLabel.apply(.descriptionText)
        voteAverageLabel.apply(.descriptionText)
    }

    func configureLayout() {
        let titleMarkLabel = UILabel(text: "제목", config: .descriptionTitle)
        let genreMarkLabel = UILabel(text: "장르", config: .descriptionTitle)
        let releaseDateMarkLabel = UILabel(text: "개봉일", config: .descriptionTitle)

        let titleStackView = UIStackView.horizontal([titleMarkLabel, titleLabel])
        let genreStackView = UIStackView.horizontal([genreMarkLabel, genreLabel])
        let releaseDateStackView = UIStackView.horizontal([releaseDateMarkLabel, releaseDateLabel])

        let detailStackView = UIStackView.vertical([titleStackView, genreStackView, releaseDateStackView])

        let voteAverageMarkLabel = UILabel(text: "관람객 평점", config: .descriptionTitle)
        let voteStackView = UIStackView.horizontal([voteAverageMarkLabel, voteAverageLabel])
        
        let layoutView = UIView().then {
            $0.backgroundColor = .clear
        }
        
        layoutView.snp.makeConstraints {
            $0.height.equalTo(60)
        }

        contentStackView.axis = .vertical
        contentStackView.spacing = 25
        contentStackView.alignment = .fill
        contentStackView.distribution = .fill

        contentStackView.addArrangedSubview(voteStackView)
        contentStackView.addArrangedSubview(overviewLabel)
        contentStackView.addArrangedSubview(detailStackView)
        contentStackView.addArrangedSubview(reservationButton)
        contentStackView.addArrangedSubview(layoutView)
    }
}
