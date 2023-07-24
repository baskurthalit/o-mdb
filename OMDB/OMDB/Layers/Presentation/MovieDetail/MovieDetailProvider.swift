//
//  MovieDetailProvider.swift
//  OMDB
//
//  Created by Halit Baskurt on 24.07.2023.
//

import UIKit


protocol MovieDetailProvider {
    var stateClosure: ((ObservationType<MovieDetailProviderImpl.UserInteractive, Error>) -> ())? { get set }
    
    func setupTableView(_ tableView: UITableView)
    func setProviderData(contentData : [MovieDetailProviderImpl.SectionType])
}

final class MovieDetailProviderImpl: NSObject, MovieDetailProvider {
    var stateClosure: ((ObservationType<UserInteractive, Error>) -> ())?
    
    private weak var tableView : UITableView?
    private var dataList : [SectionType] = []
    
    func setupTableView(_ tableView: UITableView) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView = tableView
            let cells = [MovieDetailPosterCell.self, MovieDetailInfoCell.self]
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

extension MovieDetailProviderImpl: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int { dataList.count }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionType = dataList[section]
        switch sectionType {
        case .Detail(let rows): return rows.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionType = dataList[indexPath.section]
        switch sectionType {
        case .Detail(let rows):
            let rowType = rows[indexPath.row]
            
            switch rowType {
            case .imagePoster(let posterURL):
                let moviePoster = tableView.dequeueReusableCell(with: MovieDetailPosterCell.self, for: indexPath)
                moviePoster.setupCell(imageUrl: posterURL)
                return moviePoster
            case .imageInformation(let movieItem):
                let movieDetailInfo = tableView.dequeueReusableCell(with: MovieDetailInfoCell.self, for: indexPath)
                movieDetailInfo.setupCell(with: movieItem)
                return movieDetailInfo
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionType = dataList[indexPath.section]
        switch sectionType {
        case .Detail(let rows):
        
            let rowType = rows[indexPath.row]
            switch rowType {
            case .imagePoster(let movieItem): break
            case .imageInformation(let movieItem): break
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let sectionType = dataList[indexPath.section]
        switch sectionType {
            
        case .Detail(let rows):
            let rowType = rows[indexPath.row]
            switch rowType {
            case .imageInformation: return 100
            case .imagePoster: return tableView.frame.width
            }
        }
    }
}

//MARK: UserInteractive
extension MovieDetailProviderImpl {
    enum UserInteractive {
        case didTapMoviePoster(movieItem: MovieItem)
    }
    
}

//MARK: Sections & Rows
extension MovieDetailProviderImpl {
    enum SectionType {
        case Detail(rows: [RowType])
    }
    
    enum RowType {
        case imagePoster(posterUrl : String)
        case imageInformation(movieItem: MovieItem)
    }
}

