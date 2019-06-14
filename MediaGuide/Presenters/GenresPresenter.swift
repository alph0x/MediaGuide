//
//  GenresPresenter.swift
//  MediaGuide
//
//  Created by Alfredo Pérez Leal on 06/06/2019.
//  Copyright © 2019 Alfredo Pérez Leal. All rights reserved.
//

import Foundation
import RxSwift

class GenresPresenter {
    
    let interactor = GenresInteractor()
    private let disposeBag = DisposeBag()
    
    var updateHandler:(([Genre]) -> Void)
    
    init() {
        updateHandler = {(genres) in}
        interactor.moviesGenresObservable.subscribe { (genres) in
            guard let elements = genres.element else { return }
            self.updateHandler(elements)
            }.disposed(by: disposeBag)
        interactor.tvshowsGenresObservable.subscribe { (genres) in
            guard let elements = genres.element else { return }
            self.updateHandler(elements)
            }.disposed(by: disposeBag)
    }
    
    func movieGenres(updateHandler: @escaping (([Genre]) -> Void)) {
        self.updateHandler = updateHandler
        interactor.movies()
    }
    
    func tvshowsGenres(updateHandler: @escaping (([Genre]) -> Void)) {
        self.updateHandler = updateHandler
        interactor.tvshow()
    }
}
