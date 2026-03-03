//
//  MovieDetailViewController.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 3/2/26.
//
import UIKit
import SnapKit

class MovieDetailViewController: ViewController {
    private let detailView = MovieDetailView()
    private let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        navigationItem.title = movie.title
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        configure()
    }

    private func configure() {
        view.addSubview(detailView)

        detailView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
    }
}
