//
//  MovieDetailViewController.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 3/2/26.
//
import UIKit
import SnapKit
import Kingfisher

final class MovieDetailViewController: ViewController {
    private let detailView = MovieDetailView()
    private let viewModel: MovieDetailViewModel
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.title = viewModel.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        configureDetailViewLabels()
        configureLayout()
    }

    private func configureLayout() {
        view.addSubview(detailView)

        detailView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func configureDetailViewLabels() {
        let url = URL(string: viewModel.imageURL)
        detailView.posterImageView.kf.setImage(with: url)
        
        detailView.titleLabel.text = viewModel.title
        detailView.genreLabel.text = viewModel.genre
        detailView.overviewLabel.text = viewModel.overview
        detailView.voteAverageLabel.text = viewModel.stars
        detailView.releaseDateLabel.text = viewModel.releaseDate
    }
}
