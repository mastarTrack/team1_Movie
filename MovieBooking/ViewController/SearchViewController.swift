//
//  SearchViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/27/26.
//

//TODO: MVVM으로 구조 변경 -> 완료

import UIKit

class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    private let viewModel = SearchViewModel()
    
    override func loadView() {
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        bind()
        viewModel.fetchMovies()
    }
}

extension SearchViewController {
    private func bind() {
        viewModel.updateUI = { [weak self] in
            DispatchQueue.main.async {
                self?.searchView.tableView.reloadData()
            }
        }
    }
}
extension SearchViewController {
    private func setDelegate() {
        searchView.tableView.delegate = self
        searchView.tableView.dataSource = self
        searchView.tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.id)
        
        searchView.searchBar.delegate = self
    }
}

extension SearchViewController {
    private func fetchAllMovies() {
        viewModel.fetchMovies()
    }
}

extension SearchViewController: UITableViewDelegate {
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if viewModel.isMovieEmpty {
            let emptyLabel = UILabel()
            emptyLabel.text = "검색 결과 없음"
            emptyLabel.textAlignment = .center
            tableView.backgroundView = emptyLabel
        } else {
            tableView.backgroundView = nil
        }
        return viewModel.movieCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        let movie = viewModel.getMovieData(index: indexPath.row)
        let posterURL = viewModel.getPosterURL(index: indexPath.row)
        cell.config(posterURL: posterURL, score: movie.voteAverage, title: movie.title, genre: "Action")
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searchText: searchText)
    }
}

