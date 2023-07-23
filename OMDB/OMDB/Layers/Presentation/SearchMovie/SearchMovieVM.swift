//
//  SearchMovieVM.swift
//  OMDB
//
//  Created by Halit Baskurt on 22.07.2023.
//

import Foundation

protocol SearchMovieVM {
    var stateClosure: ((ObservationType<SearchMovieVMImpl.Event, Error>) -> () )? { get set }
    func searchMovie(for query : String)
    func start()
    func setStartPage()
}

final class SearchMovieVMImpl: SearchMovieVM {
    
    var stateClosure: ((ObservationType<Event, Error>) -> ())?
    private let useCase: SearchMovieUseCase
    private var movieRows: [SearchMovieProviderImpl.MovieRowType] = []
    private var isSearchedBefore: Bool = false
    
    init(useCase:SearchMovieUseCase) {
        self.useCase = useCase
    }
    
    func start() {
        prepareUI()
    }
    
    private func prepareUI() {
        var sections: [SearchMovieProviderImpl.SectionType] = []
        
        if movieRows.isEmpty {
            if isSearchedBefore {
                sections.append(.empty(infoText: "Aradık aradık ama böyle bir film bulamadık 😕", textColor: .red))
            } else {
                sections.append(.empty(infoText: "Çok güzel filimlerim arasından ara bakalım bulabilecek misin ? \n 🤩"))
            }
        } else { sections.append(.movie(rows: movieRows)) }
        stateClosure?(.updateUI(.setProviderData(data: sections)))
    }
    
    private func appenMovieRows(with searchResult: SearchMovie) {
        searchResult.Search.forEach( { movieRows.append(.movieRow(movieItem: $0)) })
        prepareUI()
    }
    
    func searchMovie(for query:String) {
        movieRows.removeAll()
        isSearchedBefore = true
        useCase.searchMovie(query: query) { [weak self] result in
            switch result {
            case .success(let searchMovie):
                self?.appenMovieRows(with: searchMovie)
            case .failure: self?.prepareUI()
            }
        }
    }
    
    func setStartPage() {
        isSearchedBefore = false
        movieRows.removeAll()
        prepareUI()
    }
    
    enum Event {
        case setProviderData(data: [SearchMovieProviderImpl.SectionType])
    }
}
