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
    
    var updateHandler:(([Genre]) -> Void)?
    
    init() {
        interactor.moviesGenresObservable.subscribe { (genres) in
            self.updateHandler!(genres.element!)
            }.disposed(by: disposeBag)
        interactor.tvshowsGenresObservable.subscribe { (genres) in
            self.updateHandler!(genres.element!)
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
