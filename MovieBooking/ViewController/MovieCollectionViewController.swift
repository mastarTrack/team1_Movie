//
//  CollectionViewController.swift
//  MovieBooking
//
//  Created by Yeseul Jang on 2/26/26.
//

import UIKit
import SnapKit

class MovieCollectionViewController: UIViewController {
    private let viewModel = MovieCollectionViewModel()
    private let movieCollectionView = MovieCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        configure()
        bindViewModel()
        
        Task { await viewModel.fetchMovieData() }
    }
    
    // HomeView 접근 시 상단 네비게이션 제거
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    // 다른 페이지로 접근 시 상단 네비게이션 다시 생성
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func configure() {
        view.addSubview(movieCollectionView)
        
        movieCollectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalToSuperview()
        }
        
        movieCollectionView.collectionView.dataSource = self
        movieCollectionView.collectionView.delegate = self
    }
    
    // 뷰모델에서 신호 보낼때 어떤 동작할 건지 결정
    private func bindViewModel() {
        viewModel.onUpdate = { [weak self] in
            self?.movieCollectionView.collectionView.reloadData()
        }
        
        viewModel.onErrorMessage = { [weak self] message in
            guard let self else { return }
            self.showAlert(with: message)
        }
    }
    
    func showAlert(with message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
    }
    
}

extension MovieCollectionViewController: UICollectionViewDataSource {
    // 섹션의 개수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        MovieCollectionViewModel.Section.allCases.count
    }
    
    // 각 섹션당 아이템 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems(in: section)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PosterCell.identifier,
            for: indexPath
        ) as! PosterCell
        
        // Movie 하나 가져다가 넣어줌
        guard let movie = viewModel.getMovieInfo(at: indexPath) else {
            cell.setPoster(url: nil)
            return cell
        }
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = CGSize(width: 2, height: 10)
        cell.layer.shadowRadius = 10
        cell.layer.masksToBounds = false
        
        let posterURL = viewModel.makeImageURL(path: movie.posterPath)
        cell.setPoster(url: posterURL)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionHeader else {
            return UICollectionReusableView()
        }
        
        let header = collectionView.dequeueReusableSupplementaryView(
            ofKind: kind,
            withReuseIdentifier: SectionHeaderView.identifier,
            for: indexPath
        ) as! SectionHeaderView
        
        // enum에 CaseIterable로 가져옴
        let section = MovieCollectionViewModel.Section(rawValue: indexPath.section)
        header.configure(title: section?.title ?? "")
        return header
    }
}
// 사용자가 특정 위치(indexPath)의 셀을 터치했을 때 실행되는 콜백 함수
extension MovieCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = viewModel.getMovieInfo(at: indexPath) else { return }
        
        let detailVM = MovieDetailViewModel(movie: movie)
        let movieDetailVC = MovieDetailViewController(viewModel: detailVM)
        navigationController?.pushViewController(movieDetailVC, animated: true)
    }
}
