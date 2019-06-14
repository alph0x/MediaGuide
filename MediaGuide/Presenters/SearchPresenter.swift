//
//  SearchPresenter.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 12/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import Foundation
import RxSwift

class SearchPresenter {
    
    private let interactor = SearchInteractor()
    private let disposeBag = DisposeBag()
    
    var updateHandler:(([Media]) -> Void)
    
    init() {
        updateHandler = {(media) in}
        interactor.moviesSearchObservable.subscribe { (media) in
            guard let elements = media.element else { return }
            self.updateHandler(elements)
            }.disposed(by: self.disposeBag)
        interactor.moviesGenresObservable.subscribe { (movies) in
            guard let elements = movies.element else { return }
            self.updateHandler(elements)
            }.disposed(by: self.disposeBag)
        interactor.tvshowsSearchObservable.subscribe { (tvshows) in
            guard let elements = tvshows.element else { return }
            self.updateHandler(elements)
            }.disposed(by: self.disposeBag)
        interactor.tvshowsGenresObservable.subscribe { (tvshows) in
            guard let elements = tvshows.element else { return }
            self.updateHandler(elements)
            }.disposed(by: self.disposeBag)
    }
    
    func moviesSearch(with query:String, with updateHandler: @escaping (([Media]) -> Void)) {
        self.updateHandler = updateHandler
        interactor.movies(by: query)
    }
    
    func moviesGenre(with genre:Genre, with updateHandler: @escaping (([Media]) -> Void)) {
        self.updateHandler = updateHandler
        interactor.movies(with: genre)
    }
    
    func tvshowsSearch(with query:String, with updateHandler: @escaping (([Media]) -> Void)) {
        self.updateHandler = updateHandler
        interactor.tvshows(by: query)
    }
    
    func tvshowsGenre(with genre:Genre, with updateHandler: @escaping (([Media]) -> Void)) {
        self.updateHandler = updateHandler
        interactor.tvshows(with: genre)
    }
    

}
