//
//  MovieDetailView.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 3/2/26.
//
import UIKit
import SnapKit
import Then
import Kingfisher

class MovieDetailView: UIView {
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let contentStackView = UIStackView()

    private let posterImageView = UIImageView()
    private let titleLabel = UILabel()
    private let genreLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private let popularityLabel = UILabel()

    private let voteAverageLabel = UILabel()
    private let voteCountLabel = UILabel()

    private let overviewLabel = UILabel()
    private let reservationButton = CustomButton(title: "예매하기")

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground

        configureView()
        configureLayout()
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
        
        posterImageView.snp.makeConstraints {
            $0.height.equalTo(posterImageView.snp.width).multipliedBy(0.5)
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
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

    func configureLabel(movie: Movie) {
        if let urlForDetail = movie.backdropPath {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(urlForDetail)")
            posterImageView.kf.setImage(with: url)
        }
        
        titleLabel.apply(.descriptionText)
        titleLabel.text = movie.title

        genreLabel.apply(.descriptionText)
        genreLabel.text = "스릴러, 공포"

        releaseDateLabel.apply(.descriptionText)
        releaseDateLabel.text = movie.releaseDate

        popularityLabel.apply(.descriptionText)
        popularityLabel.text = "이건 뺄까.."

        overviewLabel.apply(.descriptionText)
        overviewLabel.text = movie.overview

        voteAverageLabel.apply(.descriptionText)
        voteAverageLabel.text = "⭐️⭐️⭐️⭐️(3.84)"
    }

    func configureLayout() {
        let titleMarkLabel = UILabel(text: "제목", config: .descriptionTitle)
        let genreMarkLabel = UILabel(text: "장르", config: .descriptionTitle)
        let releaseDateMarkLabel = UILabel(text: "개봉일", config: .descriptionTitle)
        let popularityMarkLabel = UILabel(text: "인기", config: .descriptionTitle)

        let titleStackView = UIStackView.horizontal([titleMarkLabel, titleLabel])
        let genreStackView = UIStackView.horizontal([genreMarkLabel, genreLabel])
        let releaseDateStackView = UIStackView.horizontal([releaseDateMarkLabel, releaseDateLabel])
        let popularityStackView = UIStackView.horizontal([popularityMarkLabel, popularityLabel])

        let posterDetailStackView = UIStackView.vertical([titleStackView, genreStackView, releaseDateStackView, popularityStackView])

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
        contentStackView.addArrangedSubview(posterDetailStackView)
        contentStackView.addArrangedSubview(reservationButton)
        contentStackView.addArrangedSubview(layoutView)
    }
}
