//
//  SearchMovieProvider.swift
//  OMDB
//
//  Created by Halit Baskurt on 22.07.2023.
//

import UIKit


protocol SearchMovieProvider {
    var stateClosure: ((ObservationType<SearchMovieProviderImpl.UserInteractive, Error>) -> ())? { get set }
    
    func setupTableView(_ tableView: UITableView)
    func setProviderData(contentData : [SearchMovieProviderImpl.SectionType])
}

final class SearchMovieProviderImpl: NSObject, SearchMovieProvider {
    var stateClosure: ((ObservationType<UserInteractive, Error>) -> ())?
    
    private weak var tableView : UITableView?
    private var dataList : [SectionType] = []
    
    func setupTableView(_ tableView: UITableView) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView = tableView
            let cells = [MovieCell.self, SearchMovieEmptyCell.self]
            self?.tableView?.register(cellTypes: cells)
            self?.tableView?.dataSource = self
            self?.tableView?.delegate = self
        }
    }
    
    func setProviderData(contentData : [SectionType]) {
        self.dataList = contentData
        tableViewReload()
    }
    
    func tableViewReload() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView?.reloadData()
        }
    }
}

extension SearchMovieProviderImpl: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int { dataList.count }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = dataList[section]
        switch sectionType {
        case .empty: return 1
        case .movie(let rows): return rows.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = dataList[indexPath.section]
        switch sectionType {
        case .movie(let rows):
            let rowType = rows[indexPath.row]
            
            switch rowType {
            case .movieRow(let movie):
                let movieCell = tableView.dequeueReusableCell(with: MovieCell.self, for: indexPath)
                movieCell.setupCell(with: movie)
                return movieCell
            }
            
        case .empty(let infoText, let textColor):
            let emptyCell = tableView.dequeueReusableCell(with: SearchMovieEmptyCell.self, for: indexPath)
            emptyCell.setupCell(infoText: infoText, textColor: textColor)
            return emptyCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = dataList[indexPath.section]
        switch sectionType {
        case .empty: return 400
        case .movie: return 110
        }
    }
}

//MARK: UserInteractive
extension SearchMovieProviderImpl {
    enum UserInteractive {
        case didTapMovie
    }
    
}

//MARK: Sections & Rows
extension SearchMovieProviderImpl {
    enum SectionType {
        case empty(infoText: String = "", textColor: UIColor = .black.withAlphaComponent(0.5))
        case movie(rows: [MovieRowType])
    }
    
    enum MovieRowType {
        case movieRow(movieItem: MovieItem)
    }
}

