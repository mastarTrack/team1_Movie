//
//  SearchView.swift
//  MovieBooking
//
//  Created by 손영빈 on 2/27/26.
//

import UIKit
import SnapKit

class SearchView: UIView {
    
    private let tableView = SearchTableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setAttributes()
        setLayout()
        setDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchView {
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
}

extension SearchView {
    private func setAttributes() {
        
    }
    private func setLayout() {
        addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.bottom.equalTo(safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }
}

extension SearchView: UITableViewDelegate {
    
}

extension SearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
}
