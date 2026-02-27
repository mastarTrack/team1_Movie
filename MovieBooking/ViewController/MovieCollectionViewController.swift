//
//  CollectionViewController.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 2/26/26.
//

import UIKit
import SnapKit

class MovieCollectionViewController: UIViewController {
    let viewModel = MovieCollectionViewModel()
    let movieCollectionView = MovieCollectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchMovieData()
        configure()
    }
    
    func configure() {
        view.addSubview(movieCollectionView)
        
        movieCollectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
