//
//  SearchViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/27/26.
//

//TODO: MVVM으로 구조 변경

import UIKit

class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    private let networkManager = NetworkManager()
    
    private var allMovies: [Movie] = []
    private var viewMovies: [Movie] = []
    
    override func loadView() {
        self.view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllMovies()
        setDelegate()
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
        Task {
            do {
                async let nowPlaying = networkManager.fetchMovies(type: .NowPlaying)
                async let upComing = networkManager.fetchMovies(type: .upcoming)
                
                let unfilteredMovies = try await (nowPlaying + upComing)
                allMovies = removeDuplicatedData(movies: unfilteredMovies)
                viewMovies = allMovies
                
                DispatchQueue.main.async {
                    self.searchView.tableView.reloadData()
                }
            } catch {
                print("Fetch Data Failed")
            }
        }
    }
    
    private func removeDuplicatedData(movies: [Movie]) -> [Movie] {
        var uniqueMovies: [Movie] = []
        for movie in movies {
            if !uniqueMovies.contains(where: { $0.id == movie.id }) {
                uniqueMovies.append(movie)
            }
        }
        return uniqueMovies
    }
}

extension SearchViewController: UITableViewDelegate {
    
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if viewMovies.isEmpty {
            let emptyLabel = UILabel()
            emptyLabel.text = "검색 결과 없음"
            emptyLabel.textAlignment = .center
            tableView.backgroundView = emptyLabel
        } else {
            tableView.backgroundView = nil
        }
        return viewMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        let movie = viewMovies[indexPath.row]
        cell.config(posterPath: movie.posterPath, score: movie.voteAverage, title: movie.title, genre: "Action")
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            viewMovies = allMovies
        } else {
            viewMovies = allMovies.filter { movie in
                movie.title.uppercased().contains(searchText.uppercased())
            }
        }
        searchView.tableView.reloadData()
    }
}

