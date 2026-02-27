//
//  SearchViewController.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/27/26.
//

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
        viewMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.id, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        let movie = viewMovies[indexPath.row]
        cell.config(imgae: nil, score: movie.voteAverage, title: movie.title, genre: "Action")
        return cell
    }
}

